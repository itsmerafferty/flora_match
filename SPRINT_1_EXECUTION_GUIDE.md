# 🚀 SPRINT 1 EXECUTION GUIDE

**Status:** 🟢 ACTIVE (Mar 18–22, 2026)  
**Phase:** Phase 0: Foundation  
**Story Points:** 20 SP  
**Team:** 3 developers + Tech Lead + Backend Dev

---

## 📌 QUICK REFERENCE

### What to Read First
1. **SPRINT_1_KICKOFF.md** — Today's agenda & immediate actions
2. **SPRINT_1_PLAN.md** — Detailed task breakdown
3. **SPRINT_1_STANDUPS.md** — Daily standup template
4. **SPRINT_1_STATUS.md** — Real-time progress tracking

### Daily Files to Update
- **SPRINT_1_STATUS.md** — Update daily @ 4 PM
- **SPRINT_1_STANDUPS.md** — Template for 10 AM standups
- GitHub Issues/PRs — Link to tasks

### Important Contacts
- **Tech Lead:** Firebase setup & infrastructure
- **Backend Dev:** Auth & Cloud Functions
- **Developers:** App features & UI
- **PM:** Timeline & scope management

---

## 🎯 SPRINT 1 GOALS

**By Friday, March 22:**

✅ **Infrastructure Ready**
- Firebase projects (dev/staging/prod)
- Database configured (Firestore)
- Security rules deployed
- Cloud Functions environment ready

✅ **Development Environment**
- All devs can run app locally
- App connects to Firebase
- CI/CD pipeline green
- Tests passing

✅ **Error Tracking**
- Sentry capturing crashes
- Firebase Analytics active
- Team can view reports

✅ **Team Ready**
- Daily standups working
- No critical blockers
- Ready for Phase 1 features

---

## 📋 THE 5-DAY PLAN

### **Day 1: Monday, March 18** — KICKOFF
- 9:00 AM: Kickoff meeting (90 min)
- 10:30 AM: Tech Lead starts Firebase setup
- 11:00 AM: Developers start environment setup
- 4:00 PM: Daily status update

**Expected Progress:** 25%

**Your Actions:**
```
✅ Attend kickoff meeting
✅ Confirm task assignments
✅ Clone repo (all devs)
✅ Start flutter pub get (all devs)
✅ Tech Lead: Begin Firebase project creation
✅ Backend Dev: Begin Auth provider setup
```

**Success Indicators:**
- Team understands goals
- Assignments confirmed
- Setup processes started

---

### **Day 2: Tuesday, March 19** — SETUP COMPLETE
- 10:00 AM: Daily standup
- 11:00 AM: Verify all environments
- 3:00 PM: Code review prep
- 4:00 PM: Status update

**Expected Progress:** 50%

**Your Actions:**
```
✅ All devs: flutter run -d chrome
✅ All devs: Verify Firebase connection
✅ Tech Lead: Confirm flutterfire for all
✅ Backend Dev: Test Auth with emulator
✅ Create PRs for infrastructure setup
```

**Success Indicators:**
- All devs running app locally
- Firebase connected
- No critical errors

---

### **Day 3: Wednesday, March 20** — TESTING & REVIEW
- 10:00 AM: Daily standup
- 2:00 PM: Architecture review (30 min)
- 3:00 PM: PR reviews
- 4:00 PM: Status update

**Expected Progress:** 75%

**Your Actions:**
```
✅ Attend architecture review
✅ Review & comment on PRs
✅ Run: flutter analyze
✅ Run: flutter test
✅ Verify: No lint errors
✅ Prepare for Thursday merge
```

**Success Indicators:**
- All PRs reviewed
- Code quality verified
- No blockers identified

---

### **Day 4: Thursday, March 21** — MERGE & QA
- 10:00 AM: Daily standup
- 11:00 AM: PR merging
- 2:00 PM: Final testing
- 4:00 PM: Status update

**Expected Progress:** 90%

**Your Actions:**
```
✅ Merge approved PRs
✅ Verify main branch is green
✅ Final testing of all features
✅ Update documentation
✅ Prepare demo for Friday
```

**Success Indicators:**
- All PRs merged
- Main branch stable
- CI/CD passing

---

### **Day 5: Friday, March 22** — SPRINT COMPLETE
- 10:00 AM: Daily standup
- 4:00 PM: Sprint review & retro (1 hour)

**Expected Progress:** 100%

**Your Actions:**
```
✅ Prepare demo (what you built)
✅ Prepare what went well / what was hard
✅ Attend Sprint review
✅ Attend retrospective
✅ Plan Sprint 2 tasks
```

**Success Indicators:**
- All 20 SP complete
- Sprint review demo ready
- Team agrees on Phase 1 start

---

## 🔑 KEY TASKS

### Tech Lead Priority Order

```
PRIORITY 1 (TODAY):
[ ] Create Firebase projects (dev/staging/prod)
[ ] Setup Firebase Console
[ ] Create flutterfire config file
[ ] Share project IDs with team

PRIORITY 2 (TUESDAY):
[ ] Run flutterfire configure for dev
[ ] Verify all devs have config
[ ] Setup GitHub Actions workflows
[ ] Create Sentry account

PRIORITY 3 (WEDNESDAY):
[ ] Deploy Firestore security rules
[ ] Setup Firebase Emulator
[ ] Verify CI/CD pipeline working
[ ] All devs running app

PRIORITY 4 (THURSDAY):
[ ] Review all code/PRs
[ ] Merge to main branch
[ ] Final verification
[ ] Prepare for Sprint review
```

### Backend Dev Priority Order

```
PRIORITY 1 (TODAY):
[ ] Enable Firebase Auth services
[ ] Configure phone sign-in
[ ] Configure email sign-in
[ ] Setup OTP settings

PRIORITY 2 (TUESDAY):
[ ] Test Auth with Emulator
[ ] Create Cloud Function skeleton
[ ] Setup functions environment locally

PRIORITY 3 (WEDNESDAY):
[ ] Verify Auth working end-to-end
[ ] Create auth tests
[ ] Update documentation

PRIORITY 4 (THURSDAY):
[ ] Code review Auth implementation
[ ] Merge to main
[ ] Sprint readiness check
```

### Developer Priority Order

```
PRIORITY 1 (TODAY):
[ ] Clone repository
[ ] flutter pub get
[ ] flutter run -d chrome
[ ] Report any errors

PRIORITY 2 (TUESDAY):
[ ] Verify Firebase connection
[ ] Confirm project structure
[ ] Setup IDE extensions
[ ] Review code/architecture

PRIORITY 3 (WEDNESDAY):
[ ] Attend architecture review
[ ] Review PRs
[ ] Test on your device
[ ] No errors in code

PRIORITY 4 (THURSDAY):
[ ] Final testing
[ ] Code review others' work
[ ] Help with merging
[ ] Prepare for Sprint review
```

---

## 💻 TECHNICAL CHECKLIST

### Firebase Setup
- [ ] Dev project created in Firebase Console
- [ ] Staging project created
- [ ] Prod project created
- [ ] Firestore enabled on all projects
- [ ] Firebase Auth enabled
- [ ] Cloud Storage enabled
- [ ] Cloud Functions enabled
- [ ] Cloud Scheduler enabled

### flutterfire Configuration
- [ ] flutterfire CLI installed
- [ ] Configuration run locally
- [ ] google-services.json created
- [ ] GoogleService-Info.plist created
- [ ] Files committed to repo
- [ ] All devs pulled latest

### App Setup
- [ ] flutter pub get successful
- [ ] flutter clean & flutter pub get (if errors)
- [ ] flutter run -d chrome works
- [ ] No console errors
- [ ] Firebase emulator reachable
- [ ] App connects to Firebase

### CI/CD Setup
- [ ] test.yml workflow created
- [ ] deploy.yml workflow created
- [ ] GitHub Actions triggers on PR
- [ ] Lint check running
- [ ] Unit tests running
- [ ] Deploy to staging automated

### Error Tracking
- [ ] Sentry account created
- [ ] DSN in config
- [ ] Firebase Crashlytics enabled
- [ ] Analytics tracking active
- [ ] Errors reported to Sentry

---

## 🎯 SUCCESS METRICS

**By Friday EOD, measure:**

| Metric | Target | Status |
|--------|--------|--------|
| Developers running app | 100% (3/3) | 🟡 In Progress |
| Firebase connected | 100% | 🟡 In Progress |
| CI/CD green | 100% | 🟡 In Progress |
| Tests passing | 100% | 🟡 In Progress |
| Story points done | 20/20 SP | 🟡 In Progress |
| Code reviewed | 100% | 🟡 In Progress |
| Blockers resolved | 100% | 🟡 In Progress |
| Team ready | Yes | 🟡 In Progress |

---

## 🚨 INCIDENT RESPONSE

### If Something Breaks

**Step 1: Report**
```
Post in #flora-match-dev:
🚨 BLOCKER: [Issue name]
- Error: [Full error message]
- Impact: [What's affected]
- When started: [Timestamp]
- Assign: @tech-lead or @owner
```

**Step 2: Escalate (if critical)**
```
If blocking entire team:
@channel Need urgent help with [issue]
```

**Step 3: Resolution SLA**
- Response: 1 hour
- Resolution: 4 hours (or escalate)
- If unresolved: Skip to manual process

---

## 📞 STANDUPS & MEETINGS

### Daily Standup (10:00 AM, 15 min)
**Location:** Slack #flora-match-dev or in-person

**Format:** 3 sentences per person
1. What I completed yesterday
2. What I'm doing today
3. Any blockers?

**Template:** See SPRINT_1_STANDUPS.md

### Architecture Review (Wednesday 2 PM, 30 min)
**Purpose:** Review project structure, patterns, decisions
**Attendees:** All team
**Facilitator:** Tech Lead

### Sprint Review (Friday 4 PM, 30 min)
**Purpose:** Demo what was built, show it works
**Attendees:** All team + stakeholders
**Format:** Live demo of:
- App running locally
- Firebase connected
- CI/CD working
- Auth providers enabled

### Sprint Retrospective (Friday 4:30 PM, 30 min)
**Purpose:** What went well, what was hard, improve
**Attendees:** All team
**Questions:**
- What went well? (Keep doing)
- What was hard? (Support needed)
- What to improve? (Change for Sprint 2)

---

## 🎉 SPRINT 1 DEFINITION OF SUCCESS

**Phase 0 is complete when:**

✅ **Infrastructure**
```
- Firebase projects created & working
- Firestore database ready
- Security rules deployed
- Cloud Functions environment ready
- CI/CD pipeline automated
```

✅ **Application**
```
- All developers can run app
- App connects to Firebase
- No errors in console
- Tests passing
- Code quality verified
```

✅ **Team**
```
- Daily standups working
- No critical blockers
- Documentation updated
- Team ready for Phase 1
- Velocity on track
```

✅ **Readiness**
```
- Can start buyer features (Phase 1) Monday
- Know how to build features
- Have proper patterns to follow
- Ready to ship regularly
```

---

## 📞 SUPPORT & QUESTIONS

**Need help?**
1. Post in Slack: `#flora-match-dev`
2. Tag relevant person: `@tech-lead` or `@owner`
3. Include: Problem, what you tried, error message
4. Wait: 1 hour SLA for response

**Have a great idea?**
1. Post in: `#flora-match-general`
2. Add to: Sprint 2 backlog
3. Discuss: In next retro

**Found a bug?**
1. Create issue: GitHub Issues
2. Link to: PR or feature
3. Severity: Critical/High/Medium/Low

---

## 🏁 YOU'RE READY TO LAUNCH SPRINT 1!

**Everything is prepared:**
- ✅ Tasks documented
- ✅ Goals clear
- ✅ Team assigned
- ✅ Tools ready
- ✅ Support in place

**Let's execute with excellence! 🚀**

---

**Sprint 1 Starts:** Monday, March 18, 2026  
**Sprint 1 Ends:** Friday, March 22, 2026  
**Velocity Target:** 20 SP (100%)  
**Next Phase:** Phase 1 — Buyer Features (Mon, Mar 25)

