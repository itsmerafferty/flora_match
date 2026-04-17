# Flora Match: Philippines Marketplace MVP

![Status](https://img.shields.io/badge/Status-Sprint%201%20Active-blue)
![Version](https://img.shields.io/badge/Version-1.0.0--sprint1-green)
![Flutter](https://img.shields.io/badge/Flutter-3.19.0-blue)
![Dart](https://img.shields.io/badge/Dart-3.7.2-blue)
![License](https://img.shields.io/badge/License-Proprietary-red)

**Flora Match** is a full-featured marketplace application targeting the Philippines market, similar to Shopee/Lazada. Built with Flutter, Firebase, and modern development practices.

---

## 🚀 Quick Start (5 minutes)

```bash
# Clone repository
git clone https://github.com/your-org/flora_match.git
cd flora_match

# Install dependencies
flutter pub get

# Run in development environment
flutter run --dart-define=ENV=dev
```

**Default Route:** Phone Authentication Page  
**Phone Number (Test):** 09XX XXX XXXX (any valid PH format)

See [SPRINT_1_QUICKSTART.md](SPRINT_1_QUICKSTART.md) for detailed setup instructions.

---

## 📋 Project Overview

### What is Flora Match?

A **Shopee/Lazada-style marketplace** specializing in plants, seeds, garden tools, and supplies for the Philippines market.

### Key Features

#### 🛍️ Buyer Features (Sprints 1-7)
- Phone + OTP authentication
- Product browsing & search
- Shopping cart & wishlist
- Checkout with multiple payment methods
- Order tracking & delivery confirmation
- Reviews & ratings
- Refund requests & disputes

#### 🏪 Seller Features (Sprints 1-7)
- Store setup & management
- Product listing & inventory management
- Order fulfillment workflow
- Real-time earnings dashboard
- Payment settlement (7-day hold)
- Seller analytics & performance metrics

#### 💳 Payment Integration (Sprint 8)
- **Xendit** (recommended): GCash, Debit/Credit Card, Bank Transfer
- **COD (Cash on Delivery):** Backup for non-digital users
- Seller wallet & payout system
- Automatic settlement & reconciliation

#### 📦 Logistics (Sprint 11)
- J&T Shipping integration
- Real-time order tracking
- Proof of delivery
- COD confirmation & payment

---

## 📁 Project Structure

```
flora_match/
├── lib/
│   ├── main.dart                          # App entry point
│   ├── config/
│   │   ├── environment_config.dart        # Multi-env setup (dev/staging/prod)
│   │   ├── firebase_config.dart           # Firebase initialization
│   │   └── payment_config.dart            # Payment gateway config
│   ├── core/
│   │   ├── constants/                     # App constants
│   │   ├── errors/                        # Custom exceptions
│   │   └── utils/
│   │       ├── logger.dart                # Logging utility
│   │       └── validators.dart            # Input validators
│   ├── presentation/
│   │   ├── blocs/                         # BLoC state management
│   │   │   └── auth/
│   │   │       ├── auth_bloc.dart
│   │   │       ├── auth_event.dart
│   │   │       └── auth_state.dart
│   │   ├── pages/                         # Full-screen pages
│   │   │   └── auth/
│   │   │       ├── phone_auth_page.dart
│   │   │       └── otp_verification_page.dart
│   │   └── widgets/                       # Reusable UI components
│   ├── data/
│   │   ├── models/                        # Data models
│   │   ├── repositories/                  # Data access layer
│   │   └── datasources/                   # Local & remote data
│   └── domain/                            # Business logic (clean architecture)
│       ├── entities/
│       ├── repositories/
│       └── usecases/
├── functions/                             # Cloud Functions (TypeScript)
│   ├── src/
│   │   ├── index.ts                       # Function entry points
│   │   └── utils/                         # Firestore, auth, logging
│   └── tsconfig.json
├── .github/
│   └── workflows/                         # CI/CD automation
│       ├── android-build.yml              # Android builds
│       ├── ios-build.yml                  # iOS builds
│       └── tests.yml                      # Unit tests & analysis
├── docs/
│   ├── roadmap/
│   │   ├── SPRINT_PLAN_12_WEEKS.md        # Complete 12-week plan
│   │   ├── SPRINT_1_EXECUTION_GUIDE_DETAILED.md
│   │   ├── ph_12_week_sprints.md          # Sprint breakdowns
│   │   └── [Sprint 2-12 plans]
│   ├── architecture/
│   │   ├── FIREBASE_SCHEMA_COMPLETE.md    # Database design
│   │   ├── PAYMENT_PROVIDER_MATRIX_PH.md  # Payment options
│   │   ├── firestore_security_rules.md    # Security rules reference
│   │   └── README.md                      # Architecture overview
│   └── DEV_GUIDE.md                       # Developer guide
├── test/
│   ├── unit/                              # Unit tests
│   └── widget/                            # Widget tests
├── firestore.rules                        # Firestore security rules
├── pubspec.yaml                           # Flutter dependencies
├── analysis_options.yaml                  # Linting rules
├── README.md                              # This file
├── SPRINT_1_QUICKSTART.md                 # Sprint 1 setup guide
├── SPRINT_1_EXECUTION_GUIDE.md            # Sprint 1 planning
├── SPRINT_1_IMPLEMENTATION_SUMMARY.md     # Sprint 1 summary
└── .gitignore
```

---

## 🛠️ Technology Stack

### Frontend
- **Flutter 3.19.0** - Cross-platform UI framework
- **Dart 3.7.2** - Programming language
- **flutter_bloc 8.1.5** - State management
- **firebase_auth 5.2.0** - Phone/OTP authentication
- **cloud_firestore 5.4.0** - Real-time database

### Backend
- **Firebase Firestore** - NoSQL database (15 collections)
- **Firebase Cloud Functions** - Backend logic (TypeScript)
- **Firebase Cloud Storage** - Product images & documents

### Payment
- **Xendit** - Payment gateway (GCash, Card, Bank Transfer)
- **COD System** - Cash on delivery backup

### Monitoring
- **Sentry** - Error tracking & crash reporting
- **Firebase Crashlytics** - Native crash tracking
- **Firebase Analytics** - User behavior tracking

### DevOps
- **GitHub Actions** - CI/CD automation
- **Firebase Emulator** - Local development
- **Google Cloud** - Infrastructure

---

## 📊 Database Schema

### Core Collections (15)

1. **users** - User profiles & KYC
2. **stores** - Seller shop information
3. **products** - Product listings & catalog
4. **inventory** - Real-time stock levels
5. **carts** - Temporary shopping carts
6. **orders** - Customer orders (SSOT)
7. **orderItems** - Order line items (normalized)
8. **payments** - Payment transactions (Xendit)
9. **shipments** - Shipping & tracking
10. **refunds** - Refund requests & processing
11. **disputes** - Escalated order issues
12. **reviews** - Product & seller reviews
13. **wallets** - Seller payment wallets
14. **settlements** - Historical payouts
15. **transactions** - Wallet transaction ledger

See [FIREBASE_SCHEMA_COMPLETE.md](docs/architecture/FIREBASE_SCHEMA_COMPLETE.md) for detailed schema.

---

## 🔐 Security

### Authentication
- ✅ Phone OTP (Firebase Authentication)
- ✅ E.164 phone number validation
- ✅ 5-minute OTP expiry
- ✅ Rate limiting (Sprint 2)

### Authorization (Firestore Rules)
- ✅ Owner-based access control (users can only read/write own data)
- ✅ Public read (products, reviews, stores)
- ✅ Seller write (products, inventory)
- ✅ Role-based (buyer, seller, admin)
- ✅ System-only writes (payments, settlements)

### Data Protection
- ✅ Encrypted sensitive fields (bank details, TIN)
- ✅ No PII in error logs
- ✅ HTTPS only for all API calls
- ✅ PDPA compliance (Philippines data privacy)

---

## 💳 Payment Methods

### Primary: Xendit

| Method | Fee | Settlement | Support |
|--------|-----|-----------|---------|
| GCash | 3% | 1-3 days | ✅ Excellent |
| Debit/Credit Card | 3.05% | 1-3 days | ✅ Excellent |
| Bank Transfer (BDO/Metrobank/BPI) | 2% | 1-3 days | ✅ Excellent |

### Secondary: COD (Cash on Delivery)
- 0% fee
- 1-2 day settlement (via courier)
- Manual verification
- Backup for non-digital users

### Why Xendit?
- **GCash Integration:** Native PH payment method (61% user adoption)
- **Fastest Approval:** 1-2 days vs Midtrans 3-5 days
- **Lowest Fees:** 2.7% effective vs Midtrans 3.2%
- **Fastest Settlement:** 1-3 days to seller bank account
- **PH Support Team:** 24/7 localized support

---

## 📱 Supported Platforms

### Mobile
- ✅ **Android 10+** (API Level 29+)
- ✅ **iOS 12+**

### Web (Future)
- ⏳ **Web** - Flutter Web (not in MVP)

### Tablet Support
- ✅ Responsive design for 7"-12" screens

---

## 🏃 Development Workflow

### Environment Commands

```bash
# Development (with emulator)
flutter run --dart-define=ENV=dev

# Staging
flutter run --dart-define=ENV=staging

# Production (release build)
flutter build apk --release --dart-define=ENV=prod
flutter build ios --release --dart-define=ENV=prod
```

### Git Workflow

```bash
# Create feature branch
git checkout -b feature/FOUND-001-description

# Commit frequently
git commit -m "feat: FOUND-001 description of change"

# Push and create PR
git push origin feature/FOUND-001-description

# After review, merge to develop
git checkout develop && git merge --squash feature/FOUND-001-description
git push origin develop

# Release to production
git checkout main && git merge --ff-only develop
git tag -a v1.0.0 -m "Release version 1.0.0"
git push origin main --tags
```

### Code Quality

```bash
# Analyze code
flutter analyze

# Run tests
flutter test

# Generate coverage
flutter test --coverage

# Format code
dart format lib/

# Custom linting
flutter pub get && flutter analyze --no-pub
```

---

## 📈 12-Week Development Roadmap

### Phase 0: Foundation (Weeks 1-2) ✅ COMPLETE
- ✅ Multi-environment Firebase setup
- ✅ CI/CD pipeline (Android/iOS)
- ✅ Phone authentication UI
- ✅ Sentry monitoring
- ✅ Security rules baseline

### Phase 1: Commerce MVP (Weeks 3-7) - IN PROGRESS
- Auth workflow completion (Sprint 2)
- Buyer profile & onboarding (Sprint 3)
- Product management (Sprint 4)
- Shopping cart & checkout (Sprint 5-6)
- Seller dashboard (Sprint 7)

### Phase 2: Payments & Settlement (Weeks 8-10)
- Xendit payment integration (Sprint 8)
- Settlement reconciliation (Sprint 9)
- Refunds & disputes (Sprint 10)

### Phase 3: Logistics & Launch (Weeks 11-12)
- Shipping integration (Sprint 11)
- Reviews & analytics (Sprint 11)
- Security audit & optimization (Sprint 12)
- App store submission (Sprint 12)

**Complete roadmap:** [SPRINT_PLAN_12_WEEKS.md](docs/roadmap/SPRINT_PLAN_12_WEEKS.md)

---

## 📚 Documentation

| Document | Purpose | Audience |
|----------|---------|----------|
| [SPRINT_1_QUICKSTART.md](SPRINT_1_QUICKSTART.md) | 5-minute setup guide | All developers |
| [SPRINT_1_EXECUTION_GUIDE_DETAILED.md](docs/roadmap/SPRINT_1_EXECUTION_GUIDE_DETAILED.md) | Sprint 1 planning & tasks | Scrum team |
| [SPRINT_PLAN_12_WEEKS.md](docs/roadmap/SPRINT_PLAN_12_WEEKS.md) | Complete roadmap with stories | Product & Tech Lead |
| [FIREBASE_SCHEMA_COMPLETE.md](docs/architecture/FIREBASE_SCHEMA_COMPLETE.md) | Database design & queries | Backend developers |
| [PAYMENT_PROVIDER_MATRIX_PH.md](docs/architecture/PAYMENT_PROVIDER_MATRIX_PH.md) | Payment options comparison | Tech Lead & Finance |
| [DEV_GUIDE.md](docs/DEV_GUIDE.md) | Development standards & practices | All developers |

---

## 🐛 Troubleshooting

### "Phone number not validated"
- Ensure format: 09XX XXX XXXX or +63 9XX XXX XXXX
- See [validators.dart](lib/core/utils/validators.dart)

### "Firebase project not found"
- Verify Firebase projects created in GCP Console
- Check `environment_config.dart` has correct project IDs
- Ensure `google-services.json` is in `android/app/`

### "Emulator connection failed"
- Start emulator: `firebase emulators:start`
- For Android: use `10.0.2.2` instead of `localhost`
- Check ports 8080 (Firestore) and 9099 (Auth) are available

### "Build fails with dependency error"
- Run: `flutter clean && flutter pub get`
- Check `pubspec.yaml` for version conflicts
- Review `pubspec.lock` for dependency issues

### "App crashes on startup"
- Check Android Logcat: `adb logcat`
- Check iOS Console in Xcode
- Review Sentry dashboard for error details

---

## 🤝 Contributing

### Code Style
- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use `dart format` for formatting
- Run `flutter analyze` for linting
- Aim for 70%+ test coverage

### Pull Request Process
1. Create feature branch: `feature/STORY-ID-description`
2. Implement feature with tests
3. Run `flutter analyze && flutter test`
4. Create PR with description linking to story
5. Request review from tech lead
6. Address feedback and iterate
7. Merge after approval

### Commit Messages
```
feat: STORY-ID brief description
fix: STORY-ID brief description
docs: Update README
test: Add tests for feature X
refactor: Clean up auth logic
style: Format code with dart format
```

---

## 📞 Support

### Team Contacts
- **Tech Lead (Architecture):** tech-lead@flora-match.ph
- **Frontend Dev (UI/Flutter):** frontend@flora-match.ph
- **Backend Dev (BLoC/Functions):** backend@flora-match.ph
- **DevOps (CI/CD/Infra):** devops@flora-match.ph

### Resources
- [Flutter Documentation](https://flutter.dev)
- [Firebase for Flutter](https://firebase.flutter.dev)
- [BLoC Pattern](https://bloclibrary.dev)
- [Xendit Documentation](https://xendit.co/ph)
- [Sentry for Flutter](https://docs.sentry.io/platforms/flutter/)

---

## 📄 License

**Proprietary** - Flora Match is proprietary software. Unauthorized copying or distribution is prohibited.

---

## ✅ Sprint 1 Status

| Component | Status | Notes |
|-----------|--------|-------|
| Multi-env Firebase | ✅ Complete | Dev, Staging, Prod ready |
| Phone Auth UI | ✅ Complete | Input & OTP verification |
| CI/CD Pipeline | ✅ Complete | Android, iOS, Tests |
| Sentry Monitoring | ✅ Complete | Error tracking setup |
| Firestore Rules | ✅ Complete | 15+ security rules |
| Documentation | ✅ Complete | 5 comprehensive docs |

**Sprint 1 Review:** March 22, 2026  
**Sprint 2 Kickoff:** March 24, 2026

---

## 🎯 Next Steps

### For New Developers
1. Read [SPRINT_1_QUICKSTART.md](SPRINT_1_QUICKSTART.md)
2. Setup local environment (30 min)
3. Run `flutter run --dart-define=ENV=dev`
4. Test phone auth flow
5. Review code in `lib/presentation/`

### For Team
1. Attend Sprint 1 standup (daily @ 9:00 AM)
2. Review this README & architecture docs
3. Setup Firebase & emulator
4. Start development!

---

**Version:** 1.0.0-sprint1  
**Last Updated:** March 18, 2026  
**Status:** ✅ Sprint 1 Complete - Ready for Sprint 2

---

**Questions?** See [SPRINT_1_QUICKSTART.md](SPRINT_1_QUICKSTART.md) or contact Tech Lead.
