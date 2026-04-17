# Flora Match: 12-Week Sprint Plan (5-Day Sprints)

**Version:** 1.0  
**Target Market:** Philippines  
**Team Capacity:** 30 SP/week (3 developers)  
**Total Scope:** 280 story points  
**MVP Goal:** Operational marketplace with Seller/Buyer roles, Products, Orders, and Xendit Payments

---

## Timeline Overview

| Phase | Weeks | Sprints | Story Points | Goal |
|-------|-------|---------|--------------|------|
| **Foundation** | 1-2 | 1-2 | 40 SP | Project setup, Firebase, CI/CD, Auth skeleton |
| **Commerce MVP** | 3-7 | 3-7 | 100 SP | Core marketplace features (products, cart, orders) |
| **Payments & Settlement** | 8-10 | 8-10 | 80 SP | Xendit integration, wallets, seller payouts |
| **Logistics & Launch** | 11-12 | 11-12 | 60 SP | Shipping, tracking, reviews, optimization, launch |

---

## Phase 0: Foundation (Weeks 1-2, 40 SP)

### Sprint 1: Project Setup & Firebase Multi-Env (Week 1, Days 1-5)

**Goal:** Validate Flutter project structure, configure Firebase for dev/staging/prod environments, establish CI/CD pipeline

| Story | Story Points | Type | Description |
|-------|--------------|------|-------------|
| **FOUND-001** | 5 | Backend | Setup multi-environment Firebase configuration (dev/staging/prod) with separate projects |
| **FOUND-002** | 3 | Backend | Configure Sentry error monitoring and analytics tracking |
| **FOUND-003** | 3 | Backend | Setup GitHub Actions CI/CD pipeline for Flutter builds (Android/iOS) |
| **FOUND-004** | 3 | DevOps | Configure Firebase Firestore security rules baseline and enable production mode |
| **FOUND-005** | 5 | Frontend | Create login/registration UI skeleton with phone number input (Firebase Phone Auth) |
| **FOUND-006** | 3 | Backend | Implement Cloud Functions boilerplate for user onboarding webhook |
| **FOUND-007** | 5 | Testing | Setup test environment, configure Firebase Emulator Suite locally |
| **FOUND-008** | 5 | Backend | Create Database migrations strategy and version tracking system |

**Sprint 1 Velocity:** 32 SP  
**Dependencies:** None  
**Risks:** Firebase project creation delays, GCP billing setup

---

### Sprint 2: Authentication & User Roles (Week 2, Days 1-5)

**Goal:** Implement phone-based authentication with seller/buyer role assignment

| Story | Story Points | Type | Description |
|-------|--------------|------|-------------|
| **AUTH-001** | 5 | Backend | Implement phone OTP verification with Firebase Phone Auth |
| **AUTH-002** | 5 | Frontend | Create OTP verification UI with countdown timer and retry logic |
| **AUTH-003** | 3 | Backend | Implement user role assignment (seller/buyer) in Firestore during signup |
| **AUTH-004** | 5 | Frontend | Create role selection screen during registration (Buyer/Seller/Both) |
| **AUTH-005** | 3 | Backend | Create Auth token refresh and session management |
| **AUTH-006** | 3 | Backend | Implement logout and session cleanup |
| **AUTH-007** | 5 | Frontend | Create auth state BLoC (Authentication management layer) |
| **MONITORING-001** | 3 | DevOps | Setup Firebase Crashlytics integration |

**Sprint 2 Velocity:** 32 SP  
**Dependencies:** Sprint 1 must complete  
**Risks:** Phone Auth quota limits in Philippines

---

## Phase 1: Commerce MVP Core (Weeks 3-7, 100 SP)

### Sprint 3: Buyer Onboarding & Profile (Week 3, Days 1-5)

**Goal:** Complete buyer registration flow and profile management

| Story | Story Points | Type | Description |
|-------|--------------|------|-------------|
| **BUYER-001** | 3 | Frontend | Create buyer profile completion screen (name, address, phone) |
| **BUYER-002** | 5 | Backend | Firestore collection: `users` with buyer profile schema |
| **BUYER-003** | 3 | Backend | Implement address validation API integration |
| **BUYER-004** | 3 | Frontend | Create address management UI (add/edit/delete addresses) |
| **BUYER-005** | 3 | Backend | Implement user preference storage (delivery location, notifications) |
| **SELLER-001** | 5 | Frontend | Create seller store setup wizard (name, category, description, logo) |
| **SELLER-002** | 5 | Backend | Firestore collection: `stores` with seller shop profile schema |
| **SELLER-003** | 5 | Backend | Implement store verification status tracking |

**Sprint 3 Velocity:** 32 SP  
**Dependencies:** Sprint 2 (Auth) must complete  
**Risks:** Address API rate limits

---

### Sprint 4: Product Management & Search (Week 4, Days 1-5)

**Goal:** Implement seller product CRUD and buyer search functionality

| Story | Story Points | Type | Description |
|-------|--------------|------|-------------|
| **PRODUCT-001** | 5 | Backend | Firestore collection: `products` with schema (name, desc, price, images, seller_id) |
| **PRODUCT-002** | 5 | Frontend | Create product upload form (image picker, multiple images, variants) |
| **PRODUCT-003** | 3 | Backend | Implement image upload to Firebase Storage |
| **PRODUCT-004** | 5 | Frontend | Create seller product listing view (my products, edit, delete) |
| **PRODUCT-005** | 3 | Backend | Firestore collection: `inventory` (stock levels per variant) |
| **SEARCH-001** | 8 | Backend | Implement full-text search using Firestore + Algolia (or Meilisearch) for buyer search |
| **SEARCH-002** | 3 | Frontend | Create product search UI with filters (category, price range, rating) |
| **SEARCH-003** | 3 | Frontend | Create product detail view (images, specs, seller info, reviews placeholder) |

**Sprint 4 Velocity:** 35 SP  
**Blocked Until:** Xendit Sandbox account provisioned (for future integration)  
**Dependencies:** Sprint 3 (Profiles)  
**Risks:** Firestore indexing auto-creation, search service setup

---

### Sprint 5: Shopping Cart & Order Creation (Week 5, Days 1-5)

**Goal:** Implement cart functionality and order state machine

| Story | Story Points | Type | Description |
|-------|--------------|------|-------------|
| **CART-001** | 3 | Backend | Firestore collection: `carts` (user_id, items[], total, updated_at) |
| **CART-002** | 3 | Frontend | Create shopping cart UI (add/remove/update quantity) |
| **CART-003** | 3 | Backend | Implement real-time cart sync (Firestore listeners) |
| **CART-004** | 3 | Frontend | Create cart summary page (item list, totals, shipping estimate) |
| **ORDER-001** | 5 | Backend | Firestore collection: `orders` (order_id, buyer_id, seller_id, items[], status, total) |
| **ORDER-002** | 5 | Backend | Firestore collection: `orderItems` (order_id, product_id, quantity, price) |
| **ORDER-003** | 5 | Backend | Implement order state machine (CART → PENDING_PAYMENT → PAID → PROCESSING → SHIPPED → DELIVERED) |
| **ORDER-004** | 3 | Backend | Create Cloud Function to validate inventory before order creation |
| **ORDER-005** | 5 | Frontend | Create order confirmation screen after checkout |

**Sprint 5 Velocity:** 35 SP  
**Dependencies:** Sprint 4 (Products/Search)  
**Risks:** Real-time sync performance at scale

---

### Sprint 6: Checkout & Payment Processing (Week 6, Days 1-5)

**Goal:** Multi-step checkout flow ready for payment integration

| Story | Story Points | Type | Description |
|-------|--------------|------|-------------|
| **CHECKOUT-001** | 5 | Frontend | Create checkout flow UI (cart review → address selection → payment method) |
| **CHECKOUT-002** | 3 | Backend | Implement shipping cost calculation (based on location + weight) |
| **CHECKOUT-003** | 3 | Backend | Create `paymentMethods` collection (stored payment options per buyer) |
| **CHECKOUT-004** | 5 | Backend | Implement order creation from cart (atomic transaction, inventory deduction) |
| **CHECKOUT-005** | 5 | Backend | Create Cloud Function: `createPaymentIntent` (prepares for payment gateway) |
| **PAYMENT-PREP-001** | 3 | Backend | Implement Xendit API client library setup (sandbox testing) |
| **PAYMENT-PREP-002** | 3 | Backend | Create `payments` collection schema (payment_id, order_id, amount, status, gateway) |
| **CHECKOUT-006** | 5 | Frontend | Create payment method selection UI (placeholder for Xendit methods) |

**Sprint 6 Velocity:** 32 SP  
**Dependencies:** Sprint 5 (Orders)  
**Risks:** Shipping provider API integration delays

---

### Sprint 7: Seller Dashboard & Order Management (Week 7, Days 1-5)

**Goal:** Seller dashboard with order tracking and fulfillment workflow

| Story | Story Points | Type | Description |
|-------|--------------|------|-------------|
| **SELLER-DASH-001** | 5 | Frontend | Create seller dashboard main screen (revenue overview, pending orders count) |
| **SELLER-DASH-002** | 5 | Frontend | Create seller orders view (list orders, filter by status, mark as shipped) |
| **SELLER-DASH-003** | 3 | Backend | Implement seller analytics aggregation (total sales, order count, rating) |
| **SELLER-DASH-004** | 5 | Frontend | Create inventory management view (update stock, reorder alerts) |
| **FULFILLMENT-001** | 5 | Backend | Implement fulfillment workflow (PENDING → PROCESSING → SHIPPED → DELIVERED) |
| **FULFILLMENT-002** | 3 | Backend | Create Cloud Function for order status update notification |
| **FULFILLMENT-003** | 3 | Backend | Implement tracking number attachment to order |
| **NOTIFICATIONS-001** | 5 | Backend | Setup FCM (Firebase Cloud Messaging) for push notifications |
| **NOTIFICATIONS-002** | 3 | Frontend | Create notification listener and display UI |

**Sprint 7 Velocity:** 37 SP  
**Dependencies:** Sprint 5-6 (Orders, Checkout)  
**Risks:** FCM integration complexity

---

## Phase 2: Payments & Settlement (Weeks 8-10, 80 SP)

### Sprint 8: Xendit Payment Integration (Week 8, Days 1-5)

**Goal:** Full Xendit payment flow for orders

| Story | Story Points | Type | Description |
|-------|--------------|------|-------------|
| **XENDIT-001** | 5 | Backend | Implement Xendit API integration (authentication, charge creation) |
| **XENDIT-002** | 5 | Backend | Create charge creation Cloud Function with order validation |
| **XENDIT-003** | 5 | Frontend | Create Xendit payment UI (GCash, card, bank transfer options) |
| **XENDIT-004** | 5 | Backend | Implement Xendit webhook handler for payment status updates |
| **XENDIT-005** | 3 | Backend | Create webhook signature verification for security |
| **XENDIT-006** | 3 | Backend | Implement order status auto-update on payment success/failure |
| **XENDIT-007** | 5 | Frontend | Create payment success/failure confirmation screens |
| **COD-001** | 3 | Backend | Implement COD (Cash on Delivery) as backup payment method |
| **WALLET-001** | 5 | Backend | Create seller wallet system for payment accumulation |

**Sprint 8 Velocity:** 39 SP  
**Prerequisites:** Xendit sandbox API key obtained  
**Dependencies:** Sprint 6 (Checkout), Sprint 7 (Notifications)  
**Risks:** Xendit API rate limits, webhook timeout issues

---

### Sprint 9: Payment Reconciliation & Settlement (Week 9, Days 1-5)

**Goal:** Daily settlement reconciliation and seller payouts

| Story | Story Points | Type | Description |
|-------|--------------|------|-------------|
| **RECONCILIATION-001** | 5 | Backend | Create daily reconciliation Cloud Function (Xendit vs Firestore payments) |
| **RECONCILIATION-002** | 3 | Backend | Implement payment discrepancy alerting (Sentry) |
| **SETTLEMENT-001** | 5 | Backend | Implement 7-day settlement hold (funds locked until delivery confirmation) |
| **SETTLEMENT-002** | 5 | Backend | Create seller settlement schedule management |
| **SETTLEMENT-003** | 5 | Backend | Implement seller payout orchestration (BDO account details verification) |
| **WALLET-002** | 3 | Backend | Create `wallets` collection (seller_id, balance, pending_balance, released_balance) |
| **WALLET-003** | 3 | Backend | Implement wallet transaction logging (`transactions` collection) |
| **SETTLEMENT-004** | 5 | Frontend | Create seller wallet view (balance, transaction history, payout requests) |
| **CHARGEBACK-001** | 3 | Backend | Implement chargeback handling workflow |

**Sprint 9 Velocity:** 37 SP  
**Dependencies:** Sprint 8 (Xendit Integration)  
**Risks:** Bank API integration delays, reconciliation edge cases

---

### Sprint 10: Refunds & Dispute Management (Week 10, Days 1-5)

**Goal:** Complete refund flow and buyer/seller dispute resolution

| Story | Story Points | Type | Description |
|-------|--------------|------|-------------|
| **REFUND-001** | 5 | Backend | Create `refunds` collection schema (refund_id, order_id, reason, amount, status) |
| **REFUND-002** | 5 | Frontend | Create buyer refund request form (reason selection, images upload) |
| **REFUND-003** | 5 | Backend | Implement refund validation logic (refund window, inventory restoration) |
| **REFUND-004** | 3 | Backend | Create seller refund approval/rejection workflow |
| **REFUND-005** | 5 | Frontend | Create seller refund management view |
| **REFUND-006** | 3 | Backend | Implement automatic Xendit refund processing |
| **DISPUTE-001** | 5 | Backend | Create `disputes` collection for escalated cases |
| **DISPUTE-002** | 3 | Frontend | Create dispute chat/messaging UI |
| **ADMIN-DASHBOARD-001** | 5 | Frontend | Create admin dashboard for dispute/refund review |

**Sprint 10 Velocity:** 39 SP  
**Dependencies:** Sprint 8-9 (Payments, Settlement)  
**Risks:** Complex refund edge cases, dispute moderation burden

---

## Phase 3: Logistics & Launch (Weeks 11-12, 60 SP)

### Sprint 11: Shipping & Order Tracking (Week 11, Days 1-5)

**Goal:** Shipping provider integration and real-time tracking

| Story | Story Points | Type | Description |
|-------|--------------|------|-------------|
| **SHIPPING-001** | 5 | Backend | Integrate J&T Shipping API (label creation, tracking) |
| **SHIPPING-002** | 5 | Backend | Create `shipments` collection (shipment_id, order_id, tracking_number, carrier) |
| **SHIPPING-003** | 5 | Frontend | Create order tracking view (real-time status updates from J&T) |
| **SHIPPING-004** | 3 | Backend | Implement tracking webhook from J&T |
| **SHIPPING-005** | 5 | Frontend | Create shipping label printing for sellers |
| **SHIPPING-006** | 3 | Backend | Implement COD confirmation webhook (cash acceptance sync) |
| **REVIEWS-001** | 5 | Backend | Create `reviews` collection (order_id, rating, comment, seller_id) |
| **REVIEWS-002** | 3 | Frontend | Create review submission form (post-delivery) |
| **REVIEWS-003** | 3 | Frontend | Create product reviews display (star rating, comments, seller response) |

**Sprint 11 Velocity:** 37 SP  
**Prerequisites:** J&T API contract established  
**Dependencies:** Sprint 9 (Settlement)  
**Risks:** Carrier API documentation gaps, webhook reliability

---

### Sprint 12: Performance, Security & Launch (Week 12, Days 1-5)

**Goal:** Final optimization, security audit, and app store submission

| Story | Story Points | Type | Description |
|-------|--------------|------|-------------|
| **PERFORMANCE-001** | 5 | Backend | Optimize Firestore queries (add indexes, caching strategy) |
| **PERFORMANCE-002** | 3 | Frontend | Implement image lazy loading and pagination |
| **PERFORMANCE-003** | 3 | Backend | Setup CDN for static assets and product images |
| **SECURITY-001** | 5 | Backend | Complete Firestore security rules audit and penetration testing |
| **SECURITY-002** | 3 | Backend | Implement input validation and sanitization across APIs |
| **SECURITY-003** | 3 | Backend | Setup API rate limiting on Cloud Functions |
| **LAUNCH-001** | 5 | DevOps | Configure production Firebase project and data migration |
| **LAUNCH-002** | 3 | DevOps | Setup production logging and monitoring (Sentry, Analytics) |
| **LAUNCH-003** | 3 | DevOps | Prepare app store submission (Google Play, Apple App Store) |
| **UAT-001** | 5 | Testing | User Acceptance Testing and bug fixes |
| **DOCS-001** | 3 | DevOps | Create deployment runbook and incident response guide |

**Sprint 12 Velocity:** 40 SP  
**Dependencies:** Sprint 11 (Shipping)  
**Risks:** App store review delays, last-minute bug discoveries

---

## Backlog Breakdown by Feature Area

### Authentication & Authorization (40 SP)
- Phone OTP login (FOUND-005, AUTH-001, AUTH-002)
- Role assignment and management (AUTH-003, AUTH-004)
- Session management (AUTH-005, AUTH-006, AUTH-007)

### Buyer Features (25 SP)
- Profile management (BUYER-001 to BUYER-005)
- Address book (BUYER-004)

### Seller Features (45 SP)
- Store setup (SELLER-001 to SELLER-003)
- Dashboard (SELLER-DASH-001 to SELLER-DASH-004)
- Inventory management (SELLER-DASH-004, FULFILLMENT-001)
- Wallet & payouts (WALLET-*, SETTLEMENT-*)

### Product Management (30 SP)
- CRUD operations (PRODUCT-001 to PRODUCT-005)
- Image uploads (PRODUCT-003)

### Search & Discovery (15 SP)
- Full-text search (SEARCH-001, SEARCH-002)
- Filters and browsing (SEARCH-003)

### Shopping Cart & Checkout (25 SP)
- Cart management (CART-001 to CART-004)
- Multi-step checkout (CHECKOUT-001 to CHECKOUT-006)

### Orders & Fulfillment (35 SP)
- Order creation and state machine (ORDER-001 to ORDER-005)
- Order fulfillment workflow (FULFILLMENT-001 to FULFILLMENT-003)

### Payments (45 SP)
- Xendit integration (XENDIT-001 to XENDIT-007)
- COD support (COD-001)
- Wallet system (WALLET-001 to WALLET-003)

### Notifications & Messaging (15 SP)
- FCM push notifications (NOTIFICATIONS-001, NOTIFICATIONS-002)
- Dispute chat (DISPUTE-002)

### Refunds & Disputes (30 SP)
- Refund workflow (REFUND-001 to REFUND-006)
- Dispute management (DISPUTE-001 to DISPUTE-002)

### Shipping & Tracking (20 SP)
- Shipping provider integration (SHIPPING-001 to SHIPPING-006)
- Order tracking UI (SHIPPING-003, SHIPPING-005)

### Reviews & Ratings (10 SP)
- Review submission (REVIEWS-001 to REVIEWS-003)

### Admin Features (10 SP)
- Admin dashboard (ADMIN-DASHBOARD-001)

### DevOps & Infrastructure (50 SP)
- Firebase multi-env setup (FOUND-001 to FOUND-008)
- Monitoring & logging (FOUND-002, MONITORING-001)
- CI/CD pipeline (FOUND-003)
- Production deployment (LAUNCH-001 to LAUNCH-003)

---

## Risk Register & Mitigation

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|-----------|
| Firebase Firestore cost spike | Medium | High | Implement aggressive caching, pagination, and query optimization by Sprint 4 |
| Xendit API delays | Low | High | Maintain COD as fallback payment method; test extensively in Sprint 8 |
| Shipping provider API issues | Medium | Medium | Establish backup shipping provider (LBC) by Sprint 10 |
| Phone Auth quota limits in PH | Low | High | Setup quota monitoring; escalate to Firebase support early |
| Real-time sync performance | Medium | Medium | Implement regional Firestore instances; use Firestore emulator for testing |
| App store review rejection | Low | High | Submit 2 weeks before target launch; ensure compliance with app store policies |
| Team velocity miss | Medium | Medium | Buffer 10 SP in Sprint 12 for overruns; track burndown daily |
| Payment reconciliation edge cases | Low | High | Implement comprehensive logging; have manual reconciliation process ready |

---

## Success Metrics

- **Sprints 1-2:** All CI/CD and Firebase multi-env setup complete; auth working in all environments
- **Sprints 3-7:** 80% of product backlog complete; marketplace functional with 10+ test products
- **Sprints 8-10:** Payment flow working end-to-end; zero payment discrepancies in reconciliation
- **Sprints 11-12:** App store submission complete; 100+ sellers onboarded in beta; 500+ orders processed
- **Post-Launch:** 99.9% system uptime; <2 second product search response time; <1% payment failure rate

---

## Team Roles & Responsibilities

- **Tech Lead:** Sprint planning, architecture decisions, code review, Firebase optimization
- **Frontend Developer:** UI/UX implementation, state management (BLoC), performance optimization
- **Backend Developer:** Cloud Functions, Firestore schema, payment integration, webhooks
- **DevOps Engineer:** CI/CD, infrastructure setup, monitoring, production deployment

---

**Document Version:** 1.0  
**Last Updated:** March 18, 2026  
**Next Review:** Upon Sprint 1 completion
