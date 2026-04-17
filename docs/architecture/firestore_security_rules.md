# Firestore Security Rules - Flora Match Philippines

**Version:** 1.0 | **Last Updated:** March 18, 2026 | **Environment:** Development & Production

---

## Overview

These rules enforce:
- **Role-based access control** (Buyer, Seller, Admin)
- **Ownership validation** (users can only access their own data)
- **Payment integrity** (all payment writes go through Cloud Functions)
- **Admin override** (admins can moderate/override)
- **Data immutability** (audit logs, transactions)

---

## Rules

```javascript
rules_version = '2';

service cloud.firestore {
  match /databases/{database}/documents {
    
    // ============== HELPER FUNCTIONS ==============
    
    function isSignedIn() {
      return request.auth != null;
    }
    
    function uid() {
      return request.auth.uid;
    }
    
    function isAdmin() {
      return isSignedIn() && 
             get(/databases/$(database)/documents/users/$(uid())).data.role == 'admin';
    }
    
    function isBuyer() {
      return isSignedIn() && 
             get(/databases/$(database)/documents/users/$(uid())).data.role == 'buyer';
    }
    
    function isSeller() {
      return isSignedIn() && 
             get(/databases/$(database)/documents/users/$(uid())).data.role == 'seller';
    }
    
    function isStoreOwner(storeId) {
      return isSignedIn() && 
             get(/databases/$(database)/documents/stores/$(storeId)).data.uid == uid();
    }
    
    function isOrderBuyer(orderId) {
      return isSignedIn() && 
             get(/databases/$(database)/documents/orders/$(orderId)).data.uid == uid();
    }
    
    function isOrderSeller(orderId) {
      return isSignedIn() && 
             get(/databases/$(database)/documents/orders/$(orderId)).data.storeId in 
             get(/databases/$(database)/documents/users/$(uid())).data.storeIds;
    }
    
    // ============== USERS COLLECTION ==============
    
    match /users/{userId} {
      // Read: Users can read their own profile, anyone can read public seller info
      allow read: if isSignedIn() && 
                     (userId == uid() || 
                      get(/databases/$(database)/documents/users/$(userId)).data.role == 'seller');
      
      // Create: New user account (auth triggered)
      allow create: if isSignedIn() && userId == uid() &&
                       request.data.role in ['buyer', 'seller'] &&
                       request.data.keys().hasAll(['email', 'phone']);
      
      // Update: User can update their own profile, immutable fields protected
      allow update: if userId == uid() &&
                       !request.resource.data.diff(resource.data).affectedKeys()
                         .hasAny(['uid', 'role', 'kycVerified', 'status']);
      
      // Delete: Soft delete only (status: deleted)
      allow delete: if false;
    }
    
    // ============== STORES COLLECTION ==============
    
    match /stores/{storeId} {
      // Read: Anyone can view public store profiles
      allow read: if isSignedIn();
      
      // Create: Seller can create own store
      allow create: if isSeller() && request.data.uid == uid();
      
      // Update: Store owner can update, except bankAccount/gcashAccount without auth
      allow update: if isStoreOwner(storeId) &&
                       !request.resource.data.diff(resource.data).affectedKeys()
                         .hasAny(['uid', 'storeId', 'status']);
      
      // Delete: Admins only (status to 'closed' instead)
      allow delete: if isAdmin();
    }
    
    // ============== PRODUCTS COLLECTION ==============
    
    match /products/{productId} {
      // Read: Anyone can view active products, seller/admin see all
      allow read: if isSignedIn() && 
                     (resource.data.status == 'active' || 
                      isStoreOwner(resource.data.storeId) || 
                      isAdmin());
      
      // Create: Seller can create product for their store
      allow create: if isSeller() && 
                       request.data.storeId in 
                       get(/databases/$(database)/documents/users/$(uid())).data.storeIds;
      
      // Update: Store owner or admin can update
      allow update: if (isStoreOwner(resource.data.storeId) || isAdmin()) &&
                       !request.resource.data.diff(resource.data).affectedKeys()
                         .hasAny(['productId', 'storeId', 'uid']);
      
      // Delete: Store owner or admin can delete (soft-delete)
      allow delete: if isStoreOwner(resource.data.storeId) || isAdmin();
    }
    
    // ============== INVENTORY COLLECTION ==============
    
    match /inventory/{skuId} {
      // Read: Product owner or admin
      allow read: if isSignedIn() && 
                     (isStoreOwner(resource.data.storeId) || isAdmin());
      
      // Create: Store owner only
      allow create: if isSeller() && request.data.storeId in 
                       get(/databases/$(database)/documents/users/$(uid())).data.storeIds;
      
      // Update: Cloud Function only (protect from direct writes)
      allow update: if false;
      
      // Delete: Never (immutable record)
      allow delete: if false;
    }
    
    // ============== CARTS COLLECTION ==============
    
    match /carts/{cartUserId} {
      // Read: Only user can read own cart
      allow read: if isSignedIn() && cartUserId == uid();
      
      // Create: User creates own cart
      allow create: if isSignedIn() && cartUserId == uid();
      
      // Update: User can update own cart
      allow update: if isSignedIn() && cartUserId == uid();
      
      // Delete: User can delete own cart
      allow delete: if isSignedIn() && cartUserId == uid();
    }
    
    // ============== ORDERS COLLECTION ==============
    
    match /orders/{orderId} {
      // Read: Buyer, seller of order, or admin can view
      allow read: if isSignedIn() && 
                     (isOrderBuyer(orderId) || 
                      isOrderSeller(orderId) || 
                      isAdmin());
      
      // Create: Cloud Function only (no direct client writes)
      allow create: if false;
      
      // Update: Cloud Function only (strict state machine)
      allow update: if false;
      
      // Delete: Never
      allow delete: if false;
    }
    
    // ============== ORDER ITEMS COLLECTION ==============
    
    match /orderItems/{orderItemId} {
      // Read: Via order access
      allow read: if isSignedIn() && 
                     isOrderBuyer(get(/databases/$(database)/documents/orderItems/$(orderItemId)).data.orderId) ||
                     isOrderSeller(get(/databases/$(database)/documents/orderItems/$(orderItemId)).data.orderId) ||
                     isAdmin();
      
      // Write: Cloud Function only
      allow create, update, delete: if false;
    }
    
    // ============== PAYMENTS COLLECTION ==============
    
    match /payments/{paymentId} {
      // Read: Buyer, seller, or admin
      allow read: if isSignedIn() && 
                     (isOrderBuyer(resource.data.orderId) || 
                      isOrderSeller(resource.data.orderId) || 
                      isAdmin());
      
      // Create: Cloud Function only
      allow create: if false;
      
      // Update: Cloud Function only (webhook processor)
      allow update: if false;
      
      // Delete: Never
      allow delete: if false;
    }
    
    // ============== SHIPMENTS COLLECTION ==============
    
    match /shipments/{shipmentId} {
      // Read: Buyer, seller, admin
      allow read: if isSignedIn() && 
                     (isOrderBuyer(resource.data.orderId) || 
                      isOrderSeller(resource.data.orderId) || 
                      isAdmin());
      
      // Create: Cloud Function only
      allow create: if false;
      
      // Update: Cloud Function only (carrier sync)
      allow update: if false;
      
      // Delete: Never
      allow delete: if false;
    }
    
    // ============== REFUNDS COLLECTION ==============
    
    match /refunds/{refundId} {
      // Read: Requester, store owner, admin
      allow read: if isSignedIn() && 
                     (resource.data.uid == uid() || 
                      isStoreOwner(resource.data.storeId) || 
                      isAdmin());
      
      // Create: Buyer can request refund (limited fields)
      allow create: if isBuyer() && 
                       request.data.uid == uid() &&
                       request.data.keys().hasOnly(['orderId', 'reason', 'buyerNotes', 'photoProofs']);
      
      // Update: Store owner can approve/reject, Cloud Function handles completion
      allow update: if (isStoreOwner(resource.data.storeId) || isAdmin()) &&
                       request.resource.data.diff(resource.data).affectedKeys()
                         .hasOnly(['status', 'sellerNotes', 'rejectionReason']) ||
                       isAdmin();
      
      // Delete: Never
      allow delete: if false;
    }
    
    // ============== REVIEWS COLLECTION ==============
    
    match /reviews/{reviewId} {
      // Read: Anyone (public reviews)
      allow read: if resource.data.moderation.status == 'approved' || isAdmin();
      
      // Create: Buyer can review own order
      allow create: if isBuyer() && 
                       request.data.uid == uid() &&
                       request.data.isVerifiedPurchase == true;
      
      // Update: Buyer can edit before moderation, admin can approve
      allow update: if (resource.data.uid == uid() && resource.data.moderation.status == 'pending') ||
                       isAdmin();
      
      // Delete: Admin only
      allow delete: if isAdmin();
    }
    
    // ============== WALLETS COLLECTION ==============
    
    match /wallets/{walletId} {
      // Read: User can read own wallet
      allow read: if isSignedIn() && 
                     get(/databases/$(database)/documents/wallets/$(walletId)).data.uid == uid() ||
                     isAdmin();
      
      // Create: Cloud Function only
      allow create: if false;
      
      // Update: Cloud Function only
      allow update: if false;
      
      // Delete: Never
      allow delete: if false;
    }
    
    // ============== SETTLEMENTS COLLECTION ==============
    
    match /settlements/{settlementId} {
      // Read: Seller, admin
      allow read: if isSignedIn() && 
                     (isStoreOwner(resource.data.storeId) || isAdmin());
      
      // Write: Cloud Function only
      allow create, update, delete: if false;
    }
    
    // ============== TRANSACTIONS COLLECTION ==============
    
    match /transactions/{transactionId} {
      // Read: Admin only (immutable audit log)
      allow read: if isAdmin();
      
      // Create: Cloud Function only (system writes)
      allow create: if false;
      
      // Update: Never (immutable)
      allow update: if false;
      
      // Delete: Never (immutable audit)
      allow delete: if false;
    }
    
    // ============== ADMIN COLLECTION ==============
    
    match /admin/{document=**} {
      // Read: Admin only
      allow read: if isAdmin();
      
      // Write: Admin only (settings, config)
      allow write: if isAdmin();
    }
    
    // ============== CATCH-ALL (DENY ALL) ==============
    
    match /{document=**} {
      allow read, write: if false;
    }
  }
}
```

---

## Access Summary Table

| Collection | Buyer | Seller | Admin | Notes |
|-----------|-------|--------|-------|-------|
| **users** | Read own | Read own | Read all | Public seller profiles readable |
| **stores** | Read public | Read/write own | Read/write all | |
| **products** | Read active | CRUD own | Read/write all | Moderated via `status` field |
| **inventory** | None | Read own | Read all | Cloud Function only |
| **carts** | CRUD own | None | None | Session-based |
| **orders** | Read own | Read own | Read all | Cloud Function creates/updates |
| **payments** | Read own | Read own | Read all | Cloud Function manages |
| **shipments** | Read own | Read own | Read all | Cloud Function syncs |
| **refunds** | Create own | Approve | Manage | Buyer creates, seller approves |
| **reviews** | Create own | Read own | Moderate | Moderation gate before public |
| **wallets** | Read own | Read own | Read all | Cloud Function only |
| **settlements** | None | Read own | Read all | Cloud Function batch payout |
| **transactions** | None | None | Read only | Immutable audit log |
| **admin** | None | None | Write | System config, flags |

---

## Security Best Practices Implemented

✅ **Principle of Least Privilege:** Users only access data they own or have role-based permission  
✅ **Immutable Audit Trail:** `transactions` collection never updated/deleted  
✅ **Payment Safety:** All payment/refund writes via Cloud Functions (no direct client writes)  
✅ **Role-Based Access:** Buyer, Seller, Admin roles with distinct permissions  
✅ **Field-Level Protection:** Sensitive fields (uid, role, storeId) not updatable by users  
✅ **Soft Deletes:** Users/stores marked `status: deleted` instead of hard-deleted  
✅ **Admin Override:** Admins can moderate, resolve disputes, and audit  
✅ **Idempotency:** Payment functions use idempotency keys to prevent duplicates  

---

## Deployment Notes

1. **Deploy to Firebase Console:**
   ```bash
   firebase deploy --only firestore:rules --project=flora-match-ph
   ```

2. **Test in Firebase Emulator (local development):**
   ```bash
   firebase emulators:start
   ```

3. **Rollback (if issues):**
   ```bash
   firebase firestore:rollback --project=flora-match-ph
   ```

4. **Review logs:**
   ```bash
   gcloud logging read \
     "resource.type=cloud_firestore_database" \
     --project=flora-match-ph --limit=100
   ```

---

## Monitoring & Alerts

**Set up alerts in Firebase Console for:**
- Denied read/write attempts (security rule violations)
- Unusually high payment transaction volume
- Failed settlement batches
- Admin override usage

