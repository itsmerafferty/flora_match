# Sprint 1 Execution Guide - Foundation & Project Setup

**Sprint Duration:** 5 Days (March 18-22, 2026)  
**Team:** 3 Developers  
**Sprint Velocity:** 32 Story Points  
**Goal:** Multi-environment Firebase setup, CI/CD pipeline, phone auth skeleton

---

## Sprint Overview

Sprint 1 focuses on establishing the technical foundation for Flora Match. By the end of this sprint, the project should have:
- Multi-environment Firebase configuration (dev/staging/prod)
- GitHub Actions CI/CD pipeline for Flutter builds
- Phone authentication skeleton
- Error monitoring with Sentry
- Local Firebase Emulator setup for testing

---

## Daily Standup Template

**Format:** 15 minutes, 9:00 AM  
**Questions:**
1. What did I complete yesterday?
2. What will I complete today?
3. What blockers do I have?

---

## Story Breakdown & Task Assignments

### Story: FOUND-001 - Multi-Environment Firebase Configuration (5 SP)
**Assignee:** Tech Lead  
**Duration:** 1.5 days  
**Priority:** Highest (blocks all other stories)

#### Tasks
- [ ] Create 3 Firebase projects in GCP console (dev, staging, prod)
  - Dev project: `flora-match-dev` (asia-southeast1)
  - Staging project: `flora-match-staging` (asia-southeast1)
  - Prod project: `flora-match-prod` (asia-southeast1)
- [ ] Download service account JSON for each project
- [ ] Create `.env.dev`, `.env.staging`, `.env.prod` files in `lib/config/`
- [ ] Implement dynamic Firebase initialization based on environment
  - Modify `firebase_config.dart` to load correct project based on `EnvironmentConfig`
  - Support command-line flag: `flutter run --dart-define=ENV=dev`
- [ ] Document Firebase project setup in FIREBASE_SETUP.md
- [ ] Verify multi-env switching by running on both iOS and Android

#### Acceptance Criteria
- ✅ `flutter run --dart-define=ENV=dev` initializes dev Firebase
- ✅ `flutter run --dart-define=ENV=staging` initializes staging Firebase
- ✅ Staging/prod Firebase projects accessible from iOS/Android
- ✅ No hardcoded API keys in source (all in `.env` files)
- ✅ Environment logged on app startup

#### Dependencies
- None

#### Risks
- GCP billing setup delays
- Firebase project creation delays in region asia-southeast1

---

### Story: FOUND-003 - GitHub Actions CI/CD Pipeline (3 SP)
**Assignee:** DevOps Engineer  
**Duration:** 1 day  
**Priority:** High

#### Tasks
- [ ] Create `.github/workflows/` directory
- [ ] Create Android build workflow: `.github/workflows/android-build.yml`
  - Trigger: `on: [push, pull_request]` to main/develop branches
  - Build steps:
    1. Setup Java JDK 17
    2. Setup Flutter
    3. Run `flutter pub get`
    4. Run `flutter analyze` (lint)
    5. Run `flutter build apk --dart-define=ENV=dev`
    6. Upload APK artifact (for testing)
- [ ] Create iOS build workflow: `.github/workflows/ios-build.yml`
  - Setup Xcode environment
  - Build steps similar to Android
  - Generate IPA (not required for CI, but show ability)
- [ ] Create test workflow: `.github/workflows/tests.yml`
  - Run `flutter test` for all unit tests
  - Generate coverage report
- [ ] Setup branch protection rules in GitHub
  - Require CI/CD to pass before merge
  - Require code review from tech lead
- [ ] Document CI/CD workflow in CICD.md

#### Acceptance Criteria
- ✅ Push to develop branch triggers CI/CD
- ✅ Android APK builds successfully on CI
- ✅ iOS build succeeds (or has clear error)
- ✅ Tests run automatically
- ✅ CI status visible on GitHub PR
- ✅ Failed builds block merges to main

#### Dependencies
- FOUND-001 must complete (Firebase env setup)

#### Risks
- iOS certificate/provisioning profile setup complexity
- GitHub Actions runner capacity

---

### Story: FOUND-002 - Sentry Error Monitoring & Analytics (3 SP)
**Assignee:** Tech Lead  
**Duration:** 1 day  
**Priority:** High

#### Tasks
- [ ] Create Sentry organization account at https://sentry.io
- [ ] Create 3 Sentry projects (dev, staging, prod)
- [ ] Add `sentry_flutter` package to `pubspec.yaml`
  ```yaml
  sentry_flutter: ^7.17.0
  ```
- [ ] Implement Sentry initialization in `main.dart`
  ```dart
  await SentryFlutter.init(
    (options) {
      options.dsn = 'YOUR_SENTRY_DSN';
      options.environment = EnvironmentConfig.currentEnv.name;
    },
    appRunner: () => runApp(const MyApp()),
  );
  ```
- [ ] Create error tracking for Firebase initialization failures
- [ ] Setup breadcrumb logging for auth events
- [ ] Configure Sentry to NOT send PII (user contact info)
- [ ] Create Sentry dashboard for alerts
  - Alert on error rate spike (>5% errors)
  - Alert on performance degradation (>3s load time)

#### Acceptance Criteria
- ✅ Sentry captures uncaught exceptions
- ✅ Errors appear in Sentry dashboard within 1 minute
- ✅ Environment correctly labeled (dev/staging/prod)
- ✅ No PII in error reports
- ✅ Alerts configured

#### Dependencies
- None (can run in parallel with FOUND-001)

#### Risks
- PII leakage if not carefully configured
- Sentry quota limits on free tier

---

### Story: FOUND-004 - Firebase Firestore Security Rules Baseline (3 SP)
**Assignee:** Tech Lead  
**Duration:** 1 day  
**Priority:** High

#### Tasks
- [ ] Create `firestore.rules` file in root directory
- [ ] Implement baseline security rules:
  ```firestore
  rules_version = '2';
  service cloud.firestore {
    match /databases/{database}/documents {
      // Allow authenticated users to read/write their own data
      match /users/{userId} {
        allow read, write: if request.auth.uid == userId;
      }
      
      // Products - public read, seller write
      match /products/{productId} {
        allow read: if true; // Public browsing
        allow create, update, delete: if request.auth.uid == resource.data.sellerId;
      }
      
      // More restrictive rules for sensitive collections
      match /payments/{paymentId} {
        allow read: if request.auth.uid in [resource.data.buyerId, resource.data.sellerId];
        allow write: if false; // Only backend writes
      }
      
      // Deny by default
      match /{document=**} {
        allow read, write: if false;
      }
    }
  }
  ```
- [ ] Deploy to all 3 Firebase projects (dev, staging, prod)
- [ ] Test security rules using Firebase Emulator
- [ ] Document security model in SECURITY.md

#### Acceptance Criteria
- ✅ Rules deployed to dev/staging/prod projects
- ✅ Users can only read/write their own profile
- ✅ Products are publicly readable
- ✅ Payments can only be read by buyer/seller
- ✅ Emulator tests pass

#### Dependencies
- FOUND-001 must complete

#### Risks
- Overly restrictive rules blocking legitimate queries
- Overly permissive rules creating security holes

---

### Story: FOUND-005 - Phone Auth UI Skeleton (5 SP)
**Assignee:** Frontend Developer  
**Duration:** 1.5 days  
**Priority:** High

#### Tasks
- [ ] Create `lib/presentation/pages/auth/` directory structure
- [ ] Create `phone_auth_page.dart` with UI:
  - Input field for phone number (with +63 prefix)
  - Validation: length 10-11 digits
  - "Send OTP" button (disabled until valid)
  - Loading indicator during submission
- [ ] Create `otp_verification_page.dart` with UI:
  - 6-digit OTP input field
  - Countdown timer (5 minutes)
  - "Resend OTP" button (enabled after 30s)
  - "Verify" button
  - Error message display
- [ ] Create `auth_bloc.dart` (Business Logic Component) to manage state
  ```dart
  abstract class AuthEvent {}
  class SendOTPEvent extends AuthEvent {
    final String phoneNumber;
  }
  class VerifyOTPEvent extends AuthEvent {
    final String otp;
  }
  
  abstract class AuthState {}
  class AuthInitial extends AuthState {}
  class SendingOTP extends AuthState {}
  class OTPSent extends AuthState {}
  class VerifyingOTP extends AuthState {}
  class AuthSuccess extends AuthState {}
  class AuthError extends AuthState {
    final String message;
  }
  ```
- [ ] Integrate Firebase Phone Authentication (backend calls only, no real auth yet)
- [ ] Add phone formatting utilities (`format_phone.dart`)
- [ ] Create responsive UI that works on all phone sizes

#### Acceptance Criteria
- ✅ Phone input validates format
- ✅ OTP input field appears after "Send OTP"
- ✅ Countdown timer counts down correctly
- ✅ "Resend OTP" button enabled after 30s
- ✅ BLoC emits correct state changes
- ✅ UI responsive on 320px - 600px widths
- ✅ No console errors/warnings

#### Dependencies
- None

#### Risks
- UI responsiveness issues on different screen sizes
- Timer implementation bugs

---

### Story: FOUND-007 - Firebase Emulator Setup & Local Testing (5 SP)
**Assignee:** DevOps Engineer  
**Duration:** 1.5 days  
**Priority:** Medium

#### Tasks
- [ ] Install Firebase Emulator Suite locally
  ```bash
  npm install -g firebase-tools
  firebase init emulators
  ```
- [ ] Configure `firebase.json` for local emulation
  - Enable: Firestore emulator (port 8080)
  - Enable: Auth emulator (port 9099)
  - Enable: Functions emulator (port 5001)
- [ ] Create `emulator-startup.sh` script to launch all emulators
- [ ] Configure Flutter app to connect to emulator in dev environment
  - Use localhost:8080 for Firestore (iOS: localhost, Android: 10.0.2.2)
  - Use localhost:9099 for Auth
- [ ] Create seed data script to populate test data
  - 5 test users (buyers/sellers)
  - 10 test products
  - 5 test orders
- [ ] Write emulator startup instructions in DEV_SETUP.md
- [ ] Create GitHub issue template for local setup problems

#### Acceptance Criteria
- ✅ `./emulator-startup.sh` launches all emulators
- ✅ Flutter app connects to local Firestore
- ✅ Test data populates correctly
- ✅ Auth emulator works with phone numbers
- ✅ Docs clear enough for new developer to setup locally
- ✅ All 3 platforms work (Android, iOS)

#### Dependencies
- FOUND-001 must complete

#### Risks
- Emulator port conflicts
- Platform-specific networking issues (especially Android)

---

### Story: FOUND-006 - Cloud Functions Boilerplate (3 SP)
**Assignee:** Backend Developer  
**Duration:** 1 day  
**Priority:** Medium

#### Tasks
- [ ] Review existing `functions/` directory structure
- [ ] Update `functions/tsconfig.json` to latest TypeScript
- [ ] Create `functions/src/index.ts` with Firebase Functions setup
  ```typescript
  import * as functions from 'firebase-functions';
  import * as admin from 'firebase-admin';
  
  admin.initializeApp();
  
  export const onUserCreated = functions
    .region('asia-southeast1')
    .auth.user()
    .onCreate(async (user) => {
      console.log(`User created: ${user.uid}`);
      // TODO: Initialize user profile in Firestore
    });
  ```
- [ ] Create utils directory: `functions/src/utils/`
  - `firestore.ts` - Firestore utilities
  - `auth.ts` - Auth utilities
  - `logging.ts` - Structured logging
- [ ] Setup Firebase Functions emulator
- [ ] Create deployment script for all environments
- [ ] Setup GitHub secret for Firebase CLI token

#### Acceptance Criteria
- ✅ Functions compile without errors
- ✅ Functions can be run locally via emulator
- ✅ Logging works with structured format
- ✅ Can deploy to dev/staging/prod via script
- ✅ No sensitive keys in source

#### Dependencies
- FOUND-001 must complete (Firebase setup)

#### Risks
- Functions emulator setup complexity
- Node.js version compatibility

---

### Story: FOUND-008 - Database Migration Strategy (5 SP)
**Assignee:** Backend Developer  
**Duration:** 1.5 days  
**Priority:** Medium

#### Tasks
- [ ] Create `migrations/` directory in project root
- [ ] Design migration version system:
  - Format: `YYYY-MM-DD_description.ts`
  - Version tracking in Firestore: `_metadata/migrations`
- [ ] Create migration runner script: `scripts/run-migrations.sh`
  ```bash
  firebase --project=$PROJECT functions:shell
  // In shell: await runMigrations()
  ```
- [ ] Create sample migration: `migrations/2026-03-18_initial_schema.ts`
  - Creates initial Firestore collections
  - Sets up security rules
- [ ] Implement rollback capability (if possible)
- [ ] Test migration on dev environment
- [ ] Document migration process in MIGRATIONS.md

#### Acceptance Criteria
- ✅ Migration runs successfully on dev
- ✅ Next run skips already-run migrations
- ✅ Migration version tracked in Firestore
- ✅ Rollback process documented
- ✅ Can be automated in CI/CD

#### Dependencies
- FOUND-006 (Cloud Functions) must complete

#### Risks
- Data consistency during migration
- Rollback complexity

---

## Story Point Breakdown

| Story | Points | Task Count | Status |
|-------|--------|-----------|--------|
| FOUND-001 | 5 | 5 | Not Started |
| FOUND-002 | 3 | 5 | Not Started |
| FOUND-003 | 3 | 5 | Not Started |
| FOUND-004 | 3 | 4 | Not Started |
| FOUND-005 | 5 | 7 | Not Started |
| FOUND-006 | 3 | 6 | Not Started |
| FOUND-007 | 5 | 7 | Not Started |
| FOUND-008 | 5 | 6 | Not Started |
| **TOTAL** | **32** | **45** | - |

---

## Day-by-Day Schedule

### Day 1 (Monday, March 18)
- **Team Standup:** 9:00 AM
- **Planning Session:** 9:15 AM - Review Sprint 1 goals
- **Dev Work:**
  - **Tech Lead:** Start FOUND-001 (Firebase multi-env)
  - **Frontend:** Start FOUND-005 (Phone auth UI)
  - **DevOps:** Start FOUND-002 (Sentry setup) + FOUND-003 (CI/CD)
- **End of Day Sync:** 5:00 PM - Blockers check

### Day 2 (Tuesday, March 19)
- **Standup:** 9:00 AM
- **Dev Work:**
  - **Tech Lead:** Complete FOUND-001, start FOUND-004 (Security rules)
  - **Frontend:** Continue FOUND-005
  - **DevOps:** Complete FOUND-003, help with FOUND-007
  - **Backend:** Start FOUND-006 (Cloud Functions)
- **Code Review:** 3:00 PM - Review FOUND-001

### Day 3 (Wednesday, March 20)
- **Standup:** 9:00 AM
- **Dev Work:**
  - **Tech Lead:** Complete FOUND-004, review FOUND-006
  - **Frontend:** Complete FOUND-005 (should have MVP phone auth UI)
  - **DevOps:** Complete FOUND-007 (Emulator setup)
  - **Backend:** Complete FOUND-006, start FOUND-008
- **Code Review:** 4:00 PM - Review FOUND-005

### Day 4 (Thursday, March 21)
- **Standup:** 9:00 AM
- **Dev Work:**
  - **Tech Lead:** Help finalize any blockers
  - **Frontend:** Integrate BLoC with FOUND-002 logging
  - **DevOps:** Setup CI/CD for all stories
  - **Backend:** Continue FOUND-008, test migrations
- **Integration Testing:** 2:00 PM - Test multi-env setup end-to-end

### Day 5 (Friday, March 22)
- **Standup:** 9:00 AM
- **Sprint Review:** 10:00 AM
  - Demo FOUND-001: Multi-env Firebase working
  - Demo FOUND-003: CI/CD pipeline running
  - Demo FOUND-005: Phone auth UI
  - Demo FOUND-007: Emulator launching successfully
- **Sprint Retro:** 11:30 AM
  - What went well?
  - What could improve?
  - Action items for Sprint 2
- **Buffer Time:** 2:00 PM - Fix any last-minute issues
- **Sprint Planning (Sprint 2):** 3:00 PM - Kickoff Sprint 2

---

## Definition of Done Checklist

For each story to be considered DONE:
- [ ] All acceptance criteria met
- [ ] Code reviewed and approved by 1 peer
- [ ] Merged to `develop` branch
- [ ] CI/CD pipeline passes
- [ ] No console warnings/errors
- [ ] Documentation updated (README/CONTRIBUTING)
- [ ] Demo-ready by Friday standup

---

## Risk Management

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|-----------|
| GCP Firebase project creation blocked | Low | High | Create projects on Day 1 morning; escalate to Firebase support if needed |
| iOS build complexity | Medium | Medium | DevOps focuses on Android first; iOS can be secondary |
| Emulator setup issues on Android | High | Medium | Pre-test on multiple Android versions; provide Docker container as fallback |
| Phone Auth quota limits | Low | High | Monitor quota; request increase proactively |

---

## Success Criteria for Sprint 1

✅ **Must Have:**
- Multi-environment Firebase setup working for all 3 environments
- CI/CD pipeline building APK on every push
- Phone auth UI complete (no backend verification yet)
- Sentry monitoring collecting errors
- Firebase Emulator launching successfully

⚠️ **Should Have:**
- iOS builds working in CI/CD
- Migration system ready for Sprint 2

❌ **Won't Have:**
- Actual OTP sending (backend integration - Sprint 2)
- User profiles creation (Sprint 3)
- Product listings (Sprint 4)

---

## Blockers & Escalation

**Escalation Path:**
1. Report blocker in standup
2. Tech Lead investigates (max 30 min)
3. If unresolved, escalate to Product Manager
4. Document in `SPRINT_1_BLOCKERS.md`

---

## Deliverables

By end of Sprint 1, deliver:
- [ ] `docs/FIREBASE_SETUP.md` - Firebase multi-env setup guide
- [ ] `docs/CICD.md` - CI/CD pipeline documentation
- [ ] `docs/DEV_SETUP.md` - Local development setup
- [ ] `docs/MIGRATIONS.md` - Database migration process
- [ ] `docs/SECURITY.md` - Security rules documentation
- [ ] `.github/workflows/*.yml` - CI/CD workflows
- [ ] `lib/presentation/pages/auth/` - Phone auth UI
- [ ] `firestore.rules` - Security rules file
- [ ] `functions/src/` - Cloud Functions boilerplate
- [ ] Video walkthrough of local setup (5 min)

---

## Next Steps (Sprint 2)

Sprint 2 will focus on:
- **AUTH-001:** Implement actual OTP verification
- **AUTH-002:** OTP countdown timer UI
- **AUTH-003:** User role assignment
- **AUTH-004:** Role selection screen
- **FOUND-008:** Complete migration system

---

**Sprint 1 Kickoff Date:** March 18, 2026  
**Sprint 1 End Date:** March 22, 2026  
**Document Version:** 1.0
