# Flora Match - Philippines 12-Week Sprint Plan

**Target Launch:** June 2026 | **Market:** Philippines | **Team Capacity:** 30 SP/week (3 devs)  
**Sprint Duration:** 5 days | **Total Capacity:** 360 story points over 12 weeks

---

## PHASE 0: FOUNDATION (Weeks 1–2) — 40 SP

### Sprint 1 (Week 1: Mar 18–22, 2026) — 20 SP

| Item | Description | Owner | SP | Notes |
|------|-------------|-------|----|----|
| **PROJ-001** | Set up Flutter project structure (clean architecture) | Tech Lead | 5 | Feature/data/domain/presentation layers |
| **PROJ-002** | Initialize Firebase project & configure flutterfire | DevOps | 5 | Dev/staging/prod Firebase projects |
| **PROJ-003** | Set up CI/CD pipeline (GitHub Actions → Firebase hosting) | DevOps | 5 | Automated testing & deployment gates |
| **PROJ-004** | Add Sentry & Firebase Analytics for crash tracking | Tech Lead | 3 | Error reporting & basic analytics |
| **AUTH-001** | Implement Firebase Auth skeleton (phone + email sign-up) | Backend Dev | 2 | Auth providers setup only, no UI yet |

**Exit Criteria:** 
- ✅ All team members can run app locally with Firebase connected
- ✅ CI/CD pipeline deploys to staging on PR
- ✅ Crash tracking reporting to Sentry

---

### Sprint 2 (Week 2: Mar 25–29, 2026) — 20 SP

| Item | Description | Owner | SP | Notes |
|------|-------------|-------|----|----|
| **AUTH-002** | Build auth UI layer (phone verification, OTP) | Flutter Dev 1 | 5 | Phone OTP via Firebase |
| **AUTH-003** | Implement role-based access control middleware | Backend Dev | 5 | Buyer/Seller/Admin role routing |
| **CONFIG-001** | Environment config (dev/staging/prod) | Tech Lead | 3 | .env file handling, API base URLs |
| **DB-001** | Draft Firestore schema & create test collections | Tech Lead | 5 | Initial collections: users, products, orders |
| **TEST-001** | Set up unit & widget test framework | QA Lead | 2 | Test structure & CI integration |

**Exit Criteria:**
- ✅ Phone auth flow end-to-end (signup → OTP → verified)
- ✅ Role selection page works (Buyer/Seller choice)
- ✅ Environment config in place (can switch Firebase projects)
- ✅ First Firestore queries working

---

**Phase 0 Total:** 40 SP ✅

---

## PHASE 1: COMMERCE MVP CORE (Weeks 3–7) — 100 SP

### Sprint 3 (Week 3: Apr 1–5, 2026) — 30 SP

| Item | Description | Owner | SP | Notes |
|------|-------------|-------|----|----|
| **BUYER-001** | Build buyer profile & address book screen | Flutter Dev 1 | 5 | Save 2–3 delivery addresses |
| **SELLER-001** | Build seller store setup wizard (Step 1: store name, logo) | Flutter Dev 2 | 5 | Store info + document upload prep |
| **PRODUCT-001** | Seller can create single product (name, price, image, stock) | Flutter Dev 2 | 8 | Upload to Firebase Storage |
| **PRODUCT-002** | Implement product detail page (buyer view) | Flutter Dev 1 | 5 | Display seller info + reviews (empty at MVP) |
| **CART-001** | Build shopping cart data model & add-to-cart logic | Backend Dev | 5 | In-memory cart, persist to Firestore |
| **CONFIG-002** | Set up pricing engine (base price, platform fee, tax) | Tech Lead | 2 | PH 12% VAT calculation |

**Exit Criteria:**
- ✅ Seller can upload product; Buyer can see it
- ✅ Buyer can add product to cart, view cart
- ✅ Prices calculated correctly (fee + tax)

---

### Sprint 4 (Week 4: Apr 8–12, 2026) — 30 SP

| Item | Description | Owner | SP | Notes |
|------|-------------|-------|----|----|
| **PRODUCT-003** | Add SKU/variation support (size, color) | Flutter Dev 2 | 5 | Variant stock tracking |
| **BUYER-002** | Build product search & category browse | Flutter Dev 1 | 8 | Full-text search + Firestore indexing |
| **CHECKOUT-001** | Build checkout flow UI (cart → shipping → confirm) | Flutter Dev 1 | 8 | Shipping address selection, delivery option |
| **ORDER-001** | Implement order creation function (backend) | Backend Dev | 5 | Reserve stock, generate order ID, validate pricing |
| **SELLER-002** | Build seller order list & order detail page | Flutter Dev 2 | 4 | View order items, customer address |

**Exit Criteria:**
- ✅ End-to-end checkout flow (cart → place order)
- ✅ Order appears in seller order list
- ✅ Stock reserved, cart cleared after order placed

---

### Sprint 5 (Week 5: Apr 15–19, 2026) — 30 SP

| Item | Description | Owner | SP | Notes |
|------|-------------|-------|----|----|
| **ORDER-002** | Build order status state machine (backend) | Backend Dev | 5 | pending → paid → packed → shipped → delivered |
| **ORDER-003** | Implement buyer order list & order tracking | Flutter Dev 1 | 5 | View all orders, status timeline |
| **SELLER-003** | Add seller order action buttons (accept/reject/pack) | Flutter Dev 2 | 5 | Seller fulfillment workflow |
| **SHIPMENT-001** | Integrate mock shipping cost calculation | Tech Lead | 5 | Distance-based fee for PH regions |
| **VOUCHER-001** | Add promo code / voucher system (backend) | Backend Dev | 5 | Discount calculations, validity checks |
| **ANALYTICS-001** | Set up order & revenue metrics tracking | DevOps | 5 | Dashboard prep for Phase 4 |

**Exit Criteria:**
- ✅ Full order lifecycle: place → seller accept → pack → buyer receives
- ✅ Voucher discount applies correctly
- ✅ Order tracking updates reflect seller actions

---

### Sprint 6 (Week 6: Apr 22–26, 2026) — 40 SP

| Item | Description | Owner | SP | Notes |
|------|-------------|-------|----|----|
| **INVENTORY-001** | Real-time stock sync & low-stock alerts | Backend Dev | 5 | Prevent overselling, alert seller |
| **SELLER-004** | Build seller inventory dashboard (stock levels, quick edit) | Flutter Dev 2 | 5 | Batch stock update support |
| **BUYER-003** | Add wishlist feature (save for later) | Flutter Dev 1 | 3 | Persistent wishlist |
| **PAYMENT-001** | Design payment intent schema & backend routes (skeleton) | Tech Lead | 5 | Prep for Phase 2 (no actual payment yet) |
| **DISPUTE-001** | Build order cancellation workflow (buyer cancels pre-ship) | Backend Dev | 5 | Refund logic, cancel policy windows |
| **NOTIFICATION-001** | Integrate FCM for order status notifications | Tech Lead | 5 | Notification templates, Firebase Cloud Functions |
| **SELLER-005** | Seller basic payout account setup screen | Flutter Dev 2 | 5 | Bank account + BDO/GCash selection (no validation yet) |
| **PERFORMANCE-001** | Query optimization, Firestore indexing review | Tech Lead | 2 | Reduce N+1 queries, set up indexes |

**Exit Criteria:**
- ✅ Stock cannot go negative (tested)
- ✅ Buyer receives push notification on order status change
- ✅ Seller can cancel order, buyer refund initiated

---

### Sprint 7 (Week 7: Apr 29–May 3, 2026) — 30 SP

| Item | Description | Owner | SP | Notes |
|------|-------------|-------|----|----|
| **SELLER-006** | Seller performance dashboard (total orders, sales, rating) | Flutter Dev 2 | 5 | Summary cards, basic analytics |
| **RETURN-001** | Build return/refund request intake (buyer submits reason) | Flutter Dev 1 | 5 | Form capture, photo upload, backend routing |
| **RETURN-002** | Implement return approval workflow (seller/admin decision) | Backend Dev | 5 | Policy engine, auto-approval for clear cases |
| **MODERATION-001** | Basic product flagging for admin review | Flutter Dev 2 | 3 | Report inappropriate product |
| **REPORT-001** | Generate basic sales & order reports (CSV export) | Tech Lead | 5 | Daily/weekly report templates |
| **COMPLIANCE-001** | Document data privacy policy & terms of service | PM | 2 | PH regulatory compliance checklist |

**Exit Criteria:**
- ✅ Phase 1 MVP complete: full browse → buy → fulfill → receive cycle works
- ✅ Refund requests can be submitted & approved
- ✅ Seller dashboard shows KPIs
- ✅ All Phase 1 user stories tested & passed QA

---

**Phase 1 Total:** 100 SP ✅

---

## PHASE 2: PAYMENTS + SETTLEMENT (Weeks 8–10) — 80 SP

### Sprint 8 (Week 8: May 6–10, 2026) — 30 SP

| Item | Description | Owner | SP | Notes |
|------|-------------|-------|----|----|
| **PAY-001** | Select & integrate primary payment gateway (Xendit recommended) | Tech Lead | 8 | API keys, SDK setup, sandbox testing |
| **PAY-002** | Implement payment intent creation (order → payment session) | Backend Dev | 5 | Xendit createPayment() flow |
| **PAY-003** | Build payment method selection UI (GCash, card, bank) | Flutter Dev 1 | 5 | Payment method picker, amount display |
| **PAY-004** | Integrate Xendit payment widget (webview) | Flutter Dev 1 | 5 | User enters card/GCash details securely |
| **PAY-005** | Implement webhook receiver & signature verification | Backend Dev | 5 | Validate Xendit callbacks, idempotency keys |
| **TEST-002** | Write payment flow integration tests (success + failure cases) | QA Lead | 2 | Sandbox payment simulation |

**Exit Criteria:**
- ✅ End-to-end paid order flow: order → select GCash/Card → pay → webhook confirms
- ✅ Order status auto-transitions to "paid" after successful payment
- ✅ Failed payment doesn't create duplicate orders

---

### Sprint 9 (Week 9: May 13–17, 2026) — 30 SP

| Item | Description | Owner | SP | Notes |
|------|-------------|-------|----|----|
| **PAY-006** | Add COD (Cash on Delivery) option as backup | Backend Dev | 3 | COD order handling, seller confirmation |
| **PAY-007** | Implement payment reconciliation job (daily) | Backend Dev | 5 | Compare Xendit ledger vs internal orders |
| **PAY-008** | Build seller wallet (balance, transaction history) | Flutter Dev 2 | 5 | Show available + pending balance |
| **SETTLE-001** | Implement settlement release workflow (7-day hold) | Backend Dev | 5 | Auto-release funds after buyer confirms delivery |
| **SETTLE-002** | Create settlement payout batch job (daily/weekly) | Backend Dev | 5 | BDO/GCash disbursement orchestration |
| **REFUND-001** | Implement full refund flow (customer → payment gateway) | Backend Dev | 5 | Xendit refund API, reverse to buyer wallet |
| **COMPLIANCE-002** | Enable payment audit logging & transaction signing | Tech Lead | 2 | Immutable transaction records for PH regulations |

**Exit Criteria:**
- ✅ Seller receives payout 7 days after buyer confirmed delivery
- ✅ Refunds process correctly & appear in buyer wallet
- ✅ Daily reconciliation job runs, alerts on mismatches

---

### Sprint 10 (Week 10: May 20–24, 2026) — 20 SP

| Item | Description | Owner | SP | Notes |
|------|-------------|-------|----|----|
| **DISPUTE-002** | Implement payment dispute / chargeback handling | Backend Dev | 5 | Hold seller payout, escalate to admin |
| **ADMIN-001** | Build admin dashboard (order overview, payment status, disputes) | Flutter Dev 1 | 5 | Real-time KPI cards, manual override buttons |
| **ALERT-001** | Set up payment failure alerts & retry logic | Tech Lead | 5 | Auto-retry failed payments, notify parties |
| **REPORT-002** | Generate settlement & payout reports for finance team | Tech Lead | 5 | Daily/weekly finance reconciliation exports |

**Exit Criteria:**
- ✅ Xendit payment integration is production-ready
- ✅ All payment scenarios tested (success, failure, chargeback, refund)
- ✅ Admin can view & override disputes
- ✅ Finance team can reconcile daily via reports

---

**Phase 2 Total:** 80 SP ✅

---

## PHASE 3: LOGISTICS + POST-PURCHASE (Weeks 11–12) — 60 SP

### Sprint 11 (Week 11: May 27–31, 2026) — 30 SP

| Item | Description | Owner | SP | Notes |
|------|-------------|-------|----|----|
| **SHIP-001** | Integrate shipping provider API (e.g., LBC, J&T for PH) | Tech Lead | 5 | Shipping rate lookup, label generation |
| **SHIP-002** | Add shipment tracking sync (polling from carrier) | Backend Dev | 5 | Update order status as package moves |
| **BUYER-004** | Build buyer order tracking map & real-time status | Flutter Dev 1 | 5 | Show delivery estimate, carrier tracking link |
| **SELLER-007** | Add seller shipment label printing (PDF export) | Flutter Dev 2 | 5 | Pre-fill carrier data, print-ready labels |
| **REVIEW-001** | Build review & rating submission UI (post-delivery) | Flutter Dev 1 | 5 | Star rating + text review for seller & product |
| **REVIEW-002** | Implement review moderation & display (seller profile) | Backend Dev | 5 | Average rating, review feed, filter helpful |

**Exit Criteria:**
- ✅ Seller can print shipping label with tracking number
- ✅ Buyer sees real-time tracking updates
- ✅ Buyer can submit review after delivery confirmed
- ✅ Reviews visible on seller profile & product detail

---

### Sprint 12 (Week 12: Jun 3–7, 2026) — 30 SP

| Item | Description | Owner | SP | Notes |
|------|-------------|-------|----|----|
| **PARTIAL-REFUND** | Implement partial refund / return goods flow | Backend Dev | 5 | Buyer returns item, seller inspects, approves refund |
| **DISPUTE-003** | Add buyer-seller dispute resolution chat | Flutter Dev 1 | 5 | Real-time messaging for return disputes |
| **PERFORMANCE-002** | Full performance optimization (caching, lazy load) | Tech Lead | 3 | Image optimization, Firestore pagination |
| **SECURITY-001** | Security audit & penetration test (third-party) | Tech Lead | 5 | CVE scan, rule validation, fraud checks |
| **UAT-001** | User acceptance testing & bug bash (QA + team) | QA Lead | 5 | Regression testing, critical path validation |
| **LAUNCH-001** | App store submission (Google Play + App Store) | DevOps | 2 | Build production APK/IPA, store listing |

**Exit Criteria:**
- ✅ All Phase 3 features working (shipping, reviews, returns)
- ✅ Zero critical bugs in QA signoff
- ✅ Security audit passed
- ✅ App live on Play Store & App Store
- ✅ Launch checklist signed off

---

**Phase 3 Total:** 60 SP ✅

---

## SUMMARY

| Phase | Weeks | Total SP | Focus |
|-------|-------|----------|-------|
| **Phase 0: Foundation** | 1–2 | 40 | Project setup, auth, Firebase |
| **Phase 1: Commerce MVP** | 3–7 | 100 | Browse, cart, order, fulfillment |
| **Phase 2: Payments** | 8–10 | 80 | Xendit integration, settlement, refunds |
| **Phase 3: Logistics & Launch** | 11–12 | 60 | Shipping, reviews, final polish & app store |
| **GRAND TOTAL** | **12** | **280** | **Production MVP ready for Philippines** |

---

## Team Allocation

- **Tech Lead (1):** Architecture, infrastructure, DevOps, security
- **Flutter Dev 1 (1):** Buyer UI, payment UI, admin dashboard
- **Flutter Dev 2 (1):** Seller UI, product management, inventory
- **Backend Dev (1):** Orders, payments, settlement, webhooks, Cloud Functions
- **QA Lead (1):** Test automation, UAT, security, compliance (part-time or shared)
- **PM (1):** Roadmap, stakeholder alignment, go-to-market (shared across projects)

---

## Risk Mitigation

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|-----------|
| Payment gateway integration delays | Medium | High | Select Xendit early (Week 8), sandbox test from Sprint 3 |
| Firestore cost spike on launch | Medium | Medium | Query optimization in Phase 1, indexes planned by Sprint 7 |
| Third-party shipping API delays | Low | Medium | Mock shipping until real integration (Sprint 11 is late) |
| Security compliance gaps (PH regulations) | Medium | High | Legal review by Sprint 7, compliance check in Sprint 12 |
| Scope creep post-MVP | High | High | Strict backlog gate; all V2 features move to post-launch |

---

## Decision Gates

- **Sprint 2 End:** ✅ Approve Firebase schema, confirm role-based access working
- **Sprint 7 End:** ✅ Phase 1 MVP complete; decide on Phase 2 payment provider
- **Sprint 10 End:** ✅ Payment integration stable; approve Phase 3 shipping vendor
- **Sprint 12 End:** ✅ Security audit passed; sign off app store submission

---

## Next Steps

1. **Confirm team allocation** (PM to assign owners to Sprint 1 items)
2. **Lock Firebase project** (Tech Lead to create dev/staging/prod projects)
3. **Kick off Sprint 1** (Mar 18 standup + backlog refinement)
4. **Review payment provider matrix** (Tech Lead to present Xendit vs Midtrans vs Stripe)

