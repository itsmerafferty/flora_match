import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'config/firebase_config.dart';
import 'config/environment_config.dart';
import 'core/utils/logger.dart';
import 'presentation/blocs/auth/auth_bloc.dart';
import 'presentation/pages/auth/phone_auth_page.dart';
import 'presentation/pages/auth/otp_verification_page.dart';
import 'presentation/pages/onboarding/role_selection_page.dart';
import 'presentation/pages/home/buyer_home_page.dart';
import 'presentation/pages/home/seller_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Firebase and Sentry
    await FirebaseService.initialize();
    logger.info(
      'Firebase initialized in ${EnvironmentConfig.currentEnv.name} environment',
    );
  } catch (e, stackTrace) {
    logger.error(
      'Failed to initialize Firebase',
      e,
      stackTrace,
    );
    rethrow;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        // Add other BLoCs here as features are developed
      ],
      child: MaterialApp(
        title: EnvironmentConfig.appName,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
          ),
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.green[700],
            foregroundColor: Colors.white,
          ),
        ),
        home: const SplashPage(),
        routes: {
          '/phone-auth': (context) => const PhoneAuthPage(),
          '/otp-verify': (context) {
            final verificationId =
                ModalRoute.of(context)!.settings.arguments as String;
            return OTPVerificationPage(verificationId: verificationId);
          },
          '/role-selection': (context) => const RoleSelectionPage(),
          '/buyer-home': (context) => const BuyerHomePage(),
          '/seller-home': (context) => const SellerHomePage(),
        },
        debugShowCheckedModeBanner: EnvironmentConfig.isDev,
        navigatorObservers: [
          SentryNavigatorObserver(),
        ],
      ),
    );
  }
}

/// Splash page - Entry point while app initializes
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // TODO: Check Firebase Auth state and navigate accordingly
    // For now, go to phone auth
    Navigator.of(context).pushReplacementNamed('/phone-auth');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                Icons.eco,
                size: 60,
                color: Colors.green[700],
              ),
            ),
            const SizedBox(height: 24),

            // App Name
            Text(
              EnvironmentConfig.appName,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),

            // Tagline
            Text(
              EnvironmentConfig.appDescription,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
            ),

            // Environment indicator (visible in dev only)
            if (EnvironmentConfig.isDev) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.yellow[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'ENV: ${EnvironmentConfig.currentEnv.name.toUpperCase()}',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.orange[900],
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],

            const SizedBox(height: 40),

            // Loading indicator
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
