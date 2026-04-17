# 📅 SPRINT 1 - DAILY STANDUPS

**Sprint:** Week 1: Mar 18–22, 2026  
**Time:** 10:00 AM (15 min)  
**Location:** Slack thread or in-person

---

## ✅ STANDUP TEMPLATE

**Person:** [Your Name]  
**Role:** [Tech Lead / Flutter Dev 1 / Flutter Dev 2 / Backend Dev]  
**Date:** [MM/DD/YYYY]

### ✅ What I Completed Yesterday
- [ ] Task 1
- [ ] Task 2

### 🔄 What I'm Working On Today
- [ ] Task A
- [ ] Task B

### 🚨 Blockers / Help Needed
- Blocker: [Description]
- Help needed: [What you need]
- Escalation: [Yes/No]

---

## 📋 DAY 1 STANDUPS - Monday, March 18, 2026

### 🟢 Tech Lead (10:05 AM)
**Name:** [Tech Lead Name]  
**Yesterday:** N/A (Project start)

**Today:**
- [ ] Create Firebase projects (dev/staging/prod)
- [ ] Initialize flutterfire configuration
- [ ] Set up GitHub Actions CI/CD
- [ ] Add Sentry account

**Blockers:** None yet

**Notes:** Kickoff meeting confirms team ready for development

---

### 🟢 Flutter Dev 1 (10:08 AM)
**Name:** [Dev 1 Name]  
**Yesterday:** N/A

**Today:**
- [ ] Clone repository
- [ ] Run `flutter pub get`
- [ ] Verify `flutter run -d chrome` works
- [ ] Review project structure documentation

**Blockers:** Waiting for Firebase setup before testing connectivity

**Notes:** Ready to start after Tech Lead completes Firebase config

---

### 🟢 Flutter Dev 2 (10:11 AM)
**Name:** [Dev 2 Name]  
**Yesterday:** N/A

**Today:**
- [ ] Clone repository
- [ ] Install dependencies
- [ ] Setup development environment
- [ ] Review docs/DEV_GUIDE.md

**Blockers:** None

**Notes:** Ready to assist Tech Lead if needed

---

### 🟢 Backend Dev (10:14 AM)
**Name:** [Backend Dev Name]  
**Yesterday:** N/A

**Today:**
- [ ] Enable Firebase Auth in Firebase Console
- [ ] Configure phone sign-in provider
- [ ] Setup OTP verification settings
- [ ] Test with Firebase Emulator

**Blockers:** Waiting for Firebase projects from Tech Lead

**Notes:** Can proceed after Tech Lead creates dev project

---

## 📋 DAY 2 STANDUPS - Tuesday, March 19, 2026

### Template for Day 2

**Time:** 10:00 AM

**Tech Lead:**
```
Yesterday:
- ✅ Firebase projects created (dev/staging/prod)
- ✅ flutterfire configured
- ✅ GitHub Actions setup

Today:
- [ ] Verify all team members have flutterfire configured
- [ ] Setup Firebase Emulator locally
- [ ] Configure Sentry account
- [ ] Ensure CI/CD pipeline triggers on PR

Blockers: None
```

**Flutter Dev 1:**
```
Yesterday:
- ✅ Repository cloned
- ✅ flutter pub get completed
- ✅ flutter run verified locally

Today:
- [ ] Verify Firebase connectivity
- [ ] Review project architecture
- [ ] Setup IDE/editor extensions
- [ ] Prepare for auth UI (Sprint 2)

Blockers: None
```

**Flutter Dev 2:**
```
Yesterday:
- ✅ Setup environment
- ✅ Dependencies installed

Today:
- [ ] Run flutter run successfully
- [ ] Verify Firebase connection
- [ ] Review code structure
- [ ] Assist with any blocker resolution

Blockers: None
```

**Backend Dev:**
```
Yesterday:
- ✅ Auth providers enabled in Firebase
- ✅ Phone sign-in configured

Today:
- [ ] OTP settings configured
- [ ] Test Firebase Emulator locally
- [ ] Create auth Cloud Function skeleton
- [ ] Setup Cloud Functions environment

Blockers: None
```

---

## 📋 DAY 3 STANDUPS - Wednesday, March 20, 2026

**Status Check:**
- Architecture Review meeting at 2:00 PM
- All devs should have app running locally
- Firebase should be fully configured
- CI/CD pipeline should be green

---

## 📋 DAY 4 STANDUPS - Thursday, March 21, 2026

**Focus:** Code Review & PR Merging
- All PRs should be reviewed
- Blockers should be resolved
- Main branch should be clean

---

## 📋 DAY 5 STANDUPS - Friday, March 22, 2026

**Final Status:**
- Sprint Review at 4:00 PM
- All tasks should be complete
- Ready for Sprint 2

---

## 🚨 ESCALATION PROCESS

**If blocked:**
1. Post in `#flora-match-dev` immediately
2. Tag: `@tech-lead` or relevant owner
3. SLA: Response within 1 hour
4. If critical: Mention @channel

**Example Blocker Message:**
```
🚨 BLOCKER: Cannot run flutterfire configure
- Error: [Copy error message]
- Device: [OS/version]
- What I tried: [Steps taken]
- Assign to: @tech-lead
- Impact: Blocking dev environment setup
- Severity: High (blocking entire team)
```

---

## 📊 SPRINT 1 STATUS TRACKING

| Date | Day | Tech Lead | Dev 1 | Dev 2 | Backend | Overall |
|------|-----|-----------|-------|-------|---------|---------|
| 3/18 | Mon | 🟡 In Progress | 🟡 In Progress | 🟡 In Progress | 🟡 In Progress | 🟡 On Track |
| 3/19 | Tue | 🟡 | 🟡 | 🟡 | 🟡 | 🟡 |
| 3/20 | Wed | 🟡 | 🟡 | 🟡 | 🟡 | 🟡 |
| 3/21 | Thu | 🟡 | 🟡 | 🟡 | 🟡 | 🟡 |
| 3/22 | Fri | ✅ | ✅ | ✅ | ✅ | ✅ |

---

## 📝 NOTES & DECISIONS

**Monday (3/18):**
- [ ] Any decisions made?
- [ ] Any scope changes?
- [ ] Any risks identified?

**Thursday (3/21):**
- [ ] Code review findings?
- [ ] Quality issues?
- [ ] Improvements for Sprint 2?

**Friday (3/22):**
- [ ] Sprint complete?
- [ ] Ready for Phase 1?
- [ ] Retrospective notes?

---

**Next:** Share this template daily in `#flora-match-dev` Slack channel

