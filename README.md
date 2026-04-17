# Flora Match - Marketplace MVP (Philippines)

A Flutter-based e-commerce marketplace for buyers and sellers in the Philippines, with Firebase backend and payment integration via Xendit, Midtrans, or Stripe.

## Project Overview

**Target Market:** Philippines  
**Launch Date:** 12 weeks (3 months) - June 2026  
**Sprint Duration:** 5 days  
**Team Capacity:** 30 story points/week (3 developers)  
**Architecture:** Flutter + Firebase (Firestore, Auth, Cloud Functions)

## Core Roles

- **Buyer:** Browse products, add to cart, checkout, pay, track orders, rate sellers
- **Seller:** Manage store, list products, accept orders, manage fulfillment, track earnings
- **Admin:** Moderate content, handle disputes, manage settlements, view analytics

## Key Deliverables

### Phase 0: Foundation (Week 1-2) - 40 SP
- Project structure & Firebase setup
- Authentication skeleton
- Environment configuration
- CI/CD pipeline
- Monitoring & error tracking

### Phase 1: Commerce MVP Core (Week 3-7) - 100 SP
- Buyer onboarding, browse, cart, checkout
- Seller store setup, product CRUD, order management
- Order state machine & pricing engine

### Phase 2: Payments + Settlement (Week 8-10) - 80 SP
- Payment gateway integration (Xendit/Midtrans primary)
- Webhook processors & reconciliation
- Seller wallet & settlement system

### Phase 3: Logistics + Post-Purchase (Week 11-12) - 60 SP
- Shipping integration
- Order tracking
- Refund & dispute handling

## Quick Links

- **12-Week Sprint Plan:** [docs/roadmap/ph_12_week_sprints.md](docs/roadmap/ph_12_week_sprints.md)
- **Firebase Schema:** [docs/architecture/firebase_schema.md](docs/architecture/firebase_schema.md)
- **Firestore Security Rules:** [docs/architecture/firestore_security_rules.md](docs/architecture/firestore_security_rules.md)
- **Payment Provider Matrix:** [docs/architecture/payment_provider_matrix_ph.md](docs/architecture/payment_provider_matrix_ph.md)
- **Architecture Overview:** [docs/architecture/README.md](docs/architecture/README.md)

## Getting Started

1. Install dependencies: `flutter pub get`
2. Configure Firebase: `flutterfire configure --project=flora-match-ph`
3. Run dev server: `flutter run -d chrome`
4. Read [docs/DEV_GUIDE.md](docs/DEV_GUIDE.md) for development setup

## Development Guidelines

- Code style: Dart Effective Dart
- State management: BLoC/Provider
- Database: Firestore with offline caching
- Testing: Unit + Integration tests for all payment flows
- Monitoring: Sentry for crash tracking, Firebase Analytics
