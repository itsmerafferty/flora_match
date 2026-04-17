# 📋 SPRINT 1 EXECUTION PLAN

**Sprint:** Week 1 (Mar 18–22, 2026)  
**Phase:** Phase 0: Foundation  
**Story Points:** 20 SP  
**Team Capacity:** 30 SP/week  
**Goal:** Setup Flutter project structure, Firebase foundation, CI/CD pipeline

---

## 📅 DAILY BREAKDOWN

### Monday, March 18, 2026 - Day 1

**Status Meeting:** 10:00 AM (30 min)
- Confirm team setup
- Review Sprint 1 tasks
- Identify blockers

**Daily Tasks:**

#### PROJ-001: Set up Flutter project structure (5 SP) — Tech Lead
**Description:** Implement clean architecture directory structure
**Status:** 🟡 IN PROGRESS
**Acceptance Criteria:**
- [ ] Feature/data/domain/presentation layers created
- [ ] Proper package naming conventions
- [ ] Analysis options configured
- [ ] Linting rules active

**Tasks:**
```bash
# Create main directories
mkdir -p lib/features/{auth,buyer,seller,payments,orders,admin}
mkdir -p lib/features/auth/{data,domain,presentation}
mkdir -p lib/shared/{models,widgets,repositories}
mkdir -p test/{unit,integration,e2e}
```

**Progress:**
- [ ] Directory structure created
- [ ] Dart conventions documented
- [ ] Team agrees on structure

---

#### PROJ-002: Initialize Firebase project & configure flutterfire (5 SP) — Tech Lead
**Description:** Set up Firebase projects and local configuration
**Status:** 🟡 IN PROGRESS
**Acceptance Criteria:**
- [ ] Firebase projects created (dev/staging/prod)
- [ ] flutterfire configured for dev
- [ ] google-services.json present
- [ ] GoogleService-Info.plist present
- [ ] firebase.json configured

**Tasks:**
```bash
# Create Firebase projects
firebase projects:create flora-match-ph-dev
firebase projects:create flora-match-ph-staging
firebase projects:create flora-match-ph-prod

# Configure for local development
firebase use flora-match-ph-dev
flutterfire configure --project=flora-match-ph-dev
```

**Progress:**
- [ ] Firebase projects exist
- [ ] flutterfire configured
- [ ] Configuration files in place

---

#### PROJ-003: Set up CI/CD pipeline (5 SP) — DevOps
**Description:** GitHub Actions for lint, test, deploy
**Status:** 🟡 IN PROGRESS
**Acceptance Criteria:**
- [ ] test.yml workflow created
- [ ] Runs on all PRs
- [ ] Lint checks pass
- [ ] Unit tests run
- [ ] Deploy workflow ready

**Tasks:**
```yaml
# .github/workflows/test.yml
- Run: flutter analyze
- Run: flutter test
- Gate: Must pass before merge
```

**Progress:**
- [ ] GitHub Actions configured
- [ ] Workflows triggering
- [ ] Tests running in CI

---

#### AUTH-001: Implement Firebase Auth skeleton (2 SP) — Backend Dev
**Description:** Firebase Auth providers setup (no UI yet)
**Status:** 🟡 IN PROGRESS
**Acceptance Criteria:**
- [ ] Firebase Auth initialized
- [ ] Phone sign-in provider enabled
- [ ] Email sign-in provider enabled
- [ ] Phone OTP configured

**Tasks:**
- Enable Firebase Auth in Console
- Configure phone provider
- Enable OTP verification
- Test with Firebase Emulator

**Progress:**
- [ ] Auth providers enabled
- [ ] Emulator tested
- [ ] Ready for UI in Sprint 2

---

#### PROJ-004: Add Sentry & Firebase Analytics (3 SP) — Tech Lead
**Description:** Error tracking and analytics setup
**Status:** 🟡 IN PROGRESS
**Acceptance Criteria:**
- [ ] Sentry account created
- [ ] DSN in environment config
- [ ] Firebase Analytics initialized
- [ ] Crash tracking active

**Tasks:**
- Create Sentry account
- Add sentry_flutter to pubspec
- Configure in main.dart
- Test error reporting

**Progress:**
- [ ] Sentry integrated
- [ ] Analytics tracking
- [ ] Test crash received

---

### Tuesday, March 19, 2026 - Day 2

**Daily Standup:** 10:00 AM (15 min)
- What's complete?
- What's blocked?
- Support needed?

**All Team Actions:**
```
1. Clone repository (if not done)
2. Run: flutter pub get
3. Verify: flutter doctor -v
4. Test: flutter run -d chrome
5. Report: Any issues → #flora-match-dev
```

**Tech Lead:** Firebase setup progression
- [ ] Dev Firebase project fully configured
- [ ] All team members have flutterfire installed
- [ ] Local Firebase emulator working

**Developers:** Environment setup
- [ ] All can run `flutter run` successfully
- [ ] No crypto/build errors
- [ ] Firebase connection verified

---

### Wednesday, March 20, 2026 - Day 3

**Architecture Review:** 2:00 PM (30 min)
- Review project structure
- Confirm clean architecture
- Q&A on patterns

**Team Actions:**
- Run: `flutter analyze`
- Verify: No analysis errors
- Run: `flutter test`
- Verify: Tests pass

**Focus Areas:**
- [ ] All devs running app locally
- [ ] Firebase console shows active projects
- [ ] CI/CD pipeline triggered & passed
- [ ] No blockers remaining

---

### Thursday, March 21, 2026 - Day 4

**Code Review & Testing:**
- Review all Pull Requests
- Merge approved changes
- Update main branch

**Tasks:**
- [ ] All code merged to main
- [ ] CI/CD pipeline green
- [ ] No broken builds
- [ ] Documentation updated

---

### Friday, March 22, 2026 - Day 5

**Sprint Review & Retrospective:** 4:00 PM (1 hour)

**Sprint Review (30 min):**
- Demonstrate: App runs locally ✅
- Demonstrate: Firebase connected ✅
- Demonstrate: Sentry/Analytics working ✅
- Confirm: Phase 0 foundation complete ✅

**Sprint Retrospective (30 min):**
- What went well?
- What was hard?
- What to improve?
- Action items for Sprint 2

---

## 🎯 SPRINT 1 SUCCESS CRITERIA

### Exit Criteria (Must Have)
- [x] ✅ Project structure set up (clean architecture)
- [x] ✅ Firebase projects created (dev/staging/prod)
- [x] ✅ All team members can run app locally
- [x] ✅ Firebase connection working
- [x] ✅ CI/CD pipeline active & passing
- [x] ✅ Error tracking (Sentry) active
- [x] ✅ Auth providers enabled (no UI)

### Definition of Done
```
For each task:
[ ] Code written & tested
[ ] Pull request created
[ ] Code reviewed & approved
[ ] Tests passing (CI/CD green)
[ ] Documentation updated
[ ] Demo ready for Sprint Review
```

---

## 📊 SPRINT 1 TASKS SUMMARY

| Task ID | Task | Owner | SP | Status | Due |
|---------|------|-------|----|---------|----|
| PROJ-001 | Project structure | Tech Lead | 5 | 🟡 In Progress | Wed |
| PROJ-002 | Firebase init | Tech Lead | 5 | 🟡 In Progress | Tue |
| PROJ-003 | CI/CD pipeline | DevOps | 5 | 🟡 In Progress | Thu |
| PROJ-004 | Sentry/Analytics | Tech Lead | 3 | 🟡 In Progress | Wed |
| AUTH-001 | Auth skeleton | Backend Dev | 2 | 🟡 In Progress | Wed |
| **SPRINT 1 TOTAL** | | | **20 SP** | | **Fri** |

---

## 🚨 KNOWN BLOCKERS & SOLUTIONS

| Blocker | Solution | Owner |
|---------|----------|-------|
| Firebase project creation delays | Use existing project if available | Tech Lead |
| Firestore emulator issues | Update to latest firebase-tools | Tech Lead |
| Flutterfire configure fails | Clear cache: `flutter clean` | All |
| Sentry account creation | Use GitHub email for signup | Tech Lead |

---

## 📞 COMMUNICATION

### Daily Standup
- **Time:** 10:00 AM
- **Duration:** 15 min
- **Format:** 3 sentences per person (done/doing/blockers)
- **Channel:** Slack or in-person

### Blocker Resolution
- Post in: `#flora-match-dev`
- Response SLA: 1 hour
- Escalate to Tech Lead if critical

### Status Updates
- Update this file daily
- Mark tasks: 🟡 In Progress → ✅ Complete
- Move blockers to Slack

---

## 📚 REFERENCES

- **Setup Guide:** `/GETTING_STARTED.md`
- **Dev Guide:** `/docs/DEV_GUIDE.md`
- **Architecture:** `/docs/architecture/README.md`
- **Firebase Schema:** `/docs/architecture/firebase_schema.md`
- **Security Rules:** `/docs/architecture/firestore_security_rules.md`

---

## ✅ CHECKLIST BEFORE SPRINT 2

Make sure ALL are complete:
- [ ] Project structure finalized
- [ ] Firebase projects production-ready
- [ ] All developers can run app
- [ ] CI/CD passing
- [ ] Error tracking active
- [ ] Auth providers enabled
- [ ] Team fully onboarded
- [ ] Phase 0 exit criteria met

---

**Sprint 1 Status: 🟡 IN PROGRESS**  
**Start Date:** March 18, 2026  
**End Date:** March 22, 2026  
**Story Points:** 20 / 20 SP allocated

