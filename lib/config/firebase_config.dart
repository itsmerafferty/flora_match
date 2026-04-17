/// Firebase initialization and configuration
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:flutter/foundation.dart';
import 'environment_config.dart';
import '../core/utils/logger.dart';

class FirebaseService {
  static Future<void> initialize() async {
    try {
      // Initialize Sentry first for error tracking
      await SentryFlutter.init(
        (options) {
          options.dsn = EnvironmentConfig.sentryDsn;
          options.environment = EnvironmentConfig.currentEnv.name;
          options.tracesSampleRate = 1.0;
          options.sendDefaultPii = false; // Don't send PII
          options.attachStacktrace = true;
        },
        appRunner: () async {
          // Initialize Firebase
          await _initializeFirebase();
        },
      );
    } catch (e, stackTrace) {
      logger.error('Failed to initialize services', e, stackTrace);
      rethrow;
    }
  }

  static Future<void> _initializeFirebase() async {
    try {
      // Initialize Firebase with appropriate configuration
      await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: EnvironmentConfig.currentFirebaseConfig.apiKey,
          appId: EnvironmentConfig.currentFirebaseConfig.appId,
          messagingSenderId:
              EnvironmentConfig.currentFirebaseConfig.messagingSenderId,
          projectId: EnvironmentConfig.currentFirebaseConfig.projectId,
          databaseURL: EnvironmentConfig.currentFirebaseConfig.databaseUrl,
          storageBucket: EnvironmentConfig.currentFirebaseConfig.storageBucket,
        ),
      );

      logger.info(
        'Firebase initialized for ${EnvironmentConfig.currentEnv.name} environment',
      );

      // Setup emulator if in dev mode
      if (EnvironmentConfig.isDev && EnvironmentConfig.useFirebaseEmulator) {
        await _setupEmulators();
      }

      // Setup Firestore
      await _setupFirestore();

      // Setup Crashlytics
      await _setupCrashlytics();

      logger.info('Firebase initialization complete');
    } catch (e, stackTrace) {
      logger.error('Firebase initialization failed', e, stackTrace);
      rethrow;
    }
  }

  static Future<void> _setupEmulators() async {
    try {
      final auth = FirebaseAuth.instance;
      final firestore = FirebaseFirestore.instance;

      // Connect to Auth Emulator
      if (kIsWeb) {
        // Web platform
        auth.useAuthEmulator('localhost', 9099);
      } else if (defaultTargetPlatform == TargetPlatform.android) {
        // Android emulator uses 10.0.2.2 to access host localhost
        auth.useAuthEmulator('10.0.2.2', 9099);
      } else {
        // iOS and other platforms
        auth.useAuthEmulator('localhost', 9099);
      }

      // Connect to Firestore Emulator
      if (kIsWeb) {
        firestore.useFirestoreEmulator('localhost', 8080);
      } else if (defaultTargetPlatform == TargetPlatform.android) {
        firestore.useFirestoreEmulator('10.0.2.2', 8080);
      } else {
        firestore.useFirestoreEmulator('localhost', 8080);
      }

      logger.info('Emulators connected successfully');
    } catch (e) {
      logger.warning('Failed to connect to emulators: $e');
      // Don't rethrow - emulators are optional
    }
  }

  static Future<void> _setupFirestore() async {
    try {
      final firestore = FirebaseFirestore.instance;

      // Configure Firestore settings
      firestore.settings = const Settings(
        persistenceEnabled: true,
        cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
      );

      logger.info('Firestore configured with offline persistence');
    } catch (e, stackTrace) {
      logger.error('Failed to setup Firestore', e, stackTrace);
      // Don't rethrow - continue without persistence
    }
  }

  static Future<void> _setupCrashlytics() async {
    try {
      // Disable Crashlytics in dev mode
      if (EnvironmentConfig.isDev) {
        await FirebaseCrashlytics.instance
            .setCrashlyticsCollectionEnabled(false);
        logger.info('Crashlytics disabled for dev environment');
        return;
      }

      // Enable Crashlytics in production
      await FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(true);

      // Pass all uncaught "fatal" errors from the framework to Crashlytics
      FlutterError.onError = (FlutterErrorDetails errorDetails) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      };

      // Pass all uncaught asynchronous errors to Crashlytics
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };

      logger.info('Crashlytics configured for ${EnvironmentConfig.currentEnv.name}');
    } catch (e, stackTrace) {
      logger.error('Failed to setup Crashlytics', e, stackTrace);
      // Don't rethrow - Crashlytics is optional
    }
  }
}
