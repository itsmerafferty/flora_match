# Flora Match - Architecture Overview

**Version:** 1.0 | **Last Updated:** March 18, 2026

---

## System Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                    Mobile App (Flutter)                      │
│  ┌──────────────┬──────────────┬──────────────────────────┐ │
│  │ Buyer UI     │ Seller UI    │ Admin Dashboard          │ │
│  │ - Browse     │ - Products   │ - Orders Overview        │ │
│  │ - Cart       │ - Orders     │ - Disputes               │ │
│  │ - Checkout   │ - Analytics  │ - Moderation            │ │
│  └──────────────┴──────────────┴──────────────────────────┘ │
│  ┌──────────────────────────────────────────────────────┐   │
│  │      State Management (BLoC / Provider)              │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
                             │
                   ┌─────────┴─────────┐
                   │                   │
        ┌──────────▼──────────┐    ┌──▼────────────────────┐
        │  Firebase SDK       │    │  Payment Gateway SDK  │
        │  ┌──────────────┐   │    │  (Xendit)             │
        │  │ Auth         │   │    │                       │
        │  │ Firestore    │   │    │ Create invoice        │
        │  │ Storage      │   │    │ Handle redirect       │
        │  │ FCM (push)   │   │    │ Webhook callback      │
        │  └──────────────┘   │    └─────────────────────┘
        └─────────────────────┘
                   │
       ┌───────────┴────────────┐
       │                        │
  ┌────▼──────────────┐   ┌────▼────────────────────┐
  │  Firebase Backend │   │  Payment Gateway        │
  │  (GCP)            │   │  (Xendit - Indonesia)   │
  │ ┌──────────────┐  │   │ ┌────────────────────┐  │
  │ │ Firestore    │  │   │ │ Payment Inv. API   │  │
  │ │ - Collections│  │   │ │ - Create invoice   │  │
  │ │ - Rules      │  │   │ │ - Webhook endpoint │  │
  │ │ - Indexes    │  │   │ │ - Settlement       │  │
  │ │              │  │   │ └────────────────────┘  │
  │ │ Cloud Func   │  │   │ ┌────────────────────┐  │
  │ │ - createOrder│  │   │ │ Payout API         │  │
  │ │ - processPaym│  │   │ │ - Bank transfers   │  │
  │ │ - settlement │  │   │ │ - GCash disbursem. │  │
  │ │ - refund     │  │   │ └────────────────────┘  │
  │ └──────────────┘  │   └────────────────────────┘
  │ ┌──────────────┐  │
  │ │ Monitoring   │  │
  │ │ - Crashlytics│  │
  │ │ - Analytics  │  │
  │ │ - Logging    │  │
  │ └──────────────┘  │
  └────────────────────┘
```

---

## Technology Stack

### Frontend (Flutter)
- **Language:** Dart 3.7+
- **State Management:** BLoC/Riverpod (TBD - Sprint 1)
- **Navigation:** GoRouter
- **HTTP Client:** Dio
- **Local Storage:** Hive / GetStorage
- **Firebase SDK:** firebase_core, cloud_firestore, firebase_auth, firebase_storage, firebase_messaging
- **Payment:** xendit SDK (WebView wrapper)
- **UI:** Material Design 3

### Backend
- **Primary:** Firebase (Firestore + Cloud Functions + Storage)
- **Functions Runtime:** Node.js 18+
- **Authentication:** Firebase Auth
- **Payment Gateway:** Xendit API (REST)
- **Scheduled Jobs:** Cloud Scheduler
- **Observability:** Sentry, Firebase Analytics, Cloud Logging

### Infrastructure
- **Hosting:** Firebase Hosting (app shell) + CDN
- **Database:** Cloud Firestore (NoSQL)
- **File Storage:** Firebase Storage (GCS)
- **CI/CD:** GitHub Actions → Firebase Deployment
- **Monitoring:** Firebase Console, Sentry, Uptime Checks

### Development Tools
- **Version Control:** Git / GitHub
- **Package Management:** Flutter pub, npm
- **Testing:** Flutter test framework + Firebase emulator
- **IDE:** VS Code / Android Studio
- **Documentation:** Markdown (GitHub)

---

## Data Flow

### 1. Authentication Flow
```
Mobile App
  │
  ├─► Firebase Auth SDK
  │     │
  │     ├─► Phone/Email sign-up
  │     │
  │     └─► OTP verification
  │
  ├─► Save auth token locally
  │
  └─► Store user role in Firestore (users/{uid})
```

### 2. Product Browse Flow
```
Buyer App
  │
  ├─► Firestore query: products where status='active'
  │
  ├─► Pagination: limit 20, cursor-based
  │
  ├─► Cache results locally (Hive)
  │
  └─► Display in ListView with images from Storage
```

### 3. Order Checkout Flow
```
Buyer App
  │
  ├─► Send cart to Cloud Function (createOrder)
  │     │
  │     ├─► Validate stock (inventory collection)
  │     │
  │     ├─► Calculate totals (price + fee + tax + shipping)
  │     │
  │     ├─► Reserve stock
  │     │
  │     └─► Return order ID
  │
  ├─► Create payment intent via Xendit API
  │
  ├─► Redirect to Xendit payment page (WebView)
  │
  └─► Listen for payment webhook
        │
        ├─► Cloud Function updates order status → paid
        │
        └─► Push notification to buyer & seller
```

### 4. Settlement Flow
```
Daily Cloud Scheduler Job (1 AM UTC+8)
  │
  ├─► Query orders: status='delivered', deliveredAt > 7 days ago
  │
  ├─► Aggregate seller earnings (minus fees)
  │
  ├─► Create settlement record
  │
  ├─► Call Xendit Payout API
  │     │
  │     ├─► Transfer to BDO account OR
  │     │
  │     └─► Transfer to GCash account
  │
  ├─► Update settlement status
  │
  └─► Log transaction (immutable)
```

---

## Project Structure

```
flora_match/
├── lib/
│   ├── main.dart                      # App entry point
│   ├── config/
│   │   ├── firebase_config.dart
│   │   ├── env_config.dart
│   │   └── payment_config.dart
│   ├── core/
│   │   ├── errors/
│   │   │   ├── exceptions.dart
│   │   │   └── failures.dart
│   │   ├── constants/
│   │   │   ├── app_constants.dart
│   │   │   ├── payout_constants.dart
│   │   │   └── payment_constants.dart
│   │   └── utils/
│   │       ├── logger.dart
│   │       ├── validators.dart
│   │       └── formatters.dart
│   ├── features/
│   │   ├── auth/
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   ├── buyer/
│   │   │   ├── browse/
│   │   │   ├── cart/
│   │   │   ├── checkout/
│   │   │   └── orders/
│   │   ├── seller/
│   │   │   ├── products/
│   │   │   ├── orders/
│   │   │   ├── wallet/
│   │   │   └── analytics/
│   │   ├── payments/
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   ├── orders/
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   └── admin/
│   │       ├── dashboard/
│   │       ├── moderation/
│   │       └── disputes/
│   └── shared/
│       ├── models/
│       ├── widgets/
│       └── repositories/
├── docs/
│   ├── architecture/
│   │   ├── firebase_schema.md
│   │   ├── firestore_security_rules.md
│   │   ├── payment_provider_matrix_ph.md
│   │   └── README.md
│   ├── roadmap/
│   │   ├── ph_12_week_sprints.md
│   │   └── post_mvp_features.md
│   └── DEV_GUIDE.md
├── functions/               # Firebase Cloud Functions (Node.js)
│   ├── src/
│   │   ├── orders/
│   │   │   └── createOrder.ts
│   │   ├── payments/
│   │   │   ├── processWebhook.ts
│   │   │   └── reconcile.ts
│   │   ├── settlements/
│   │   │   └── releasePayout.ts
│   │   └── shared/
│   │       ├── logger.ts
│   │       └── validators.ts
│   └── package.json
├── test/
│   ├── unit/
│   ├── integration/
│   └── e2e/
├── pubspec.yaml
├── pubspec.lock
├── analysis_options.yaml
├── firebase.json
└── .github/workflows/
    ├── test.yml
    └── deploy.yml
```

---

## Component Responsibility Matrix

| Component | Owner | Sprint | Phase |
|-----------|-------|--------|-------|
| **Flutter Core Setup** | Tech Lead | 1–2 | 0 |
| **Firebase Auth** | Backend Dev | 1–2 | 0 |
| **Firestore Schema** | Tech Lead | 1–2 | 0 |
| **Security Rules** | Tech Lead | 1–2 | 0 |
| **Buyer Browse** | Flutter Dev 1 | 3–4 | 1 |
| **Seller Products** | Flutter Dev 2 | 3–5 | 1 |
| **Orders & Cart** | Backend Dev | 3–5 | 1 |
| **Payments (Xendit)** | Backend Dev | 8–9 | 2 |
| **Settlement & Payout** | Backend Dev | 9–10 | 2 |
| **Shipping Integration** | Tech Lead | 11 | 3 |
| **Reviews & Ratings** | Flutter Dev 1 | 11 | 3 |
| **Admin Dashboard** | Flutter Dev 1 | 10 | 2 |

---

## Deployment Pipeline

```
Local Dev
  │
  ├─► Push to feature branch
  │
  ├─► GitHub Actions: Lint + Unit tests
  │
  ├─► Firebase Emulator: Integration tests
  │
  ├─► Merge to main
  │
  ├─► GitHub Actions: Build APK/IPA
  │
  ├─► Deploy to Firebase Hosting (staging)
  │
  ├─► Manual QA testing (5 days)
  │
  ├─► Approve for production
  │
  ├─► Deploy to Firebase (production)
  │
  ├─► Deploy Cloud Functions (production)
  │
  └─► Monitor: Sentry + Firebase Analytics
```

---

## Key Decision Points

### Sprint 1–2 (Phase 0)
- [ ] Confirm Firebase projects (dev/staging/prod)
- [ ] Approve authentication flow (phone OTP)
- [ ] Finalize Firestore schema
- [ ] Lock security rules

### Sprint 7 (Phase 1 exit)
- [ ] All commerce features working (order to receipt)
- [ ] Product search indexed
- [ ] Performance baselines met (<2s page load)

### Sprint 8 (Phase 2 entry)
- [ ] Xendit integration ready
- [ ] Webhook receiver tested
- [ ] Sandbox payment flows validated

### Sprint 12 (Launch)
- [ ] Security audit passed
- [ ] App store approved
- [ ] Production cutover complete

---

## Observability & Monitoring

### Metrics to Track (from Day 1)
- **Performance:** Page load time, Firestore query latency
- **Reliability:** Error rate, webhook delivery success
- **Business:** Order count, payment success rate, refund rate
- **Security:** Failed auth attempts, suspicious transactions

### Alert Thresholds
- Payment webhook failure rate > 1%
- Firestore query latency > 500ms (p95)
- Settlement job failure
- Authentication spike (>1000 attempts/min)

### Dashboards
- **Developer:** Error rate, crash details (Sentry)
- **Operations:** Order status, payment metrics, settlement queue
- **Business:** Revenue, user growth, NPS

---

## Risk Registry

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|-----------|
| Payment gateway outage | Low | High | COD backup, retry queue |
| Firestore scaling costs | Medium | Medium | Query optimization, denormalization |
| Security rule bypass | Low | High | Audit + penetration test (Sprint 12) |
| Third-party API delays | Medium | Medium | Early integration, sandbox testing |
| Regulatory compliance | Low | High | Legal review, compliance tracking |

---

## Next Steps

1. **Immediate (Week 1):** Set up GitHub repo, Firebase projects, CI/CD
2. **Week 1–2:** Complete Phase 0 setup
3. **Week 3:** Kick off Phase 1 (buyer browse)
4. **Week 8:** Begin Phase 2 (payments)
5. **Week 11:** Phase 3 (logistics)
6. **Week 12:** Launch

