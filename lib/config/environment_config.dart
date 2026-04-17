/// Environment Configuration
/// Supports dev, staging, prod Firebase projects
/// Run with: flutter run --dart-define=ENV=dev

enum Environment { dev, staging, prod }

class FirebaseConfig {
  final String projectId;
  final String apiKey;
  final String appId;
  final String messagingSenderId;
  final String databaseUrl;
  final String storageBucket;

  const FirebaseConfig({
    required this.projectId,
    required this.apiKey,
    required this.appId,
    required this.messagingSenderId,
    required this.databaseUrl,
    required this.storageBucket,
  });
}

class EnvironmentConfig {
  // App Metadata
  static const String appName = 'Flora Match';
  static const String appVersion = '1.0.0';
  static const String packageName = 'com.flora_match.ph';
  static const String appDescription = 'Marketplace for Plants & Garden';

  // Environment determination from build parameter
  static final Environment currentEnv = _parseEnvironment();

  static Environment _parseEnvironment() {
    const envStr = String.fromEnvironment('ENV', defaultValue: 'dev');
    switch (envStr.toLowerCase()) {
      case 'prod':
      case 'production':
        return Environment.prod;
      case 'staging':
        return Environment.staging;
      default:
        return Environment.dev;
    }
  }

  // Helper getters
  static bool get isDev => currentEnv == Environment.dev;
  static bool get isStaging => currentEnv == Environment.staging;
  static bool get isProd => currentEnv == Environment.prod;

  static FirebaseConfig get activeFirebaseConfig {
    return firebaseConfigs[currentEnv] ?? firebaseConfigs[Environment.dev]!;
  }

  // Firebase configuration (update with actual project IDs from GCP Console)
  static const Map<Environment, FirebaseConfig> firebaseConfigs = {
    Environment.dev: FirebaseConfig(
      projectId: 'flora-match-ph-dev',
      apiKey: 'AIzaSyxxxxxxxxxxxxxxxxxxxxxxxxxx',
      appId: '1:xxxxxxxxxxxxx:android:xxxxxxxxxxxxx',
      messagingSenderId: 'xxxxxxxxxxxxx',
      databaseUrl: 'https://flora-match-ph-dev.firebaseio.com',
      storageBucket: 'flora-match-ph-dev.appspot.com',
    ),
    Environment.staging: FirebaseConfig(
      projectId: 'flora-match-ph-staging',
      apiKey: 'AIzaSyxxxxxxxxxxxxxxxxxxxxxxxxxx',
      appId: '1:xxxxxxxxxxxxx:android:xxxxxxxxxxxxx',
      messagingSenderId: 'xxxxxxxxxxxxx',
      databaseUrl: 'https://flora-match-ph-staging.firebaseio.com',
      storageBucket: 'flora-match-ph-staging.appspot.com',
    ),
    Environment.prod: FirebaseConfig(
      projectId: 'flora-match-ph-prod',
      apiKey: 'AIzaSyxxxxxxxxxxxxxxxxxxxxxxxxxx',
      appId: '1:xxxxxxxxxxxxx:android:xxxxxxxxxxxxx',
      messagingSenderId: 'xxxxxxxxxxxxx',
      databaseUrl: 'https://flora-match-ph-prod.firebaseio.com',
      storageBucket: 'flora-match-ph-prod.appspot.com',
    ),
  };

  // Get current Firebase config
  static FirebaseConfig get currentFirebaseConfig =>
      firebaseConfigs[currentEnv]!;

  // Payment Gateway configuration (Xendit)
  static const Map<Environment, String> xenditApiKeys = {
    Environment.dev: 'xnd_development_xxxxxxxxxxxxxxxx', // Sandbox key
    Environment.staging: 'xnd_development_xxxxxxxxxxxxxxxx', // Sandbox key
    Environment.prod: 'xnd_production_xxxxxxxxxxxxxxxx', // Production key
  };

  static String get xenditApiKey => xenditApiKeys[currentEnv]!;

  // Sentry configuration
  static const Map<Environment, String> sentryDsns = {
    Environment.dev: 'https://key@sentry.io/xxxxx', // Dev DSN
    Environment.staging: 'https://key@sentry.io/xxxxx', // Staging DSN
    Environment.prod: 'https://key@sentry.io/xxxxx', // Prod DSN
  };

  static String get sentryDsn => sentryDsns[currentEnv]!;

  // Firebase Emulator configuration
  static const bool useFirebaseEmulator = true; // Set to false for production
  static const String firestoreEmulatorHost = 'localhost';
  static const int firestoreEmulatorPort = 8080;
  static const String authEmulatorHost = 'localhost';
  static const int authEmulatorPort = 9099;

  // API configuration
  static const String apiBaseUrl = 'https://api.flora-match.ph';
  static const Duration apiTimeout = Duration(seconds: 30);

  // Feature flags
  static const bool enablePushNotifications = true;
  static const bool enableAnalytics = true;
  static const bool enableCrashlytics = true;
  static const bool verboseLogging = true;

  // Session configuration
  static const Duration sessionTimeout = Duration(minutes: 15);
  static const Duration tokenRefreshThreshold = Duration(minutes: 5);

  // Market-specific configuration
  static const String countryCode = 'PH';
  static const String currencyCode = 'PHP';
  static const String supportedLanguages = 'en,tl'; // English, Tagalog
}