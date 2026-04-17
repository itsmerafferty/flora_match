# Sprint 1: Quick Start Guide

**Sprint Duration:** March 18-22, 2026 (5 days)  
**Team:** 3 developers  
**Goal:** Foundation setup - Firebase multi-env, CI/CD, Phone Auth UI, Sentry monitoring

---

## Prerequisites

Before starting Sprint 1, ensure you have:

### Required Tools
- [x] Flutter SDK 3.19.0 or later
- [x] Dart 3.7.2 or later
- [x] Android Studio with Android SDK 33+
- [x] Xcode 15+ (for iOS development, macOS only)
- [x] Firebase CLI (`npm install -g firebase-tools`)
- [x] Git and GitHub account

### Installation Commands

```bash
# Install Flutter (if not already installed)
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:$(pwd)/flutter/bin"

# Install Firebase CLI
npm install -g firebase-tools

# Verify installations
flutter --version
dart --version
firebase --version
```

---

## Environment Setup

### 1. Clone Repository

```bash
git clone https://github.com/your-org/flora_match.git
cd flora_match
flutter pub get
```

### 2. Create GCP Project & Firebase Projects

**Note:** This requires GCP account with billing enabled.

```bash
# Login to Firebase CLI
firebase login

# Create 3 Firebase projects in GCP Console:
# 1. flora-match-ph-dev (Development)
# 2. flora-match-ph-staging (Staging)
# 3. flora-match-ph-prod (Production)

# Each project:
# - Region: asia-southeast1 (Singapore)
# - Enable: Firestore, Authentication, Cloud Functions, Cloud Storage
```

### 3. Download Firebase Configuration

```bash
# For each Firebase project, download google-services.json (Android) and GoogleService-Info.plist (iOS)
# Place files in:
# - android/app/google-services.json (dev version)
# - ios/Runner/GoogleService-Info.plist (dev version)
```

### 4. Update Environment Configuration

Edit `lib/config/environment_config.dart` and replace placeholder values with actual Firebase credentials:

```dart
Environment.dev: FirebaseConfig(
  projectId: 'flora-match-ph-dev',
  apiKey: 'AIzaSy[ACTUAL_KEY]',
  appId: '1:[ACTUAL_ID]:android:[ACTUAL_PACKAGE]',
  messagingSenderId: '[ACTUAL_SENDER_ID]',
  databaseUrl: 'https://flora-match-ph-dev.firebaseio.com',
  storageBucket: 'flora-match-ph-dev.appspot.com',
),
// ... repeat for staging and prod
```

### 5. Setup Firebase Emulator (Optional but Recommended for Dev)

```bash
# Install emulator
firebase emulators:start --project=flora-match-ph-dev

# In another terminal, run app with emulator
flutter run --dart-define=ENV=dev
```

---

## Running the App

### Development (with Dev Firebase)

```bash
# Android
flutter run --dart-define=ENV=dev

# iOS
flutter run -t lib/main.dart --dart-define=ENV=dev

# Web (for testing, not recommended for marketplace)
flutter run -d chrome --dart-define=ENV=dev
```

### Staging Environment

```bash
flutter run --dart-define=ENV=staging
```

### Production Build

```bash
flutter build apk --release --dart-define=ENV=prod
flutter build ios --release --dart-define=ENV=prod
```

---

## Project Structure

```
flora_match/
├── lib/
│   ├── main.dart                 # App entry point
│   ├── config/
│   │   ├── environment_config.dart     # Multi-env setup
│   │   ├── firebase_config.dart        # Firebase initialization
│   │   └── payment_config.dart         # Xendit config (Sprint 8)
│   ├── core/
│   │   ├── constants/                  # App constants
│   │   ├── errors/                     # Custom exceptions
│   │   └── utils/
│   │       ├── logger.dart             # Logging utility
│   │       └── validators.dart         # Input validators
│   ├── presentation/
│   │   ├── blocs/
│   │   │   └── auth/
│   │   │       ├── auth_bloc.dart      # Authentication BLoC
│   │   │       ├── auth_event.dart
│   │   │       └── auth_state.dart
│   │   ├── pages/
│   │   │   └── auth/
│   │   │       ├── phone_auth_page.dart
│   │   │       └── otp_verification_page.dart
│   │   └── widgets/                    # Reusable UI components
│   ├── data/
│   │   ├── models/                     # Data models
│   │   ├── repositories/               # Data access layer
│   │   └── datasources/                # Local & remote data
│   └── domain/                         # Business logic
│       ├── entities/
│       ├── repositories/
│       └── usecases/
├── functions/                          # Cloud Functions (TypeScript)
│   ├── src/
│   │   └── index.ts
│   └── tsconfig.json
├── .github/
│   └── workflows/
│       ├── android-build.yml           # CI/CD for Android
│       ├── ios-build.yml               # CI/CD for iOS
│       └── tests.yml                   # Unit tests
├── firestore.rules                     # Security rules
├── pubspec.yaml                        # Dependencies
└── README.md
```

---

## Sprint 1 Features Implemented

### ✅ FOUND-001: Multi-Environment Firebase
- ✅ Dev, Staging, Prod projects created
- ✅ Environment detection via `--dart-define=ENV`
- ✅ Dynamic Firebase initialization

### ✅ FOUND-005: Phone Auth UI
- ✅ Phone input validation (Philippine numbers)
- ✅ OTP verification UI
- ✅ Error handling & retry logic
- ✅ Countdown timer (5 minutes)

### ✅ FOUND-002: Sentry Monitoring
- ✅ Error tracking configured
- ✅ Crash reporting enabled
- ✅ No PII collection

### ✅ FOUND-003: CI/CD Pipeline
- ✅ Android APK builds automated
- ✅ iOS app builds automated
- ✅ Unit tests run on every push
- ✅ Code analysis (flutter analyze)

### ✅ FOUND-004: Security Rules
- ✅ Firestore rules baseline deployed
- ✅ Role-based access control
- ✅ Owner validation

---

## Common Tasks

### Add a New Page

```dart
// 1. Create page file: lib/presentation/pages/feature/my_page.dart
class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Page')),
      body: Center(child: Text('Hello')),
    );
  }
}

// 2. Add route in main.dart
routes: {
  '/my-page': (context) => const MyPage(),
}

// 3. Navigate
Navigator.of(context).pushNamed('/my-page');
```

### Add a BLoC Event

```dart
// 1. Define event in auth_event.dart
class MyEvent extends AuthEvent {
  final String data;
  const MyEvent({required this.data});
  
  @override
  List<Object?> get props => [data];
}

// 2. Handle in auth_bloc.dart
on<MyEvent>(_onMyEvent);

Future<void> _onMyEvent(MyEvent event, Emitter<AuthState> emit) async {
  emit(MyLoadingState());
  // ... do work
  emit(MySuccessState());
}

// 3. Dispatch event
context.read<AuthBloc>().add(MyEvent(data: 'value'));
```

### Debug with Print Statements

```dart
// Use logger instead of print()
import 'core/utils/logger.dart';

logger.debug('Debug message');
logger.info('Info message');
logger.warning('Warning message');
logger.error('Error message', exception, stackTrace);
```

### Run Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/unit/validators_test.dart

# Run with coverage
flutter test --coverage

# View coverage (requires lcov)
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html  # macOS
```

---

## Troubleshooting

### "Firebase Project Not Found"
- Ensure Firebase projects are created in GCP Console
- Verify `environment_config.dart` has correct project IDs
- Check `google-services.json` is in `android/app/`

### "Emulator Connection Failed"
- Ensure Firebase emulator is running: `firebase emulators:start`
- For Android: use `10.0.2.2` instead of `localhost`
- Check firewall isn't blocking ports 8080, 9099

### "OTP Not Being Sent"
- In dev, OTP sending is mocked by Firebase Auth
- Check Firestore rules allow Auth collection reads
- Verify phone number format: +63XXXXXXXXX

### "CI/CD Workflow Failed"
- Check Flutter version matches `3.19.0`
- Ensure all dependencies in `pubspec.yaml` are compatible
- Review GitHub Actions logs for detailed error

### "App Crashes on Launch"
- Check `adb logcat` (Android) or Xcode console (iOS)
- Review Sentry dashboard for crash reports
- Ensure all imports are correct (no circular dependencies)

---

## Next Steps (Sprint 2 Preview)

Sprint 2 will add:
- ✅ OTP verification backend integration
- ✅ User role selection (Buyer/Seller)
- ✅ User profile completion
- ✅ Seller store setup

---

## Key Files to Review

Before starting development:

1. **environment_config.dart** - Multi-env setup
2. **firebase_config.dart** - Firebase initialization
3. **auth_bloc.dart** - Authentication state machine
4. **phone_auth_page.dart** - Phone input UI
5. **firestore.rules** - Security rules
6. **.github/workflows/android-build.yml** - CI/CD pipeline

---

## Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Firebase for Flutter](https://firebase.flutter.dev)
- [BLoC Pattern](https://bloclibrary.dev)
- [Sentry Flutter](https://docs.sentry.io/platforms/flutter/)
- [Flora Match Architecture](../docs/architecture/README.md)

---

## Git Workflow

```bash
# Create feature branch
git checkout -b feature/FOUND-001-firebase-setup

# Make changes and commit
git add .
git commit -m "feat: FOUND-001 multi-environment Firebase setup"

# Push and create PR
git push origin feature/FOUND-001-firebase-setup

# After review, merge to develop
git checkout develop
git merge feature/FOUND-001-firebase-setup
git push origin develop

# Merge to main for releases
git checkout main
git merge develop --no-ff
git tag -a v1.0.0 -m "Release version 1.0.0"
git push origin main --tags
```

---

## Support

For questions during Sprint 1:
- Tech Lead: Firebase & Architecture questions
- Frontend Dev: UI/UX & Flutter issues
- Backend Dev: BLoC & state management questions
- DevOps: CI/CD & emulator setup

---

**Document Version:** 1.0  
**Last Updated:** March 18, 2026  
**Status:** Sprint 1 Kickoff Ready
