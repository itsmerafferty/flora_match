# Firebase Firestore Schema for Flora Match Marketplace

## Overview

This document defines the Firestore database structure for the Flora Match marketplace, supporting seller/buyer interactions, products, orders, payments, and settlements.

**Target Environment:** Firebase Firestore (Cloud Native)  
**Regions:** asia-southeast1 (Singapore for low latency to Philippines)  
**Pricing Model:** On-demand (pay per read/write/delete)

---

## Collections & Documents

### 1. `users` - User Profiles

Stores buyer and seller user information.

```javascript
/users/{userId}
├── uid: string (Firebase Auth UID)
├── phone: string (E.164 format: +63XXXXXXXXX)
├── email: string (optional)
├── firstName: string
├── lastName: string
├── role: string (enum: "buyer", "seller", "admin")
├── roles: array (for multi-role support: ["buyer", "seller"])
├── profilePicture: string (Firebase Storage URL)
├── kyc: object
│   ├── verified: boolean
│   ├── documentType: string (enum: "national_id", "passport")
│   ├── documentNumber: string (encrypted)
│   ├── verifiedAt: timestamp
│   └── expiresAt: timestamp
├── preferences: object
│   ├── defaultAddress: string (reference to address ID)
│   ├── notificationsEnabled: boolean
│   ├── emailNotifications: boolean
│   └── language: string (default: "en")
├── metadata: object
│   ├── createdAt: timestamp
│   ├── updatedAt: timestamp
│   ├── lastLogin: timestamp
│   └── accountStatus: string (enum: "active", "suspended", "deleted")
├── addresses: array (embedded, max 5)
│   ├── [0]: object
│   │   ├── id: string (UUID)
│   │   ├── label: string (e.g., "Home", "Office")
│   │   ├── street: string
│   │   ├── city: string
│   │   ├── province: string
│   │   ├── zipCode: string
│   │   ├── coordinates: object (GeoPoint for mapping)
│   │   ├── isDefault: boolean
│   │   └── createdAt: timestamp
├── searchIndex: array (for full-text search) [denormalized]
└── __v: integer (version control)
```

**Indexes:**
- `phone` (ascending, unique)
- `role` (ascending)
- `metadata.createdAt` (descending)

---

### 2. `stores` - Seller Shops

Stores seller shop/business information.

```javascript
/stores/{storeId}
├── storeId: string (UUID, same as seller userId)
├── storeName: string
├── description: string (max 500 chars)
├── category: string (enum: "flowers", "seeds", "tools", "supplies", "plants")
├── logo: string (Firebase Storage URL)
├── banner: string (Firebase Storage URL)
├── address: object
│   ├── street: string
│   ├── city: string
│   ├── province: string
│   ├── zipCode: string
│   └── coordinates: GeoPoint
├── contact: object
│   ├── phone: string
│   ├── email: string
│   └── whatsapp: string (optional)
├── businessInfo: object
│   ├── tin: string (Tax Identification Number, encrypted)
│   ├── businessName: string
│   ├── businessType: string (enum: "sole_proprietor", "partnership", "corporation")
│   └── registrationNumber: string
├── bankAccount: object [sensitive]
│   ├── bankName: string
│   ├── accountName: string
│   ├── accountNumber: string (encrypted)
│   └── branchCode: string
├── rating: object
│   ├── average: number (0-5)
│   ├── totalReviews: number
│   └── responseTime: number (hours, average response time)
├── stats: object
│   ├── totalProducts: number
│   ├── totalOrders: number
│   ├── totalSales: number (PHP)
│   ├── totalRevenue: number (PHP, after fees)
│   └── averageOrderValue: number (PHP)
├── verification: object
│   ├── status: string (enum: "pending", "approved", "rejected", "suspended")
│   ├── documents: array (document URLs for verification)
│   ├── submittedAt: timestamp
│   └── verifiedAt: timestamp
├── metadata: object
│   ├── createdAt: timestamp
│   ├── updatedAt: timestamp
│   ├── status: string (enum: "active", "inactive", "suspended")
│   └── suspension_reason: string (if suspended)
└── __v: integer (version control)
```

**Indexes:**
- `storeName` (ascending)
- `verification.status` (ascending)
- `metadata.createdAt` (descending)
- `rating.average` (descending)

---

### 3. `products` - Product Listings

Stores product information for seller shops.

```javascript
/products/{productId}
├── productId: string (UUID)
├── sellerId: string (reference to stores)
├── storeId: string (denormalized for queries)
├── name: string
├── description: string (max 2000 chars)
├── category: string (enum: "plants", "seeds", "tools", "supplies")
├── subcategory: string
├── images: array (URLs in Firebase Storage)
│   ├── [0]: string (primary image)
│   ├── [1]: string
│   └── ...
├── basePrice: number (PHP, base price before variants)
├── variants: array (optional, for product variations)
│   ├── [0]: object
│   │   ├── variantId: string (UUID)
│   │   ├── name: string (e.g., "Small", "Large")
│   │   ├── sku: string (unique stock keeping unit)
│   │   ├── price: number (PHP, overrides basePrice if set)
│   │   ├── weight: number (kg, for shipping)
│   │   └── stock: number (current inventory)
│   └── ...
├── attributes: object (for filtering)
│   ├── color: array (e.g., ["Green", "Red"])
│   ├── size: array (e.g., ["Small", "Medium", "Large"])
│   ├── condition: string (enum: "new", "refurbished")
│   └── careLevel: string (enum: "easy", "medium", "hard")
├── rating: object
│   ├── average: number (0-5)
│   ├── count: number (total reviews)
│   └── distribution: object (5-star, 4-star, etc.)
├── status: string (enum: "active", "inactive", "out_of_stock", "archived")
├── seo: object
│   ├── slug: string (URL-friendly name)
│   ├── keywords: array
│   └── metaDescription: string
├── searchIndex: array (denormalized for full-text search)
│   ├── [0]: string (name)
│   ├── [1]: string (description excerpt)
│   └── ...
├── metadata: object
│   ├── createdAt: timestamp
│   ├── updatedAt: timestamp
│   ├── viewCount: number
│   ├── favoriteCount: number
│   └── soldCount: number
└── __v: integer
```

**Indexes:**
- `sellerId` + `status` (ascending)
- `category` (ascending)
- `rating.average` (descending)
- `metadata.createdAt` (descending)
- `status` + `metadata.updatedAt` (for homepage display)

---

### 4. `inventory` - Stock Management

Real-time inventory tracking per product variant.

```javascript
/inventory/{inventoryId}
├── inventoryId: string (UUID)
├── productId: string (reference to products)
├── variantId: string (reference to product.variants[].variantId)
├── sellerId: string
├── quantity: number (current stock)
├── reserved: number (reserved in carts/pending orders)
├── sold: number (cumulative sold count)
├── minThreshold: number (reorder alert level)
├── lastRestocked: timestamp
├── metadata: object
│   ├── createdAt: timestamp
│   └── updatedAt: timestamp
└── __v: integer
```

**Indexes:**
- `productId` (ascending)
- `quantity` (ascending, for low-stock alerts)

---

### 5. `carts` - Shopping Carts

Stores buyer shopping carts (temporary).

```javascript
/carts/{cartId}
├── cartId: string (same as userId for uniqueness)
├── userId: string (reference to users)
├── items: array
│   ├── [0]: object
│   │   ├── productId: string
│   │   ├── variantId: string (optional)
│   │   ├── quantity: number
│   │   ├── price: number (snapshot at add time)
│   │   ├── sellerId: string (denormalized)
│   │   └── addedAt: timestamp
│   └── ...
├── totalItems: number (denormalized count)
├── subtotal: number (PHP)
├── estimatedTax: number (PHP, 12% VAT if applicable)
├── estimatedShipping: number (PHP, placeholder)
├── total: number (PHP)
├── metadata: object
│   ├── updatedAt: timestamp
│   ├── expiresAt: timestamp (30 days TTL)
│   └── abandonedAt: timestamp (for re-engagement)
└── __v: integer
```

**Indexes:**
- `userId` (ascending)
- `metadata.expiresAt` (ascending, for cleanup)

---

### 6. `orders` - Customer Orders

Core order information.

```javascript
/orders/{orderId}
├── orderId: string (UUID, unique)
├── buyerId: string (reference to users)
├── sellerId: string (reference to stores)
├── storeId: string (denormalized)
├── status: string (enum: "pending_payment", "confirmed", "processing", "shipped", "delivered", "cancelled", "refund_requested", "refunded")
├── paymentStatus: string (enum: "pending", "completed", "failed", "refunded")
├── lineItems: array (copied from cart at checkout)
│   ├── [0]: object
│   │   ├── productId: string
│   │   ├── productName: string (denormalized)
│   │   ├── variantId: string
│   │   ├── quantity: number
│   │   ├── unitPrice: number (PHP)
│   │   └── totalPrice: number (PHP)
│   └── ...
├── pricing: object
│   ├── subtotal: number (PHP, sum of lineItems)
│   ├── tax: number (PHP, 12% VAT if applicable)
│   ├── shippingCost: number (PHP)
│   ├── discount: number (PHP, promotional discount if any)
│   └── total: number (PHP, grand total)
├── shippingAddress: object
│   ├── name: string
│   ├── phone: string
│   ├── street: string
│   ├── city: string
│   ├── province: string
│   ├── zipCode: string
│   └── coordinates: GeoPoint
├── payment: object (reference to payments collection)
│   ├── paymentId: string
│   ├── method: string (enum: "gcash", "card", "bank_transfer", "cod")
│   ├── gateway: string (enum: "xendit", "internal_cod")
│   ├── transactionId: string (from gateway)
│   └── completedAt: timestamp
├── fulfillment: object
│   ├── status: string (enum: "pending", "processing", "ready_to_ship", "shipped", "delivered")
│   ├── processedAt: timestamp
│   ├── shippedAt: timestamp
│   ├── deliveredAt: timestamp
│   └── carrier: string (enum: "jnt", "lbc", "cod", "grab")
├── tracking: object
│   ├── trackingNumber: string
│   ├── url: string (carrier tracking URL)
│   └── updates: array (latest updates from carrier)
├── metadata: object
│   ├── createdAt: timestamp
│   ├── updatedAt: timestamp
│   ├── notes: string (internal notes)
│   └── cancelledAt: timestamp
├── stats: object
│   ├── daysToDeliver: number (calculated after delivery)
│   ├── refunded: boolean
│   └── reviewed: boolean
└── __v: integer
```

**Indexes:**
- `buyerId` + `metadata.createdAt` (descending, for buyer history)
- `sellerId` + `status` (ascending, for seller dashboard)
- `status` (ascending, for admin queries)
- `paymentStatus` (ascending)

---

### 7. `orderItems` - Detailed Order Line Items

Denormalized order item details for analytics.

```javascript
/orderItems/{orderItemId}
├── orderItemId: string (UUID)
├── orderId: string
├── productId: string
├── variantId: string
├── sellerId: string
├── quantity: number
├── price: number (PHP per unit)
├── totalPrice: number (PHP)
├── status: string (denormalized from order)
├── metadata: object
│   ├── createdAt: timestamp
│   └── updatedAt: timestamp
└── __v: integer
```

**Indexes:**
- `orderId` (ascending)
- `productId` (ascending)

---

### 8. `payments` - Payment Transactions

Payment records for orders.

```javascript
/payments/{paymentId}
├── paymentId: string (UUID)
├── orderId: string (reference to orders)
├── buyerId: string
├── sellerId: string
├── amount: number (PHP, total order value)
├── currency: string (default: "PHP")
├── method: string (enum: "gcash", "card", "bank_transfer", "cod")
├── gateway: string (enum: "xendit", "internal_cod")
├── status: string (enum: "pending", "processing", "completed", "failed", "expired", "refunded")
├── xendit: object (gateway-specific data)
│   ├── chargeId: string (Xendit charge ID)
│   ├── receiptNumber: string
│   ├── externalId: string (our orderId)
│   ├── paymentUrl: string (for payment page)
│   ├── createdAt: timestamp
│   ├── completedAt: timestamp
│   └── metadata: object (Xendit metadata)
├── cod: object (if payment method is COD)
│   ├── confirmationPhone: string
│   └── confirmationCode: string
├── metadata: object
│   ├── createdAt: timestamp
│   ├── completedAt: timestamp
│   ├── failureReason: string (if failed)
│   ├── userAgent: string (device info)
│   └── ipAddress: string (anonymized)
├── reconciliation: object
│   ├── reconciledAt: timestamp
│   ├── reconciledBy: string (admin user)
│   ├── discrepancy: string (if any)
│   └── notes: string
└── __v: integer
```

**Indexes:**
- `orderId` (ascending, unique)
- `buyerId` + `metadata.createdAt` (for buyer payment history)
- `status` (ascending)
- `gateway` + `metadata.createdAt` (for reconciliation)

---

### 9. `shipments` - Shipping Tracking

Shipping and tracking information per order.

```javascript
/shipments/{shipmentId}
├── shipmentId: string (UUID)
├── orderId: string
├── sellerId: string
├── buyerId: string
├── carrier: string (enum: "jnt", "lbc", "grab", "lalamove", "cod")
├── trackingNumber: string (unique per carrier)
├── trackingUrl: string
├── status: string (enum: "pending", "picked_up", "in_transit", "out_for_delivery", "delivered", "failed", "returned")
├── estimatedDeliveryDate: date
├── actualDeliveryDate: date
├── pickupLocation: object
│   ├── name: string
│   ├── address: string
│   └── coordinates: GeoPoint
├── deliveryLocation: object
│   ├── name: string
│   ├── address: string
│   └── coordinates: GeoPoint
├── weight: number (kg)
├── dimensions: object
│   ├── length: number (cm)
│   ├── width: number (cm)
│   └── height: number (cm)
├── trackingHistory: array (updated via webhook)
│   ├── [0]: object
│   │   ├── status: string
│   │   ├── timestamp: timestamp
│   │   ├── location: string
│   │   └── details: string
│   └── ...
├── proofOfDelivery: object
│   ├── signature: string (URL to signature image)
│   ├── photo: string (URL to delivery photo)
│   ├── recipientName: string
│   └── receivedAt: timestamp
├── codConfirmation: object (if COD)
│   ├── amountPaid: number (PHP)
│   ├── paymentMethod: string
│   ├── receivedAt: timestamp
│   └── notes: string
├── metadata: object
│   ├── createdAt: timestamp
│   ├── updatedAt: timestamp
│   └── webhookReceivedAt: timestamp (from carrier)
└── __v: integer
```

**Indexes:**
- `orderId` (ascending)
- `trackingNumber` (ascending)
- `status` (ascending)
- `sellerId` + `metadata.createdAt` (for seller tracking)

---

### 10. `refunds` - Refund Requests & Processing

Refund management.

```javascript
/refunds/{refundId}
├── refundId: string (UUID)
├── orderId: string
├── buyerId: string
├── sellerId: string
├── initiatedBy: string (enum: "buyer", "seller", "admin")
├── reason: string (enum: "wrong_item", "defective", "not_as_described", "changed_mind", "expired", "other")
├── reasonDetails: string (free-form explanation)
├── itemsRefunded: array
│   ├── [0]: object
│   │   ├── productId: string
│   │   ├── variantId: string
│   │   ├── quantity: number
│   │   ├── unitPrice: number (PHP)
│   │   └── totalPrice: number (PHP)
│   └── ...
├── refundAmount: number (PHP, partial or full)
├── status: string (enum: "pending_approval", "approved", "rejected", "in_progress", "completed", "failed", "disputed")
├── approval: object
│   ├── approvedBy: string (userId of approver, typically seller or admin)
│   ├── approvedAt: timestamp
│   ├── rejectionReason: string
│   └── notes: string
├── returnShipping: object
│   ├── required: boolean
│   ├── trackingNumber: string
│   ├── carrier: string
│   └── labelUrl: string
├── images: array (dispute photos uploaded by buyer)
│   ├── [0]: string (Firebase Storage URL)
│   └── ...
├── payment: object
│   ├── paymentRefundId: string (reference to payments collection refund record)
│   ├── method: string (enum: "original_payment_method", "wallet", "bank_transfer")
│   ├── processedAt: timestamp
│   ├── gatewayResponse: string (Xendit refund API response)
│   └── status: string (enum: "pending", "processed", "failed")
├── timeline: array
│   ├── [0]: object
│   │   ├── status: string
│   │   ├── timestamp: timestamp
│   │   └── updatedBy: string
│   └── ...
├── metadata: object
│   ├── createdAt: timestamp
│   ├── updatedAt: timestamp
│   ├── completedAt: timestamp
│   └── daysSinceRefundRequest: number (calculated)
└── __v: integer
```

**Indexes:**
- `orderId` (ascending)
- `buyerId` + `metadata.createdAt` (descending)
- `status` (ascending)
- `sellerId` + `status` (for seller approval queue)

---

### 11. `disputes` - Escalated Order Disputes

For contested refunds or order issues escalated to admin.

```javascript
/disputes/{disputeId}
├── disputeId: string (UUID)
├── orderId: string
├── refundId: string (if initiated as a refund)
├── buyerId: string
├── sellerId: string
├── initiatedBy: string (enum: "buyer", "seller", "admin")
├── category: string (enum: "quality", "non_delivery", "wrong_item", "payment_issue", "seller_misconduct", "other")
├── description: string
├── urgency: string (enum: "low", "medium", "high", "critical")
├── status: string (enum: "open", "in_review", "awaiting_seller_response", "awaiting_buyer_response", "resolved", "escalated")
├── assignedTo: string (admin userId assigned to resolve)
├── messages: array (chat/messaging thread)
│   ├── [0]: object
│   │   ├── messageId: string
│   │   ├── from: string (userId)
│   │   ├── role: string (enum: "buyer", "seller", "admin")
│   │   ├── text: string
│   │   ├── attachments: array (URLs)
│   │   └── createdAt: timestamp
│   └── ...
├── evidence: object
│   ├── buyerEvidence: array (URLs)
│   ├── sellerEvidence: array (URLs)
│   └── adminNotes: string
├── resolution: object
│   ├── decision: string (enum: "refund_full", "refund_partial", "reject", "replacement")
│   ├── decisionAmount: number (PHP, if refund)
│   ├── reasoning: string
│   ├── decidedBy: string (admin userId)
│   ├── decidedAt: timestamp
│   └── enforceAt: timestamp (when decision takes effect)
├── timeline: array
│   ├── [0]: object
│   │   ├── event: string
│   │   ├── timestamp: timestamp
│   │   └── details: string
│   └── ...
├── metadata: object
│   ├── createdAt: timestamp
│   ├── updatedAt: timestamp
│   ├── resolvedAt: timestamp
│   ├── daysOpen: number
│   └── escalatedCount: number
└── __v: integer
```

**Indexes:**
- `buyerId` + `metadata.createdAt` (for buyer dispute history)
- `sellerId` + `status` (for seller notifications)
- `status` (ascending, for admin queue)
- `assignedTo` + `status` (for admin dashboard)

---

### 12. `reviews` - Product & Seller Reviews

Customer reviews and ratings.

```javascript
/reviews/{reviewId}
├── reviewId: string (UUID)
├── orderId: string (must have purchased to review)
├── productId: string
├── sellerId: string
├── buyerId: string
├── rating: number (1-5 stars)
├── title: string (max 100 chars)
├── comment: string (max 500 chars)
├── aspects: object (structured feedback)
│   ├── quality: number (1-5)
│   ├── packaging: number (1-5)
│   ├── deliverySpeed: number (1-5)
│   └── sellerService: number (1-5)
├── images: array (review photos, up to 3)
│   ├── [0]: string (Firebase Storage URL)
│   └── ...
├── verified: boolean (true if reviewer has purchased)
├── helpful: object
│   ├── count: number (total "helpful" votes)
│   ├── voters: array (userId of helpful voters, limited display)
│   └── unhelpful: number (optional negative feedback)
├── sellerResponse: object (seller can respond to review)
│   ├── response: string (max 200 chars)
│   ├── respondedAt: timestamp
│   └── respondedBy: string (seller userId)
├── visibility: string (enum: "public", "hidden")
├── metadata: object
│   ├── createdAt: timestamp
│   ├── updatedAt: timestamp
│   └── lastModifiedBy: string
└── __v: integer
```

**Indexes:**
- `productId` + `rating` (descending, for product page sorting)
- `sellerId` + `metadata.createdAt` (for seller feedback)
- `buyerId` + `metadata.createdAt` (for buyer review history)
- `verified` (ascending, for filtering)

---

### 13. `wallets` - Seller Payment Wallets

Seller wallet for payment accumulation and payouts.

```javascript
/wallets/{walletId}
├── walletId: string (same as sellerId/storeId)
├── sellerId: string
├── storeId: string
├── currency: string (default: "PHP")
├── balance: object
│   ├── available: number (PHP, ready for payout)
│   ├── pending: number (PHP, 7-day hold after order delivery)
│   ├── onHold: number (PHP, disputes or chargebacks)
│   └── total: number (PHP, sum of above)
├── payoutSettings: object
│   ├── bankAccount: object
│   │   ├── bankName: string
│   │   ├── accountName: string
│   │   ├── accountNumber: string (encrypted)
│   │   ├── branchCode: string
│   │   └── verifiedAt: timestamp
│   ├── preferredPayoutMethod: string (enum: "bank_transfer", "gcash")
│   ├── minimumPayoutThreshold: number (PHP, e.g., 1000)
│   └── autoPayoutEnabled: boolean
├── payoutSchedule: object
│   ├── frequency: string (enum: "daily", "weekly", "manual")
│   ├── dayOfWeek: integer (0-6, if weekly)
│   └── lastPayoutAt: timestamp
├── transactions: array (recent transactions, max 50 denormalized)
│   ├── [0]: object
│   │   ├── transactionId: string
│   │   ├── type: string (enum: "order_received", "refund", "payout", "chargeback", "fee")
│   │   ├── amount: number (PHP)
│   │   ├── orderId: string (if order-related)
│   │   └── timestamp: timestamp
│   └── ...
├── metadata: object
│   ├── createdAt: timestamp
│   ├── updatedAt: timestamp
│   └── lastUpdatedBy: string (system or admin)
└── __v: integer
```

**Indexes:**
- `sellerId` (ascending)
- `balance.available` (for high-balance sellers identification)

---

### 14. `settlements` - Seller Payment Settlements

Historical payout records.

```javascript
/settlements/{settlementId}
├── settlementId: string (UUID, e.g., "SETTLE-20260318-00001")
├── sellerId: string
├── storeId: string
├── periodStart: date (settlement period start)
├── periodEnd: date (settlement period end)
├── status: string (enum: "pending", "processing", "completed", "failed", "cancelled")
├── summary: object
│   ├── ordersCount: number
│   ├── grossAmount: number (PHP, total order values)
│   ├── refundsAmount: number (PHP, refunds issued)
│   ├── feesAmount: number (PHP, Flora Match commission, e.g., 5%)
│   ├── chargesAmount: number (PHP, payment processor charges)
│   ├── netAmount: number (PHP, what seller receives)
│   └── hold: number (PHP, if any portion held for disputes)
├── orders: array (order references in this settlement)
│   ├── [0]: object
│   │   ├── orderId: string
│   │   ├── paymentStatus: string
│   │   └── amount: number
│   └── ...
├── transactions: array (ledger entries)
│   ├── [0]: object
│   │   ├── type: string (enum: "order", "refund", "fee", "charge", "hold", "release")
│   │   ├── orderId: string
│   │   ├── amount: number (PHP)
│   │   └── description: string
│   └── ...
├── payoutMethod: string (enum: "bank_transfer", "gcash")
├── payoutDetails: object
│   ├── bankAccount: string (last 4 digits, masked)
│   ├── transactionId: string (bank transfer reference)
│   ├── processedAt: timestamp
│   └── status: string (enum: "pending", "in_transit", "completed")
├── reconciliation: object
│   ├── reconciledAt: timestamp
│   ├── reconciledBy: string (admin)
│   ├── discrepancies: array
│   └── approved: boolean
├── metadata: object
│   ├── createdAt: timestamp
│   ├── updatedAt: timestamp
│   ├── processedAt: timestamp
│   └── approvedAt: timestamp
└── __v: integer
```

**Indexes:**
- `sellerId` + `periodEnd` (descending, for seller settlement history)
- `status` (ascending)
- `metadata.createdAt` (descending, for admin dashboard)

---

### 15. `transactions` - Wallet Transaction Ledger

Detailed transaction log for audit trail.

```javascript
/transactions/{transactionId}
├── transactionId: string (UUID)
├── walletId: string (reference to wallet)
├── sellerId: string
├── type: string (enum: "order_payment", "refund", "payout", "fee", "chargeback", "adjustment")
├── amount: number (PHP)
├── currency: string (default: "PHP")
├── balanceBefore: number (PHP)
├── balanceAfter: number (PHP)
├── reference: object
│   ├── orderId: string (if order-related)
│   ├── settlementId: string (if settlement-related)
│   ├── refundId: string (if refund-related)
│   └── description: string
├── metadata: object
│   ├── createdAt: timestamp
│   ├── createdBy: string (system or admin user)
│   └── notes: string
└── __v: integer
```

**Indexes:**
- `walletId` + `metadata.createdAt` (descending)
- `type` (ascending)

---

## Cross-Collection Queries & Denormalization

### Denormalized Fields (for read performance)

1. **orders.storeId** - Denormalized from order.sellerId for faster seller queries
2. **products.storeId** - Denormalized from sellerId for shop-based product queries
3. **reviews.verified** - Denormalized to filter verified purchases quickly
4. **orders.lineItems** - Full copy to avoid joins on orderItems
5. **shipments.trackingHistory** - Latest updates cached here

### Key Query Patterns

| Query | Collections | Index Needed |
|-------|-------------|--------------|
| Get all active products for a seller | products | sellerId + status |
| Get buyer's order history | orders | buyerId + createdAt DESC |
| Get seller pending orders | orders | sellerId + status |
| Get all reviews for a product | reviews | productId + rating DESC |
| Get seller settlements | settlements | sellerId + periodEnd DESC |
| Get transaction history for wallet | transactions | walletId + createdAt DESC |
| Search products by category | products | category + rating DESC |
| Get payment status for order | payments | orderId (unique) |

---

## TTL & Data Cleanup Policies

| Collection | TTL/Cleanup Strategy |
|-----------|----------------------|
| carts | Soft delete after 30 days inactivity; hard delete after 90 days |
| orders | Never deleted (retention for legal/tax purposes) |
| payments | Never deleted (retention for audit trail) |
| reviews | Archive after 2 years of order completion |
| disputes | Archive after 1 year of resolution |
| sessions (if implemented) | 24 hours TTL on auth tokens |

---

## Storage Estimates

| Collection | Est. Avg. Doc Size | Growth Rate | Year 1 Estimate |
|-----------|-------------------|-------------|-----------------|
| users | 2 KB | 500/month | 6,000 docs, 12 MB |
| stores | 3 KB | 50/month | 600 docs, 1.8 MB |
| products | 5 KB | 200/month | 2,400 docs, 12 MB |
| orders | 3 KB | 2,000/month | 24,000 docs, 72 MB |
| payments | 2 KB | 2,000/month | 24,000 docs, 48 MB |
| reviews | 2 KB | 1,000/month | 12,000 docs, 24 MB |

**Total Year 1 Estimate:** ~170 MB (within free tier if under 1M reads/writes/deletes monthly)

---

## Notes

- All timestamps use UTC (firestore.Timestamp)
- Encrypted fields (like passwords, bank details) are handled by application layer before storage
- Document IDs use UUIDs for security (avoid sequential IDs)
- Version control (`__v`) field helps with data migrations
- Composite indexes created by GCP upon first query execution

---

**Schema Version:** 1.0  
**Last Updated:** March 18, 2026  
**Status:** Ready for implementation
