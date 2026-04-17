# Firebase Schema - Flora Match Philippines

**Database:** Cloud Firestore | **Version:** 1.0 | **Last Updated:** March 18, 2026

---

## Collections Overview

```
flora_match_ph (project)
├── users/{uid}
├── stores/{storeId}
├── products/{productId}
├── inventory/{skuId}
├── carts/{uid}
├── orders/{orderId}
├── orderItems/{orderItemId}
├── payments/{paymentId}
├── shipments/{shipmentId}
├── refunds/{refundId}
├── reviews/{reviewId}
├── wallets/{walletId}
├── settlements/{settlementId}
├── transactions/{transactionId}
└── admin/{docId}
```

---

## Detailed Schema

### 1. `users/{uid}` — User Profile & Auth Data

**Purpose:** Store user account info, role, verification status

```json
{
  "uid": "user_123abc",
  "role": "buyer" | "seller" | "admin",
  "email": "user@example.ph",
  "phone": "+63912345678",
  "phoneVerified": true,
  "firstName": "Juan",
  "lastName": "Dela Cruz",
  "profileImage": "gs://flora-match-ph.appspot.com/users/user_123abc/profile.jpg",
  "bio": "Plant enthusiast from Manila",
  "country": "PH",
  "createdAt": "2026-03-18T10:30:00Z",
  "updatedAt": "2026-03-18T10:30:00Z",
  "status": "active" | "suspended" | "deleted",
  "kycVerified": true,
  "idType": "national_id" | "passport" | "tin",
  "idNumber": "****1234",
  "addresses": [
    {
      "id": "addr_001",
      "label": "Home",
      "street": "123 Makati Ave",
      "city": "Makati",
      "region": "NCR",
      "postalCode": "1200",
      "default": true
    }
  ],
  "preferences": {
    "notificationsEnabled": true,
    "emailMarketing": false,
    "language": "en"
  }
}
```

**Indexes:**
- `email` (ascending)
- `phone` (ascending)
- `role` (ascending)
- `createdAt` (descending)

---

### 2. `stores/{storeId}` — Seller Store Profile

**Purpose:** Seller store metadata, branding, settings

```json
{
  "storeId": "store_456def",
  "uid": "user_123abc",
  "storeName": "Tropicana Plants",
  "storeHandle": "tropicana_plants",
  "logo": "gs://flora-match-ph.appspot.com/stores/store_456def/logo.jpg",
  "banner": "gs://flora-match-ph.appspot.com/stores/store_456def/banner.jpg",
  "description": "Premium tropical plants & care supplies",
  "category": "plants" | "pet_care" | "garden_tools",
  "city": "Cebu",
  "region": "VIS",
  "rating": 4.8,
  "reviewCount": 234,
  "totalSales": 125000.50,
  "responseTime": 2.3,
  "createdAt": "2026-01-15T08:00:00Z",
  "updatedAt": "2026-03-18T10:30:00Z",
  "status": "active" | "suspended" | "closed",
  "bankAccount": {
    "bankName": "BDO",
    "accountNumber": "****5678",
    "accountHolder": "Juan Dela Cruz",
    "verified": true
  },
  "gcashAccount": {
    "phoneNumber": "+63912345678",
    "verified": true
  },
  "payoutPreference": "bdo" | "gcash",
  "monthlyPayoutCap": 500000.00,
  "settings": {
    "autoAcceptOrders": false,
    "deliveryDaysMax": 5,
    "returnWindowDays": 7
  }
}
```

**Indexes:**
- `uid` (ascending)
- `storeName` (ascending)
- `rating` (descending)
- `createdAt` (descending)

---

### 3. `products/{productId}` — Product Catalog

**Purpose:** Product listing, pricing, media

```json
{
  "productId": "prod_789ghi",
  "storeId": "store_456def",
  "uid": "user_123abc",
  "name": "Monstera Deliciosa - 6 inch pot",
  "slug": "monstera-deliciosa-6-pot",
  "description": "Healthy Monstera plant, fully rooted...",
  "category": "tropical-plants",
  "subcategory": "indoor-plants",
  "sku": "MONS-DEL-6",
  "price": 1500.00,
  "costPrice": 750.00,
  "currency": "PHP",
  "stock": 45,
  "lowStockThreshold": 5,
  "images": [
    "gs://flora-match-ph.appspot.com/products/prod_789ghi/img_1.jpg",
    "gs://flora-match-ph.appspot.com/products/prod_789ghi/img_2.jpg"
  ],
  "variants": [
    {
      "id": "var_001",
      "name": "Size",
      "options": ["4 inch", "6 inch", "8 inch"]
    },
    {
      "id": "var_002",
      "name": "With Pot",
      "options": ["Yes", "No"]
    }
  ],
  "rating": 4.7,
  "reviewCount": 87,
  "soldCount": 234,
  "tags": ["indoor", "low-maintenance", "pet-safe"],
  "shippingWeight": 2.5,
  "shippingDimensions": {
    "length": 30,
    "width": 25,
    "height": 35,
    "unit": "cm"
  },
  "createdAt": "2026-02-10T14:20:00Z",
  "updatedAt": "2026-03-18T10:30:00Z",
  "status": "active" | "inactive" | "flagged",
  "seoKeywords": "monstera, plant, indoor",
  "flagReason": null
}
```

**Indexes:**
- `storeId` (ascending), `status` (ascending)
- `category` (ascending), `rating` (descending)
- `createdAt` (descending)
- `soldCount` (descending)

---

### 4. `inventory/{skuId}` — Stock & SKU Data

**Purpose:** Real-time stock levels per variant

```json
{
  "skuId": "sku_001_mons_6",
  "productId": "prod_789ghi",
  "storeId": "store_456def",
  "sku": "MONS-DEL-6",
  "variantCombination": {
    "size": "6 inch",
    "withPot": "Yes"
  },
  "quantity": 45,
  "reserved": 5,
  "available": 40,
  "minStock": 5,
  "maxStock": 100,
  "restockDate": "2026-04-01T00:00:00Z",
  "lastRestockQuantity": 50,
  "updatedAt": "2026-03-18T15:45:00Z"
}
```

**Indexes:**
- `productId` (ascending)
- `available` (ascending) — for low-stock alerts

---

### 5. `carts/{uid}` — Shopping Cart (Session)

**Purpose:** Buyer's active shopping cart

```json
{
  "uid": "buyer_user_123",
  "items": [
    {
      "cartItemId": "cart_item_001",
      "productId": "prod_789ghi",
      "storeId": "store_456def",
      "quantity": 2,
      "variantSelections": {
        "size": "6 inch",
        "withPot": "Yes"
      },
      "unitPrice": 1500.00,
      "subtotal": 3000.00,
      "addedAt": "2026-03-18T10:15:00Z"
    }
  ],
  "totalItems": 1,
  "subtotal": 3000.00,
  "estimatedTax": 360.00,
  "estimatedShipping": 0.00,
  "grandTotal": 3360.00,
  "lastUpdated": "2026-03-18T10:15:00Z",
  "expiresAt": "2026-03-25T10:15:00Z"
}
```

**Indexes:**
- `uid` (ascending)
- `expiresAt` (ascending) — for cleanup job

---

### 6. `orders/{orderId}` — Order Header

**Purpose:** Order master record, status, totals

```json
{
  "orderId": "ORD-2026031801",
  "uid": "buyer_user_123",
  "storeId": "store_456def",
  "orderNumber": "ORD-2026031801",
  "status": "pending_payment" | "paid" | "packed" | "shipped" | "delivered" | "cancelled" | "refunded",
  "createdAt": "2026-03-18T10:30:00Z",
  "updatedAt": "2026-03-18T10:30:00Z",
  "paidAt": null,
  "shippedAt": null,
  "deliveredAt": null,
  "buyerName": "Juan Dela Cruz",
  "buyerPhone": "+63912345678",
  "buyerEmail": "buyer@example.ph",
  "shippingAddress": {
    "street": "456 BGC, Taguig",
    "city": "Taguig",
    "region": "NCR",
    "postalCode": "1634"
  },
  "items": [
    {
      "orderItemId": "ORD_ITEM_001",
      "productId": "prod_789ghi",
      "quantity": 2,
      "unitPrice": 1500.00,
      "subtotal": 3000.00,
      "variantSelections": {
        "size": "6 inch",
        "withPot": "Yes"
      }
    }
  ],
  "subtotal": 3000.00,
  "platformFee": 300.00,
  "shippingFee": 150.00,
  "tax": 402.00,
  "totalAmount": 3852.00,
  "paymentMethod": "gcash" | "card" | "bank_transfer" | "cod",
  "paymentStatus": "pending" | "completed" | "failed" | "refunded",
  "notes": "Please ring the bell",
  "cancellationReason": null,
  "cancellableUntil": "2026-03-19T10:30:00Z"
}
```

**Indexes:**
- `uid` (ascending), `createdAt` (descending)
- `storeId` (ascending), `status` (ascending)
- `status` (ascending), `updatedAt` (descending)
- `paymentStatus` (ascending)

---

### 7. `orderItems/{orderItemId}` — Order Line Items

**Purpose:** Detailed line item tracking (optional; can nest in orders)

```json
{
  "orderItemId": "ORD_ITEM_001",
  "orderId": "ORD-2026031801",
  "productId": "prod_789ghi",
  "quantity": 2,
  "unitPrice": 1500.00,
  "subtotal": 3000.00,
  "variantSelections": {
    "size": "6 inch",
    "withPot": "Yes"
  },
  "returnStatus": "no_return" | "return_requested" | "return_approved" | "return_rejected",
  "returnReason": null
}
```

---

### 8. `payments/{paymentId}` — Payment Records

**Purpose:** Payment transaction history, status, gateway refs

```json
{
  "paymentId": "PAY_001_001",
  "orderId": "ORD-2026031801",
  "uid": "buyer_user_123",
  "storeId": "store_456def",
  "totalAmount": 3852.00,
  "currency": "PHP",
  "paymentMethod": "gcash" | "card" | "bank_transfer" | "cod",
  "paymentGateway": "xendit",
  "paymentGatewayRef": "xendit_inv_12345678",
  "paymentGatewayStatus": "PENDING" | "COMPLETED" | "FAILED" | "EXPIRED",
  "status": "pending" | "completed" | "failed" | "cancelled" | "refunded",
  "createdAt": "2026-03-18T10:30:00Z",
  "expiresAt": "2026-03-18T11:30:00Z",
  "completedAt": null,
  "failureReason": null,
  "idempotencyKey": "idempotent_key_unique_123",
  "webhookReceived": false,
  "webhookReceivedAt": null,
  "metadata": {
    "buyerIP": "192.168.1.1",
    "deviceId": "android_device_123"
  }
}
```

**Indexes:**
- `orderId` (ascending)
- `uid` (ascending), `createdAt` (descending)
- `status` (ascending), `createdAt` (descending)
- `paymentGatewayRef` (ascending)

---

### 9. `shipments/{shipmentId}` — Shipping & Tracking

**Purpose:** Shipment metadata, carrier tracking, delivery

```json
{
  "shipmentId": "SHIP_001",
  "orderId": "ORD-2026031801",
  "storeId": "store_456def",
  "carrier": "lbc" | "jnt" | "2go" | "lalamove",
  "trackingNumber": "LBC123456789",
  "trackingUrl": "https://lbc.com.ph/track/...",
  "shippingStatus": "pickup_scheduled" | "in_transit" | "out_for_delivery" | "delivered" | "failed",
  "shippingCost": 150.00,
  "estimatedDeliveryDate": "2026-03-21T23:59:59Z",
  "actualDeliveryDate": null,
  "currentLocation": "Manila Distribution Center",
  "lastUpdate": "2026-03-19T14:30:00Z",
  "labelUrl": "gs://flora-match-ph.appspot.com/shipments/SHIP_001/label.pdf",
  "createdAt": "2026-03-18T11:00:00Z",
  "updatedAt": "2026-03-19T14:30:00Z"
}
```

**Indexes:**
- `orderId` (ascending)
- `trackingNumber` (ascending)
- `shippingStatus` (ascending)

---

### 10. `refunds/{refundId}` — Refund Management

**Purpose:** Refund requests, approvals, reversals

```json
{
  "refundId": "REF_001",
  "orderId": "ORD-2026031801",
  "uid": "buyer_user_123",
  "storeId": "store_456def",
  "paymentId": "PAY_001_001",
  "amount": 3852.00,
  "reason": "product_damaged" | "not_as_described" | "buyer_cancelled" | "other",
  "status": "pending" | "approved" | "rejected" | "completed" | "failed",
  "requestedAt": "2026-03-20T09:00:00Z",
  "approvedAt": null,
  "completedAt": null,
  "buyerNotes": "Product arrived damaged, leaves broken",
  "photoProofs": [
    "gs://flora-match-ph.appspot.com/refunds/REF_001/photo_1.jpg"
  ],
  "sellerNotes": null,
  "rejectionReason": null,
  "refundMethod": "original_payment" | "wallet",
  "gatewayRefundRef": null,
  "adminNotes": null
}
```

**Indexes:**
- `orderId` (ascending)
- `uid` (ascending), `status` (ascending)
- `status` (ascending), `requestedAt` (descending)

---

### 11. `reviews/{reviewId}` — Ratings & Reviews

**Purpose:** Product & seller reviews, ratings

```json
{
  "reviewId": "REV_001",
  "orderId": "ORD-2026031801",
  "productId": "prod_789ghi",
  "storeId": "store_456def",
  "uid": "buyer_user_123",
  "buyerName": "Juan Dela Cruz",
  "buyerImage": "gs://flora-match-ph.appspot.com/users/buyer_123/profile.jpg",
  "productRating": 5,
  "sellerRating": 4,
  "reviewTitle": "Excellent plant, great seller!",
  "reviewText": "Plant arrived in perfect condition, very healthy. Seller packed it securely.",
  "photos": [
    "gs://flora-match-ph.appspot.com/reviews/REV_001/photo_1.jpg"
  ],
  "helpfulCount": 12,
  "createdAt": "2026-03-21T16:30:00Z",
  "updatedAt": "2026-03-21T16:30:00Z",
  "isVerifiedPurchase": true,
  "moderation": {
    "status": "approved" | "pending" | "rejected",
    "flagReason": null,
    "reviewedAt": "2026-03-21T17:00:00Z"
  }
}
```

**Indexes:**
- `productId` (ascending), `productRating` (descending)
- `storeId` (ascending), `sellerRating` (descending)
- `createdAt` (descending)

---

### 12. `wallets/{walletId}` — Buyer/Seller Wallets

**Purpose:** Account balance for refunds, credits, seller earnings

```json
{
  "walletId": "wallet_buyer_user_123",
  "uid": "buyer_user_123",
  "walletType": "buyer" | "seller",
  "balance": 500.00,
  "pendingBalance": 1500.00,
  "currency": "PHP",
  "transactions": [
    {
      "id": "tx_001",
      "type": "refund" | "credit" | "payout" | "adjustment",
      "amount": 500.00,
      "reference": "REF_001",
      "createdAt": "2026-03-20T10:00:00Z"
    }
  ],
  "lastUpdated": "2026-03-20T10:00:00Z"
}
```

**Indexes:**
- `uid` (ascending)
- `walletType` (ascending)

---

### 13. `settlements/{settlementId}` — Seller Payouts

**Purpose:** Payout batch records, disbursement status

```json
{
  "settlementId": "SETTLE_2026031801",
  "storeId": "store_456def",
  "uid": "user_123abc",
  "payoutBatchId": "BATCH_20260318_001",
  "totalAmount": 15000.00,
  "currency": "PHP",
  "payoutMethod": "bdo" | "gcash",
  "bankAccount": {
    "bankName": "BDO",
    "accountNumber": "****5678"
  },
  "status": "pending" | "processing" | "completed" | "failed" | "cancelled",
  "orders": [
    {
      "orderId": "ORD-2026031801",
      "amount": 2550.00,
      "platformFee": 300.00,
      "netAmount": 2250.00
    }
  ],
  "periodStart": "2026-03-11T00:00:00Z",
  "periodEnd": "2026-03-18T23:59:59Z",
  "createdAt": "2026-03-18T00:01:00Z",
  "processedAt": null,
  "completedAt": null,
  "failureReason": null,
  "referenceNumber": "REF_123456"
}
```

**Indexes:**
- `storeId` (ascending), `status` (ascending)
- `status` (ascending), `createdAt` (descending)
- `payoutBatchId` (ascending)

---

### 14. `transactions/{transactionId}` — Audit Log

**Purpose:** Immutable ledger of all money movements

```json
{
  "transactionId": "TX_2026031801001",
  "type": "order_payment" | "order_refund" | "platform_fee" | "seller_payout" | "wallet_credit" | "adjustment",
  "amount": 3852.00,
  "currency": "PHP",
  "debitAccount": "buyer_user_123" | "platform",
  "creditAccount": "store_456def" | "platform",
  "reference": "ORD-2026031801",
  "status": "completed" | "pending" | "failed",
  "createdAt": "2026-03-18T10:30:00Z",
  "batchId": null,
  "signature": "hash_of_transaction_data",
  "metadata": {
    "ipAddress": "192.168.1.1",
    "userId": "buyer_user_123"
  }
}
```

**Indexes:**
- `type` (ascending), `createdAt` (descending)
- `debitAccount` (ascending), `createdAt` (descending)
- `creditAccount` (ascending), `createdAt` (descending)
- `reference` (ascending)

---

### 15. `admin/{docId}` — Admin Settings & Config

**Purpose:** Feature flags, announcements, system config

```json
{
  "docId": "config",
  "platformFeePercentage": 0.10,
  "vatRate": 0.12,
  "defaultHoldDays": 7,
  "maxRefundWindowDays": 30,
  "features": {
    "guestCheckout": false,
    "sellerPromotion": true,
    "buyerLoyaltyProgram": false
  },
  "announcements": [
    {
      "id": "ann_001",
      "title": "Scheduled Maintenance",
      "message": "...",
      "startDate": "2026-03-25T22:00:00Z",
      "endDate": "2026-03-26T02:00:00Z"
    }
  ],
  "suspendedUsers": [],
  "flaggedProducts": [],
  "lastUpdated": "2026-03-18T10:30:00Z"
}
```

---

## Firestore Indexes (Composite)

| Collection | Fields | Type |
|-----------|--------|------|
| `users` | `role`, `createdAt` | Ascending, Descending |
| `products` | `storeId`, `status`, `createdAt` | Asc, Asc, Desc |
| `products` | `category`, `rating`, `createdAt` | Asc, Desc, Desc |
| `orders` | `uid`, `createdAt` | Asc, Desc |
| `orders` | `storeId`, `status` | Asc, Asc |
| `orders` | `status`, `paymentStatus` | Asc, Asc |
| `payments` | `orderId`, `status` | Asc, Asc |
| `reviews` | `productId`, `productRating` | Asc, Desc |
| `reviews` | `storeId`, `sellerRating` | Asc, Desc |
| `transactions` | `type`, `createdAt` | Asc, Desc |

---

## Data Retention & Cleanup

- **Carts:** Auto-delete after 7 days (TTL policy or Cloud Function)
- **Temporary data:** Old payment intents (30+ days, failed)
- **User deletion:** Soft-delete users (set `status: deleted`), anonymize PII after 1 year

---

## Estimated Collection Sizes (Projections at 6-month mark)

| Collection | Est. Documents | Est. Size |
|-----------|----------------|-----------|
| `users` | 5,000 | ~10 MB |
| `stores` | 500 | ~2 MB |
| `products` | 10,000 | ~50 MB |
| `inventory` | 30,000 | ~30 MB |
| `orders` | 50,000 | ~100 MB |
| `payments` | 50,000 | ~30 MB |
| `reviews` | 15,000 | ~20 MB |
| **Total (estimate)** | **~160,000** | **~250 MB** |

**Cost Impact:** ~$30–50/month for Firestore at this scale (pay-as-you-go)

