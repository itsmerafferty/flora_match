# Flora Match - Getting Started Guide (Phase 0)

**Created:** March 18, 2026 | **Target Launch:** June 2026 (12 weeks)  
**Market:** Philippines | **Team:** 3 developers | **Sprint Duration:** 5 days

---

## 🚀 Quick Launch Checklist

- [ ] **Week 1 Mon:** Kickoff meeting, project setup
- [ ] **Week 1 Wed:** Firebase projects created (dev/staging/prod)
- [ ] **Week 1 Fri:** Team can run app locally
- [ ] **Week 2 Fri:** Phase 0 complete, ready for Phase 1

---

## 📋 Phase 0: Foundation (Weeks 1–2)

### What We're Building This Week

**Goal:** Set up the infrastructure, Firebase, authentication skeleton, and development environment so the team can start building features.

**Not in Scope (Yet):**
- ❌ Buyer/seller features
- ❌ Payments
- ❌ Orders

**In Scope:**
- ✅ Project structure (clean architecture)
- ✅ Firebase setup (dev/staging/prod projects)
- ✅ Authentication skeleton (phone OTP)
- ✅ CI/CD pipeline
- ✅ Error handling & logging
- ✅ Team onboarded

---

## 🛠️ Setup Instructions (For Each Developer)

### Step 1: Clone & Install (30 min)

```bash
# 1a. Clone repository
git clone https://github.com/your-org/flora_match.git
cd flora_match

# 1b. Install Flutter dependencies
flutter pub get

# 1c. Generate Hive models (code generation)
flutter pub run build_runner build

# 1d. Check Flutter setup
flutter doctor -v
```

**Output should show:**
- ✅ Flutter SDK (3.7+)
- ✅ Android toolchain (if developing for Android)
- ✅ Xcode (if developing for iOS)
- ✅ VS Code / Android Studio

### Step 2: Firebase Configuration (45 min)

**⚠️ Tech Lead does this once:**

```bash
# 2a. Log in to Firebase
firebase login

# 2b. Create projects (if not existing)
firebase projects:create flora-match-ph-dev
firebase projects:create flora-match-ph-staging
firebase projects:create flora-match-ph-prod

# 2c. List available projects
firebase projects:list

# 2d. Set default project to dev
firebase use flora-match-ph-dev

# 2e. Enable required services in Firebase Console:
# - Authentication (Phone sign-in)
# - Firestore Database
# - Cloud Storage
# - Cloud Functions
# - Cloud Scheduler
```

**Each Developer then runs:**

```bash
# 2f. Configure flutterfire for dev environment
flutterfire configure \
  --project=flora-match-ph-dev \
  --ios-out=ios/Runner \
  --android-out=android/app \
  --platforms=android,ios,web

# This creates:
# - lib/firebase_options.dart (DO NOT COMMIT sensitive data)
# - google-services.json (Android)
# - GoogleService-Info.plist (iOS)
```

### Step 3: Run the App (15 min)

```bash
# 3a. Get available devices
flutter devices

# 3b. Run on emulator/device
flutter run -d <device-id>

# Expected output:
# - Splash screen with Flora Match logo
# - App initializes Firebase
# - (No auth page yet - just testing setup)
```

### Step 4: Verify Firebase Connection (10 min)

```bash
# 4a. Start Firebase emulator (for local testing)
firebase emulators:start

# 4b. In a new terminal, run app connected to emulator
export FIREBASE_EMULATOR_HOST=localhost:8080
flutter run

# 4c. Check emulator UI at: http://localhost:4000
```

---

## 📂 Project Structure Overview

```
flora_match/
├── lib/
│   ├── main.dart                           # Entry point (updated)
│   ├── config/                             # Configuration
│   │   ├── environment_config.dart         # Dev/staging/prod
│   │   ├── firebase_config.dart            # Firebase init
│   │   └── payment_config.dart             # Payment constants
│   ├── core/                               # Core utilities
│   │   ├── constants/
│   │   │   └── app_constants.dart          # App-wide constants
│   │   ├── errors/
│   │   │   └── exceptions.dart             # Exception classes
│   │   └── utils/
│   │       └── logger.dart                 # Logging utility
│   ├── features/                           # Feature modules (will grow)
│   └── shared/                             # Shared components
├── docs/
│   ├── architecture/
│   │   ├── firebase_schema.md              # Database design
│   │   ├── firestore_security_rules.md     # Security rules
│   │   ├── payment_provider_matrix_ph.md   # Payment comparison
│   │   └── README.md                       # Architecture overview
│   ├── roadmap/
│   │   └── ph_12_week_sprints.md           # Full sprint plan
│   └── DEV_GUIDE.md                        # Development guide
├── functions/                              # Cloud Functions (Node.js)
│   ├── src/
│   │   └── index.ts                        # Function skeleton
│   ├── package.json
│   └── tsconfig.json
├── pubspec.yaml                            # Flutter dependencies (UPDATED)
└── firebase.json                           # Firebase config
```

---

## 🔑 Key Files You Need to Know

### 1. `lib/main.dart` — App Entry Point
- Initializes Firebase
- Shows splash screen
- Entry point for routing (to be added)

### 2. `lib/config/environment_config.dart` — Environment Variables
```dart
// Controls which Firebase project is used
EnvironmentConfig.currentEnv  // = Environment.dev (default)
EnvironmentConfig.isProduction  // = false
```

### 3. `docs/roadmap/ph_12_week_sprints.md` — Full Sprint Plan
- 12 weeks broken down by sprint
- Each sprint has story points & tasks
- **Read this to understand what's being built when**

### 4. `docs/architecture/firebase_schema.md` — Database Design
- 15 Firestore collections documented
- Sample data structures
- Indexes to create
- **Reference this when creating database functions**

### 5. `docs/architecture/firestore_security_rules.md` — Access Control
- Role-based permissions (buyer, seller, admin)
- Security rules in JavaScript
- **These get deployed to Firebase**

---

## 📋 Team Assignments (Week 1)

| Role | Name | Responsibility |
|------|------|-----------------|
| **Tech Lead** | [Name] | Firebase setup, architecture, CI/CD |
| **Flutter Dev 1** | [Name] | Buyer UI (Phases 1, 3) |
| **Flutter Dev 2** | [Name] | Seller UI (Phases 1, 3) |
| **Backend Dev** | [Name] | Cloud Functions, payments, orders |
| **QA Lead** | [Name] (part-time) | Testing, release readiness |
| **PM** | [Name] (shared) | Roadmap, stakeholder updates |

---

## 🚦 Development Workflow

### Daily Standup (15 min)
- What did you do yesterday?
- What are you doing today?
- Any blockers?

### Code Review (Before Merge)
1. Run locally: `flutter run`
2. Check for lint errors: `flutter analyze`
3. Run tests: `flutter test`
4. Approve & merge to main

### Branch Naming
```
feature/PROJ-001-auth-setup
fix/PROJ-002-splash-screen-crash
docs/readme-update
```

### Commit Message Format
```
[PROJ-001] feat: Set up Firebase authentication skeleton

- Initialize Firebase Admin SDK
- Create user document on auth signup
- Add OTP phone verification endpoint

Related to Sprint 1 delivery
```

---

## 🚀 Running Cloud Functions Locally

```bash
# Navigate to functions directory
cd functions

# Install dependencies
npm install

# Build TypeScript
npm run build

# Start emulator (from project root)
firebase emulators:start --only functions

# Test a function
curl http://localhost:5001/flora-match-ph-dev/us-central1/healthCheck
```

---

## 🔍 Debugging Tips

### Flutter App Won't Start?

```bash
# Clear build cache
flutter clean
flutter pub get
flutter pub run build_runner build

# Rebuild
flutter run -v
```

### Firebase Connection Issues?

```bash
# Check Firebase project
firebase projects:list
firebase use flora-match-ph-dev

# Verify google-services.json
cat android/app/google-services.json | jq .

# Check GoogleService-Info.plist (iOS)
cat ios/Runner/GoogleService-Info.plist
```

### Can't Reach Emulator?

```bash
# Make sure emulator is running
lsof -i :5001  # Firebase Functions port
lsof -i :9000  # Firestore port

# Verify env variable
echo $FIREBASE_EMULATOR_HOST
# Should output: localhost:8080 (or unset for production)
```

---

## 📊 Success Criteria (Phase 0 Exit)

**By end of Week 2, verify:**

- ✅ All 3 developers can `flutter run` successfully
- ✅ App connects to Firebase (check Firestore in console)
- ✅ Logs appear in Firebase Console
- ✅ CI/CD pipeline runs (GitHub Actions)
- ✅ Security rules deployed to Firebase
- ✅ Team familiar with code structure & architecture
- ✅ Crash analytics working (Sentry or Firebase Crashlytics)

---

## 📚 Recommended Reading (Week 1)

1. **[12-Week Sprint Plan](./roadmap/ph_12_week_sprints.md)** (30 min)
   - Overview of all 12 weeks
   - Understand what's coming

2. **[Architecture Overview](./architecture/README.md)** (20 min)
   - System design, tech stack
   - Data flow diagrams

3. **[Firebase Schema](./architecture/firebase_schema.md)** (30 min)
   - Database collections & fields
   - Understand data structure

4. **[Development Guide](./DEV_GUIDE.md)** (1 hour)
   - Best practices, state management
   - How to implement features

5. **[Payment Provider Matrix](./architecture/payment_provider_matrix_ph.md)** (15 min)
   - Why Xendit for PH market
   - Feature comparison

---

## 🎯 Phase 1 Preview (Starting Week 3)

After Phase 0 is done, we'll start building:

### Buyer Features
- Browse products by category
- Search products
- Product detail page
- Shopping cart
- Checkout flow (payment not yet)

### Seller Features
- Store profile setup
- Create/edit products
- View orders
- Mark order as packed

### Backend
- Order creation function
- Pricing & fee calculation
- Order status machine
- Inventory management

---

## 💬 Communication & Support

### Slack Channels
- `#flora-match-general` — Announcements, status updates
- `#flora-match-dev` — Technical discussions, blockers
- `#flora-match-pm` — Product decisions, scope changes

### Documentation
- **Main:** `/docs/README.md`
- **Architecture:** `/docs/architecture/README.md`
- **Sprints:** `/docs/roadmap/ph_12_week_sprints.md`
- **Dev Setup:** `/docs/DEV_GUIDE.md`

### Weekly Syncs
- **Monday 10 AM:** Sprint planning (30 min)
- **Wednesday 2 PM:** Architecture review (30 min)
- **Friday 4 PM:** Demo & retro (1 hour)

---

## ✅ Next Steps

1. **Tech Lead:** Execute Firebase setup (above)
2. **All Devs:** Clone repo, run `flutter pub get`, `flutterfire configure`
3. **All Devs:** Get app running on your device
4. **Monday:** Kickoff standup, confirm everyone is set up
5. **Week 1–2:** Complete Phase 0 tasks per sprint plan

---

## 🎉 You're Ready to Start!

**Questions?** Post in `#flora-match-dev` or reach out to Tech Lead.

**Next:** [Read the 12-Week Sprint Plan](./roadmap/ph_12_week_sprints.md)

---

**Last Updated:** March 18, 2026  
**Status:** Ready for Sprint 1 (Week of Mar 18–22)

