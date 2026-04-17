# Payment Provider Comparison - Philippines Market

**Prepared for:** Flora Match Philippines MVP  
**Target Market:** Philippines | **Date:** March 18, 2026  
**Decision Required:** Weeks 1–2 (Sprint 1–2) for Phase 2 integration starting Week 8

---

## Executive Summary

| Provider | Best For | Recommended | Notes |
|----------|----------|-------------|-------|
| **Xendit** | GCash + card + bank transfer | ⭐ **YES** | Fastest PH adoption, best GCash support |
| **Midtrans** | Card + e-wallet blend | ⭐ **MAYBE** | Good multi-channel, slower GCash focus |
| **Stripe** | International scaling | ✅ Future | Premium support, higher fees, PH setup slower |

**Recommendation for MVP:** **Xendit** (primary) + **COD** (backup)

---

## Detailed Comparison

### 1. XENDIT

**Website:** https://xendit.co/  
**Headquarters:** Jakarta, Indonesia (strong SEA presence)  
**Launch in PH:** 2015

#### Payment Methods Available in PH
- ✅ **GCash** (e-wallet) — most popular in PH
- ✅ **Grab Pay** (e-wallet)
- ✅ Debit/Credit Cards (Visa, Mastercard)
- ✅ Bank transfers (BDO, BPI, Metrobank, etc.)
- ✅ Over-the-counter (7-Eleven, SM Malls)
- ✅ BNPL (Buy Now Pay Later) via partner

#### Pricing
| Transaction Type | Fee | + Payment Method Fee | Monthly Cost (100 txn @ 1000 PHP avg) |
|------------------|-----|----------------------|------|
| **GCash payment** | 2.5% | +0.5% | ~260 PHP (~$5 USD) |
| **Card payment** | 2.9% | +15 PHP | ~300 PHP (~$6 USD) |
| **Bank transfer** | 0.5% + 50 PHP | N/A | ~100 PHP (~$2 USD) |
| **OTC** | 2% | +5 PHP | ~250 PHP (~$5 USD) |

**Effective Rate:** ~2.7% average for mixed PH payment mix

#### Settlement & Payout
- **Settlement delay:** 1–3 days (standard)
- **Payout methods:** Bank transfer (BDO, BPI), GCash
- **Payout fee:** 50 PHP per withdrawal (~$1 USD) or free if >10,000 PHP
- **Minimum payout:** 1,000 PHP
- **Payout SLA:** Next business day

#### Strengths
✅ **GCash dominance:** 61% of PH users prefer GCash; Xendit has best integration  
✅ **Fast approval:** Account setup 1–2 days for SMBs  
✅ **Low barrier:** No complex requirements for small marketplace  
✅ **Good API docs:** Clear, well-organized Xendit API  
✅ **Webhook support:** Reliable payment confirmations  
✅ **Local support:** PH-based customer support team  
✅ **Sandbox environment:** Full testing before production  

#### Weaknesses
❌ **API learning curve:** More endpoints than Stripe, less commercial support tier  
❌ **Chargeback handling:** Limited self-service chargeback management  
❌ **No subscription:** One-time invoices only (manage recurring manually)  
❌ **Limited dispute tools:** Fewer automated dispute workflow options  

#### Integration Effort
- **Estimated dev time:** 1–2 weeks (payment intent → webhook → settlement)
- **Complexity:** Medium (multiple payment methods need separate flows)
- **SDK support:** REST API, Postman collection available

#### Example Integration (Pseudocode)
```dart
// Create payment intent
var payment = await XenditClient.createInvoice(
  amount: 3852.00,
  currency: 'PHP',
  methods: ['GCASH', 'CARD', 'BANK_TRANSFER'],
  description: 'Order #ORD-2026031801',
  externalId: 'ORD-2026031801',
);

// Redirect to payment page
launchUrl(payment.invoiceUrl);

// Webhook endpoint receives payment callback
POST /webhooks/xendit => {
  orderId: "ORD-2026031801",
  status: "PAID",
  amount: 3852.00
}
```

---

### 2. MIDTRANS

**Website:** https://midtrans.com/  
**Headquarters:** Jakarta, Indonesia (owned by Verifone)  
**Launch in PH:** 2016

#### Payment Methods Available in PH
- ✅ GCash (e-wallet) — indirect via partner
- ✅ Grab Pay (e-wallet)
- ✅ Debit/Credit Cards (Visa, Mastercard)
- ✅ Bank transfers (BDO, BPI, Metrobank, etc.)
- ✅ Installments (credit card 3/6/12 month)
- ✅ BNPL (via partner)

#### Pricing
| Transaction Type | Fee | + Payment Method Fee | Monthly Cost (100 txn @ 1000 PHP avg) |
|------------------|-----|----------------------|------|
| **GCash payment** | 2.7% | +0.5% | ~280 PHP (~$5.60 USD) |
| **Card payment** | 2.9% | +0 PHP | ~290 PHP (~$5.80 USD) |
| **Bank transfer** | 0.5% + 40 PHP | N/A | ~85 PHP (~$1.70 USD) |
| **Installment** | 3.5% + installment fee | varies | +higher |

**Effective Rate:** ~2.8% average for mixed PH payment mix

#### Settlement & Payout
- **Settlement delay:** Same-day to 1 day
- **Payout methods:** Bank transfer (BDO, BPI)
- **Payout fee:** 0 PHP (free transfers)
- **Minimum payout:** 1,000 PHP
- **Payout SLA:** Same-day if before cutoff (3 PM)

#### Strengths
✅ **Installment options:** Integrated buy-now-pay-later (BNPL) for higher AOV  
✅ **Fast settlement:** Often same-day settlement (Midtrans vs Xendit 1–3 days)  
✅ **Snap widget:** Pre-built payment UI (iframe/modal) — less coding  
✅ **Merchant dashboard:** Polished interface, good for non-technical sellers  
✅ **Multi-currency:** USD, SGD, IDR support (future expansion ready)  
✅ **Better chargeback tools:** Dashboard visibility into disputes  

#### Weaknesses
❌ **GCash integration:** Indirect/slower than Xendit (partner-based)  
❌ **Premium pricing:** Slightly higher fees than Xendit on average  
❌ **Less local support in PH:** Indonesia-focused, slower PH response time  
❌ **Complexity:** More features = more onboarding steps for sellers  
❌ **Installment friction:** Adds checkout complexity (not ideal for MVP)  

#### Integration Effort
- **Estimated dev time:** 1–2 weeks (similar to Xendit)
- **Complexity:** Medium (Snap widget easier than Xendit multi-method routing)
- **SDK support:** SDK available (PHP, Node.js, Python, Java, Go)

#### Example Integration (Pseudocode)
```dart
// Create payment order
var transaction = await MidtransClient.charge(
  transactionDetails: {
    'order_id': 'ORD-2026031801',
    'gross_amount': 3852.00,
  },
  paymentType: 'gcash',
);

// Redirect to Snap payment page
launchUrl(transaction.redirectUrl);

// Webhook confirmation
POST /webhooks/midtrans => {
  order_id: "ORD-2026031801",
  transaction_status: "settlement",
  gross_amount: 3852.00
}
```

---

### 3. STRIPE

**Website:** https://stripe.com/  
**Headquarters:** San Francisco, USA  
**Launch in PH:** 2021 (Connect pilot)

#### Payment Methods Available in PH
- ❌ **GCash:** Not directly (would need partner integration)
- ✅ Debit/Credit Cards (Visa, Mastercard)
- ✅ Bank transfers (via international ACH)
- ✅ Digital wallets (Google Pay, Apple Pay — not PH specific)
- ✅ Klarna BNPL (international only)
- ⚠️ **No native PH e-wallet support**

#### Pricing
| Transaction Type | Fee | + Payment Method Fee | Monthly Cost (100 txn @ 1000 PHP avg) |
|------------------|-----|----------------------|------|
| **Card payment** | 2.9% | +30 cents USD (~17 PHP) | ~500 PHP (~$10 USD) |
| **Bank transfer** | 1% | +USD charges | ~250 PHP (~$5 USD) |

**Effective Rate:** ~3.2–3.5% average (highest of three)

#### Settlement & Payout
- **Settlement delay:** 2 days (standard)
- **Payout methods:** Bank transfer (USD, requires conversion)
- **Payout fee:** 0 (free ACH in US; international ~1% fx + $15)
- **Minimum payout:** $100 USD
- **Payout SLA:** 2 business days (slower for international)

#### Strengths
✅ **Best global support:** Comprehensive documentation, 24/7 support  
✅ **Highest security standards:** PCI DSS Compliant, strong fraud prevention  
✅ **Best for international:** If planning SEA or global expansion later  
✅ **Powerful dashboard:** Advanced analytics, revenue recognition  
✅ **Ecosystem:** Stripe Connect for multi-vendor (future marketplace scaling)  
✅ **Premium tier:** Enterprise support, custom features available  

#### Weaknesses
❌ **No GCash support:** ~61% of PH users prefer GCash, Stripe unsupported  
❌ **Higher fees:** 3.2–3.5% vs 2.7% for Xendit/Midtrans  
❌ **Slow PH onboarding:** May require additional KYC docs, 2–4 weeks  
❌ **Currency issues:** All payouts in USD; FX conversion costs  
❌ **Not PH-focused:** Limited local payment method support  
❌ **Over-engineered for MVP:** Complex features overkill for marketplace start  

#### Integration Effort
- **Estimated dev time:** 2–3 weeks (more complex webhook handling)
- **Complexity:** High (more enterprise-focused, requires more config)
- **SDK support:** Official SDKs for all major languages

#### Example Integration (Pseudocode)
```dart
// Create payment intent
var intent = await StripeClient.paymentIntents.create(
  amount: 385200, // in cents (PHP -> PHP)
  currency: 'php',
  paymentMethodTypes: ['card'],
  metadata: {'orderId': 'ORD-2026031801'},
);

// Handle client-side payment
await StripeClient.handleCardPayment(
  clientSecret: intent.clientSecret,
  cardDetails: cardData,
);

// Webhook confirmation
POST /webhooks/stripe => {
  type: 'payment_intent.succeeded',
  data.object.id: 'pi_123...',
  data.object.metadata.orderId: 'ORD-2026031801'
}
```

---

## Side-by-Side Comparison

| Criteria | Xendit | Midtrans | Stripe |
|----------|--------|----------|--------|
| **GCash Support** | ⭐⭐⭐ Excellent | ⭐⭐ Good | ❌ None |
| **PH Market Fit** | ⭐⭐⭐ Best | ⭐⭐ Good | ⭐ Limited |
| **Average Fee Rate** | 2.7% | 2.8% | 3.2% |
| **Settlement Speed** | 1–3 days | Same-day | 2 days |
| **Payout Fee** | 50 PHP (min) | Free | +USD fx |
| **Setup Time** | 1–2 days | 2–3 days | 2–4 weeks |
| **API Complexity** | Medium | Medium | High |
| **Webhook Reliability** | ⭐⭐⭐ Excellent | ⭐⭐ Good | ⭐⭐⭐ Excellent |
| **Chargeback Support** | Basic | Good | Excellent |
| **BNPL Integration** | Partner | Native | Partner |
| **Marketplace (Multi-seller)** | Via sub-accounts | Via marketplace | Via Connect |
| **Developer Support** | Good | Good | Excellent |
| **Best For MVP** | ⭐⭐⭐ YES | ⭐⭐ Possible | ❌ No |
| **Best For Scale** | ⭐⭐ Good | ⭐⭐⭐ Excellent | ⭐⭐⭐ Best |

---

## Recommendation for Flora Match PH MVP

### **Primary Choice: XENDIT**

**Rationale:**
1. **GCash dominance:** 61% of PH e-commerce users, Xendit native support
2. **Lowest fees:** 2.7% effective rate = 108 PHP saved per 1000 PHP transaction vs Stripe
3. **Fastest onboarding:** 1–2 days vs 2–4 weeks for Stripe
4. **PH-focused:** Built for SEA market, local support team
5. **Lower barrier:** No complex requirements for MVP
6. **Developer-friendly:** Clear API, sandbox, Postman collection

**Integration Timeline:**
- **Week 1–2:** Setup account, get API keys, sandbox testing
- **Week 8–9:** Full integration (create payment → webhook → settlement)
- **Week 10:** Production go-live

### **Backup: Cash on Delivery (COD)**

**Why:** If Xendit integration delays, COD provides fallback payment method
- Low technical risk
- Familiar to PH buyers
- Seller collects cash, settles manually (MVP-acceptable)

### **Future Path: Midtrans or Stripe**

- **Month 2–3 (after MVP):** Add Midtrans for installment options (higher AOV)
- **Month 6–12 (scaling phase):** Integrate Stripe for international expansion

---

## Implementation Plan - Weeks 1–2 (Sprint 1–2)

### Sprint 1: Decision & Setup
- [ ] Confirm Xendit as primary provider (stakeholder sign-off)
- [ ] Create Xendit merchant account (tech lead + business POC)
- [ ] Request API keys (sandbox + production)
- [ ] Review Xendit API docs: https://xendit.io/api
- [ ] Set up webhook endpoint skeleton (no logic yet)

### Sprint 8: Full Integration
- [ ] Build payment intent creation function (Dart/Cloud Functions)
- [ ] Implement Xendit SDK in Flutter app
- [ ] Create webhook receiver & signature verification
- [ ] Test end-to-end: order → select payment → GCash flow → confirmation
- [ ] Production keys rotation & security audit

### Sprint 10: Hardening
- [ ] Payment reconciliation job (daily)
- [ ] Chargeback/dispute handling
- [ ] Seller payout automation
- [ ] Production cutover

---

## Risk Mitigation

| Risk | Mitigation |
|------|-----------|
| Xendit outage | Fallback to COD; implement timeout retry |
| Failed payment webhook | Idempotency key + manual reconciliation job |
| Payment delays (7+ days) | Notify sellers, retry settlement batch |
| Regulatory changes (BSP) | Stay updated on PH banking regulations, maintain compliance docs |

---

## Cost Projections (6-month MVP)

| Provider | Transactions | Avg Amount | Fees | Payout Fees | Total |
|----------|--------------|-----------|------|------------|-------|
| **Xendit** | 50,000 | 3,000 PHP | 4,050 PHP | 1,500 PHP | **5,550 PHP** (~$110 USD) |
| **Midtrans** | 50,000 | 3,000 PHP | 4,200 PHP | 0 PHP | **4,200 PHP** (~$84 USD) |
| **Stripe** | 50,000 | 3,000 PHP | 4,800 PHP | 2,000 PHP | **6,800 PHP** (~$136 USD) |

**Winner for MVP:** Xendit (lowest cost + best PH fit)

---

## Decision Gate (Sprint 2 End)

**Required Approvals:**
- [ ] Tech Lead: Xendit API integration feasible
- [ ] PM: GCash support aligned with market research
- [ ] Finance: Fee structure acceptable
- [ ] Legal: Compliance with BSP/BIR regulations

**Next Step:** Proceed to Phase 2 (Weeks 8–10) with Xendit primary integration

