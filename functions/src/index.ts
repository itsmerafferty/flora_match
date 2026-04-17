// Firebase Cloud Functions - Main Entry Point (Skeleton)
// Located in: functions/src/index.ts

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

// Initialize Firebase Admin SDK
admin.initializeApp();

// Logger for debugging
const logger = functions.logger;

/**
 * PHASE 0: Foundation - Basic HTTP function templates
 * These will be expanded in Phase 1–3
 */

// ============== HEALTH CHECK ==============
export const healthCheck = functions
  .https.onRequest((request, response) => {
    response.json({
      status: "healthy",
      timestamp: new Date().toISOString(),
      environment: process.env.ENVIRONMENT || "development",
    });
  });

// ============== AUTH FUNCTIONS ==============

/**
 * Create user document after Firebase Auth sign-up
 * Triggered by: Auth onCreate event
 */
export const createUserDoc = functions.auth.user().onCreate(async (user) => {
  try {
    logger.info(`Creating user document for ${user.uid}`);

    await admin.firestore().collection("users").doc(user.uid).set({
      uid: user.uid,
      email: user.email || null,
      phone: user.phoneNumber || null,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      status: "active",
      role: null, // To be set by client after role selection
    });

    logger.info(`User document created for ${user.uid}`);
  } catch (error) {
    logger.error(`Failed to create user document for ${user.uid}:`, error);
    throw error;
  }
});

// ============== ORDER FUNCTIONS ==============

/**
 * Create order - Placeholder for Phase 1
 * Called from: Flutter app checkout flow
 */
export const createOrder = functions.https.onCall(async (data, context) => {
  // Verify user is authenticated
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated"
    );
  }

  try {
    logger.info(`Creating order for user ${context.auth.uid}`);

    // TODO: Implement in Phase 1
    // 1. Validate cart items
    // 2. Validate pricing
    // 3. Reserve inventory
    // 4. Create order document
    // 5. Return order ID

    return {
      success: true,
      message: "Order creation not yet implemented (Phase 1)",
      orderId: null,
    };
  } catch (error) {
    logger.error("Error creating order:", error);
    throw new functions.https.HttpsError("internal", "Failed to create order");
  }
});

// ============== PAYMENT FUNCTIONS ==============

/**
 * Handle Xendit payment webhook - Placeholder for Phase 2
 * Called from: Xendit API webhook
 */
export const handlePaymentWebhook = functions.https.onRequest(
  async (request, response) => {
    try {
      logger.info("Received payment webhook:", request.body);

      // TODO: Implement in Phase 2
      // 1. Verify webhook signature (Xendit)
      // 2. Extract payment status
      // 3. Update order status
      // 4. Trigger notifications
      // 5. Respond with 200 OK

      response.status(200).json({ success: true });
    } catch (error) {
      logger.error("Error handling payment webhook:", error);
      response.status(500).json({ error: "Internal server error" });
    }
  }
);

// ============== SETTLEMENT FUNCTIONS ==============

/**
 * Release seller payout after 7-day hold - Placeholder for Phase 2
 * Triggered by: Cloud Scheduler (daily)
 */
export const releaseSellerPayout = functions.pubsub
  .schedule("0 1 * * *") // 1 AM UTC+8 (PH time)
  .timeZone("Asia/Manila")
  .onRun(async (context) => {
    try {
      logger.info("Starting seller payout release job");

      // TODO: Implement in Phase 2
      // 1. Query orders with status='delivered' and deliveredAt > 7 days
      // 2. Group by seller
      // 3. Calculate net payout (order total - fees)
      // 4. Create settlement record
      // 5. Call Xendit Payout API
      // 6. Update settlement status

      logger.info("Seller payout release completed");
      return null;
    } catch (error) {
      logger.error("Error releasing seller payout:", error);
      throw error;
    }
  });

// ============== RECONCILIATION FUNCTIONS ==============

/**
 * Daily payment reconciliation - Placeholder for Phase 2
 * Triggered by: Cloud Scheduler (daily)
 */
export const reconcilePayments = functions.pubsub
  .schedule("0 2 * * *") // 2 AM UTC+8 (PH time)
  .timeZone("Asia/Manila")
  .onRun(async (context) => {
    try {
      logger.info("Starting payment reconciliation job");

      // TODO: Implement in Phase 2
      // 1. Query all payments from last 24 hours
      // 2. Query Xendit API for payment status
      // 3. Compare internal records vs Xendit
      // 4. Alert on mismatches
      // 5. Log reconciliation results

      logger.info("Payment reconciliation completed");
      return null;
    } catch (error) {
      logger.error("Error reconciling payments:", error);
      throw error;
    }
  });

// ============== SHIPPING FUNCTIONS ==============

/**
 * Sync shipping status from carrier - Placeholder for Phase 3
 * Triggered by: Cloud Scheduler (every 6 hours)
 */
export const syncShippingStatus = functions.pubsub
  .schedule("0 */6 * * *")
  .timeZone("Asia/Manila")
  .onRun(async (context) => {
    try {
      logger.info("Starting shipping status sync");

      // TODO: Implement in Phase 3
      // 1. Query shipments with status != 'delivered'
      // 2. Call carrier API (LBC, J&T) to get status
      // 3. Update shipment document
      // 4. Update order status if delivered
      // 5. Send notification to buyer

      logger.info("Shipping status sync completed");
      return null;
    } catch (error) {
      logger.error("Error syncing shipping status:", error);
      throw error;
    }
  });

// ============== CLEANUP FUNCTIONS ==============

/**
 * Clean up expired carts - Placeholder
 * Triggered by: Cloud Scheduler (daily)
 */
export const cleanupExpiredCarts = functions.pubsub
  .schedule("0 3 * * *") // 3 AM UTC+8 (PH time)
  .timeZone("Asia/Manila")
  .onRun(async (context) => {
    try {
      logger.info("Starting cart cleanup job");

      // Delete carts older than 7 days
      const expiryTime = new Date(Date.now() - 7 * 24 * 60 * 60 * 1000);

      const snapshot = await admin
        .firestore()
        .collection("carts")
        .where("lastUpdated", "<", expiryTime)
        .get();

      const batch = admin.firestore().batch();
      snapshot.docs.forEach((doc) => {
        batch.delete(doc.ref);
      });

      await batch.commit();

      logger.info(`Deleted ${snapshot.docs.length} expired carts`);
      return null;
    } catch (error) {
      logger.error("Error cleaning up carts:", error);
      throw error;
    }
  });

logger.info("Flora Match Cloud Functions initialized (Phase 0)");
