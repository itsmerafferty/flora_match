# Flora Match - Project Master Index

**Project:** Flora Match Marketplace MVP (Philippines)  
**Status:** ✅ Phase 0 Complete - Ready for Sprint 1  
**Launch Target:** June 7, 2026 (12 weeks)

---

## 📚 Documentation Index

### 📋 Planning & Roadmap
| Document | Purpose | Read Time |
|----------|---------|-----------|
| **[IMPLEMENTATION_SUMMARY.md](IMPLEMENTATION_SUMMARY.md)** | Overview of all deliverables | 10 min |
| **[GETTING_STARTED.md](GETTING_STARTED.md)** | Team onboarding guide (Week 1) | 15 min |
| **[docs/roadmap/ph_12_week_sprints.md](docs/roadmap/ph_12_week_sprints.md)** | Full 12-week sprint backlog | 30 min |

### 🏗️ Architecture & Design
| Document | Purpose | Read Time |
|----------|---------|-----------|
| **[docs/architecture/README.md](docs/architecture/README.md)** | System architecture overview | 20 min |
| **[docs/architecture/firebase_schema.md](docs/architecture/firebase_schema.md)** | Firestore collections & schema | 30 min |
| **[docs/architecture/firestore_security_rules.md](docs/architecture/firestore_security_rules.md)** | Security rules & access control | 20 min |
| **[docs/architecture/payment_provider_matrix_ph.md](docs/architecture/payment_provider_matrix_ph.md)** | Payment provider comparison | 20 min |

### 👨‍💻 Development
| Document | Purpose | Read Time |
|----------|---------|-----------|
| **[docs/DEV_GUIDE.md](docs/DEV_GUIDE.md)** | Development best practices | 1 hour |
| **[README.md](README.md)** | Project overview & quick start | 5 min |

---

## 🎯 Quick Navigation

### I'm a Developer - Where Do I Start?
1. **First Time:** [GETTING_STARTED.md](GETTING_STARTED.md) (Week 1 setup)
2. **Understanding Code:** [docs/DEV_GUIDE.md](docs/DEV_GUIDE.md) (architecture, patterns)
3. **Building a Feature:** [docs/DEV_GUIDE.md](docs/DEV_GUIDE.md#2-implementation-order-per-feature)
4. **Need Data Schema?** [docs/architecture/firebase_schema.md](docs/architecture/firebase_schema.md)
5. **Security Questions?** [docs/architecture/firestore_security_rules.md](docs/architecture/firestore_security_rules.md)

### I'm a Tech Lead - Where Do I Start?
1. **Overview:** [IMPLEMENTATION_SUMMARY.md](IMPLEMENTATION_SUMMARY.md)
2. **Architecture:** [docs/architecture/README.md](docs/architecture/README.md)
3. **Firebase Setup:** [GETTING_STARTED.md](GETTING_STARTED.md#step-2-firebase-configuration-45-min)
4. **Full Roadmap:** [docs/roadmap/ph_12_week_sprints.md](docs/roadmap/ph_12_week_sprints.md)
5. **Payment Decision:** [docs/architecture/payment_provider_matrix_ph.md](docs/architecture/payment_provider_matrix_ph.md)

### I'm a PM - Where Do I Start?
1. **Overview:** [IMPLEMENTATION_SUMMARY.md](IMPLEMENTATION_SUMMARY.md)
2. **Full Timeline:** [docs/roadmap/ph_12_week_sprints.md](docs/roadmap/ph_12_week_sprints.md)
3. **Key Decisions:** [docs/architecture/README.md](docs/architecture/README.md#key-decision-points)
4. **Risk Mitigation:** [docs/architecture/README.md](docs/architecture/README.md#risk-registry)

---

## 📦 Project Structure

```
flora_match/
├── README.md                                # Project overview
├── GETTING_STARTED.md                       # Team onboarding (Week 1)
├── IMPLEMENTATION_SUMMARY.md                # What was delivered
├── PROJECT_INDEX.md                         # This file
├── pubspec.yaml                             # Flutter dependencies (UPDATED)
├── firebase.json                            # Firebase configuration
│
├── lib/                                     # Flutter App Source
│   ├── main.dart                            # Entry point (UPDATED)
│   ├── config/                              # Configuration files
│   │   ├── environment_config.dart          # Dev/staging/prod
│   │   ├── firebase_config.dart             # Firebase init
│   │   └── payment_config.dart              # Constants
│   ├── core/                                # Core utilities
│   │   ├── constants/
│   │   │   └── app_constants.dart           # App constants
│   │   ├── errors/
│   │   │   └── exceptions.dart              # Exception classes
│   │   └── utils/
│   │       └── logger.dart                  # Logging utility
│   ├── features/                            # Feature modules (grows in Phase 1+)
│   └── shared/                              # Shared components
│
├── functions/                               # Cloud Functions (Node.js)
│   ├── src/
│   │   └── index.ts                         # Function implementations
│   ├── package.json                         # Node.js dependencies
│   └── tsconfig.json                        # TypeScript config
│
├── docs/                                    # Documentation
│   ├── architecture/                        # Architecture & design docs
│   │   ├── README.md                        # Architecture overview
│   │   ├── firebase_schema.md               # Database design (15 collections)
│   │   ├── firestore_security_rules.md      # Security rules
│   │   └── payment_provider_matrix_ph.md    # Payment comparison
│   ├── roadmap/                             # Roadmap & planning
│   │   └── ph_12_week_sprints.md            # 12-week sprint plan (280 SP)
│   └── DEV_GUIDE.md                         # Development guide
│
└── test/                                    # Tests (to be populated)
    ├── unit/
    ├── integration/
    └── e2e/
```

---

## ✅ Phase 0 Completion Checklist

### Documentation ✅
- [x] 12-week sprint plan (280 SP across 4 phases)
- [x] Firebase schema (15 collections documented)
- [x] Security rules (role-based access control)
- [x] Payment provider matrix (Xendit recommended)
- [x] Architecture overview
- [x] Development guide
- [x] Getting started guide
- [x] Implementation summary

### Code Structure ✅
- [x] Clean architecture setup (presentation/domain/data)
- [x] Environment configuration (dev/staging/prod)
- [x] Firebase initialization
- [x] Error handling framework
- [x] Logging utility
- [x] Constants & configuration
- [x] Cloud Functions skeleton
- [x] Updated dependencies

### Team Readiness ✅
- [x] Onboarding guide created
- [x] Development best practices documented
- [x] Project structure explained
- [x] Quick reference guides
- [x] Team assignments template

---

## 🚀 Sprint 1 Kickoff (Week of Mar 18–22, 2026)

### Monday (Mar 18)
- [ ] Team kickoff meeting (1 hour)
- [ ] Assign tasks from sprint backlog
- [ ] Confirm Firebase projects needed

### Tuesday–Thursday
- [ ] Tech Lead: Set up Firebase projects
- [ ] All Devs: Clone repo, install dependencies
- [ ] Backend Dev: Set up Cloud Functions environment
- [ ] All Devs: Get app running on device

### Friday (Mar 22)
- [ ] Sprint review: All devs can run app locally
- [ ] Firebase connection verified
- [ ] Phase 0 exit criteria met
- [ ] Sprint 2 planning

---

## 📊 Key Metrics

| Metric | Value | Notes |
|--------|-------|-------|
| **Total Sprints** | 12 × 5-day sprints | Jun 7, 2026 |
| **Total Story Points** | 280 SP | ~24 SP/sprint avg |
| **Team Size** | 3 devs + QA + PM | Lean setup |
| **Firestore Collections** | 15 | Documented with schema |
| **Cloud Functions** | 15+ | Phase-by-phase implementation |
| **Expected Cost (MVP)** | $30–50/month | Firebase Firestore consumption |

---

## 🔗 Key Links

### External Resources
- [Flutter Documentation](https://flutter.dev/docs)
- [Firebase Documentation](https://firebase.google.com/docs/flutter/setup)
- [BLoC Pattern](https://bloclibrary.dev/)
- [Clean Architecture](https://resocoder.com/clean-architecture)
- [Xendit API](https://xendit.io/api)

### Internal Documentation
- **Architecture:** [docs/architecture/README.md](docs/architecture/README.md)
- **Sprints:** [docs/roadmap/ph_12_week_sprints.md](docs/roadmap/ph_12_week_sprints.md)
- **Dev Setup:** [docs/DEV_GUIDE.md](docs/DEV_GUIDE.md)
- **Getting Started:** [GETTING_STARTED.md](GETTING_STARTED.md)

---

## 💬 Support & Communication

### Slack Channels
- `#flora-match-general` — Announcements & status
- `#flora-match-dev` — Technical discussions
- `#flora-match-pm` — Product decisions

### Weekly Meetings
- **Monday 10 AM:** Sprint planning (30 min)
- **Wednesday 2 PM:** Architecture review (30 min)
- **Friday 4 PM:** Demo & retro (1 hour)

### Team Contacts
- **Tech Lead:** [Name] - Architecture, Firebase setup
- **PM:** [Name] - Roadmap, scope, decisions
- **QA Lead:** [Name] - Testing, quality

---

## 📝 Document Versions

| Document | Version | Last Updated | Status |
|----------|---------|--------------|--------|
| This Index | 1.0 | Mar 18, 2026 | ✅ Final |
| Sprint Plan | 1.0 | Mar 18, 2026 | ✅ Final |
| Firebase Schema | 1.0 | Mar 18, 2026 | ✅ Final |
| Security Rules | 1.0 | Mar 18, 2026 | ✅ Final |
| Payment Matrix | 1.0 | Mar 18, 2026 | ✅ Final |
| Architecture | 1.0 | Mar 18, 2026 | ✅ Final |
| Dev Guide | 1.0 | Mar 18, 2026 | ✅ Final |
| Getting Started | 1.0 | Mar 18, 2026 | ✅ Final |

---

## 🎉 Ready to Build!

**Phase 0 is complete.** All planning, architecture, and setup documents are ready.

**Next Step:** Sprint 1 kickoff meeting (Monday, Mar 18, 10 AM)

**Status:** ✅ Ready for development

---

**Created:** March 18, 2026  
**Project:** Flora Match - Marketplace MVP (Philippines)  
**Target Launch:** June 7, 2026

