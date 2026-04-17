# 🌿 Flora Match: START HERE 👈

**Welcome to Flora Match Development!**

Choose your role below to find the right guide:

---

## 👨‍💼 I'm a Product Manager / Stakeholder

**Time commitment:** 40-45 minutes  
**Goal:** Understand business case, roadmap, and investment

### Read these (in order):
1. **[EXECUTIVE_SUMMARY_STAKEHOLDERS.md](EXECUTIVE_SUMMARY_STAKEHOLDERS.md)** ← Start here!
   - Business opportunity & market
   - Financial projections
   - Team structure & risks
   
2. **[README_COMPLETE.md](README_COMPLETE.md)** 
   - Technical stack overview
   - Feature roadmap
   - 12-week plan

3. **[SPRINT_PLAN_12_WEEKS.md](docs/roadmap/SPRINT_PLAN_12_WEEKS.md)**
   - Complete sprint breakdown
   - All features & story points
   - Team velocity & milestones

### Next Steps:
- Review Sprint 1 completion: [SPRINT_1_IMPLEMENTATION_SUMMARY.md](SPRINT_1_IMPLEMENTATION_SUMMARY.md)
- Check payment analysis: [PAYMENT_PROVIDER_MATRIX_PH.md](docs/architecture/PAYMENT_PROVIDER_MATRIX_PH.md)

---

## 👨‍💻 I'm a Developer (First Time)

**Time commitment:** 90 minutes  
**Goal:** Setup local environment and understand codebase

### Read these (in order):
1. **[README_COMPLETE.md](README_COMPLETE.md)** ← Start here!
   - Tech stack overview
   - Project structure
   - Quick start commands

2. **[SPRINT_1_QUICKSTART.md](SPRINT_1_QUICKSTART.md)** 
   - Prerequisites checklist
   - Environment setup (30 min)
   - Running the app
   - Troubleshooting guide

3. **[docs/DEV_GUIDE.md](docs/DEV_GUIDE.md)**
   - Code standards & practices
   - BLoC architecture patterns
   - Git workflow
   - Testing guidelines

### Get Your Hands Dirty:
```bash
# 1. Clone repo
git clone https://github.com/your-org/flora_match.git
cd flora_match

# 2. Install & run
flutter pub get
flutter run --dart-define=ENV=dev

# 3. Test the flow
# Enter: 09XX XXX XXXX (any valid PH number)
# See phone auth page work!
```

### Next Steps:
- Review architecture: [docs/architecture/README.md](docs/architecture/README.md)
- Understand data model: [FIREBASE_SCHEMA_COMPLETE.md](docs/architecture/FIREBASE_SCHEMA_COMPLETE.md)
- Pick a Sprint 2 story from: [SPRINT_1_EXECUTION_GUIDE_DETAILED.md](docs/roadmap/SPRINT_1_EXECUTION_GUIDE_DETAILED.md)

---

## 🏗️ I'm a Architect / Tech Lead

**Time commitment:** 140 minutes  
**Goal:** Understand full system architecture & make technical decisions

### Read these (in order):
1. **[README_COMPLETE.md](README_COMPLETE.md)** ← Start here!
   - Tech stack & rationale
   - Project structure
   - 12-week roadmap

2. **[SPRINT_PLAN_12_WEEKS.md](docs/roadmap/SPRINT_PLAN_12_WEEKS.md)**
   - Complete roadmap with all stories
   - Dependencies & blockers
   - Risk management
   - Resource allocation

3. **[docs/architecture/README.md](docs/architecture/README.md)**
   - System architecture decisions
   - Design patterns
   - Scalability considerations

4. **[FIREBASE_SCHEMA_COMPLETE.md](docs/architecture/FIREBASE_SCHEMA_COMPLETE.md)**
   - 15 Firestore collections
   - Denormalization strategy
   - Query patterns & indexes
   - Storage estimates

5. **[firestore.rules](firestore.rules)**
   - Security rules implementation
   - Role-based access control
   - Data protection strategies

6. **[PAYMENT_PROVIDER_MATRIX_PH.md](docs/architecture/PAYMENT_PROVIDER_MATRIX_PH.md)**
   - Payment provider analysis
   - Why Xendit chosen
   - Integration roadmap (Sprint 8)

### Review Code:
- BLoC pattern: `lib/presentation/blocs/auth/`
- Configuration: `lib/config/`
- Utils: `lib/core/utils/`

### Next Steps:
- Review Sprint 2 planning
- Plan architecture for payments (Sprint 8)
- Setup team code review standards

---

## 🔄 I'm Joining an Existing Sprint

**Time commitment:** 60 minutes  
**Goal:** Understand current sprint scope and pick your task

### Read these (in order):
1. **[SPRINT_1_EXECUTION_GUIDE_DETAILED.md](docs/roadmap/SPRINT_1_EXECUTION_GUIDE_DETAILED.md)** ← Start here!
   - Current sprint status
   - Tasks breakdown
   - Acceptance criteria
   - Day-by-day schedule

2. **[SPRINT_1_IMPLEMENTATION_SUMMARY.md](SPRINT_1_IMPLEMENTATION_SUMMARY.md)**
   - What's been completed
   - What's in progress
   - Blockers & issues

3. **[SPRINT_1_QUICKSTART.md](SPRINT_1_QUICKSTART.md)**
   - Local setup if needed
   - Troubleshooting

4. **[SPRINT_1_STATUS.md](SPRINT_1_STATUS.md)**
   - Current status updates
   - Team standups

### Pick Your Task:
- Check unassigned stories in sprint
- Review acceptance criteria
- Setup with tech lead
- Start coding!

---

## 🚀 I Want the Quick Start (5 minutes)

**JUST GIVE ME THE COMMANDS:**

```bash
# 1. Clone
git clone https://github.com/your-org/flora_match.git
cd flora_match

# 2. Setup
flutter pub get
firebase emulators:start &

# 3. Run
flutter run --dart-define=ENV=dev

# 4. Test phone auth
# Phone number: 09XX XXX XXXX (any PH format)
```

**Need more help?** → [SPRINT_1_QUICKSTART.md](SPRINT_1_QUICKSTART.md)

---

## 🔧 I Need to Setup Firebase

**Instructions:**
1. Create GCP projects (flora-match-ph-dev, staging, prod)
2. Download google-services.json & GoogleService-Info.plist
3. Place in android/app/ and ios/Runner/
4. Update environment_config.dart with actual credentials
5. Deploy firestore.rules to each project

**Full instructions:** [SPRINT_1_QUICKSTART.md](SPRINT_1_QUICKSTART.md) - "Setup Firebase"

---

## 📊 I Need to Track Sprint Progress

**Check these files (updated daily):**
- [SPRINT_1_STATUS.md](SPRINT_1_STATUS.md) - Overall status
- [SPRINT_1_STANDUPS.md](SPRINT_1_STANDUPS.md) - Daily standups
- [SPRINT_1_TODAY.md](SPRINT_1_TODAY.md) - Today's updates

**Full reporting:**
- Sprint completion: [SPRINT_1_IMPLEMENTATION_SUMMARY.md](SPRINT_1_IMPLEMENTATION_SUMMARY.md)
- Planning: [SPRINT_PLAN_12_WEEKS.md](docs/roadmap/SPRINT_PLAN_12_WEEKS.md)

---

## 🆘 I'm Stuck / Have Questions

### "The app won't start"
→ [SPRINT_1_QUICKSTART.md](SPRINT_1_QUICKSTART.md) - Troubleshooting section

### "I don't know where to start"
→ Come back to this page and pick your role above ☝️

### "I found a bug"
→ Create GitHub issue + slack tech lead

### "I need to understand X"
→ Check [docs/architecture/README.md](docs/architecture/README.md) for architecture questions

### "Payment integration questions"
→ [PAYMENT_PROVIDER_MATRIX_PH.md](docs/architecture/PAYMENT_PROVIDER_MATRIX_PH.md)

### "Database schema questions"
→ [FIREBASE_SCHEMA_COMPLETE.md](docs/architecture/FIREBASE_SCHEMA_COMPLETE.md)

---

## 📚 Complete Documentation Index

**All documents:** [PROJECT_INDEX.md](PROJECT_INDEX.md)

### Key Documents
| Document | Purpose | Read Time |
|----------|---------|-----------|
| [README_COMPLETE.md](README_COMPLETE.md) | Project overview | 15 min |
| [SPRINT_1_QUICKSTART.md](SPRINT_1_QUICKSTART.md) | Setup guide | 10 min |
| [SPRINT_PLAN_12_WEEKS.md](docs/roadmap/SPRINT_PLAN_12_WEEKS.md) | 12-week roadmap | 30 min |
| [FIREBASE_SCHEMA_COMPLETE.md](docs/architecture/FIREBASE_SCHEMA_COMPLETE.md) | Database design | 45 min |
| [EXECUTIVE_SUMMARY_STAKEHOLDERS.md](EXECUTIVE_SUMMARY_STAKEHOLDERS.md) | Business case | 20 min |

---

## ✅ Sprint 1 Status

**Status:** ✅ COMPLETE  
**Stories Delivered:** 8 (32 story points)  
**Release Date:** March 22, 2026  
**Sprint 2 Starts:** March 24, 2026

**What's Working:**
- ✅ Multi-env Firebase
- ✅ Phone auth UI
- ✅ CI/CD pipeline
- ✅ Error monitoring
- ✅ Security rules

---

## 🎯 Next Steps

### For Everyone
1. Read the guide for your role (above)
2. Setup your local environment
3. Attend daily standup (9:00 AM)
4. Pick a task and start coding!

### For Team Leads
1. Ensure team reads appropriate guides
2. Assign Sprint tasks
3. Setup code reviews
4. Report daily progress

---

## 📞 Get Help

**Slack Channels:**
- `#flora-match-dev` - Development questions
- `#flora-match-general` - General discussion
- `#devops-alerts` - Infrastructure issues

**Office Hours:**
- Tech Lead: Mon & Fri 2-3 PM
- Frontend: Tue & Thu 10-11 AM
- Backend: Daily 4-5 PM

**Direct Contact:**
- tech-lead@flora-match.ph
- frontend@flora-match.ph
- backend@flora-match.ph

---

## 🎉 Welcome to Flora Match!

**"Connecting Plant Lovers Across the Philippines"**

Let's build something amazing together! 🌱

---

**Last Updated:** March 18, 2026  
**Status:** Sprint 1 Complete ✅  
**Next Review:** March 22, 2026

👉 **Still not sure? Pick your role above and click the first link!**
