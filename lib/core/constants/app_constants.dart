/// App-wide constants
class AppConstants {
  // App info
  static const String appName = 'Flora Match';
  static const String appVersion = '1.0.0';

  // Routes
  static const String splashRoute = '/';
  static const String authRoute = '/auth';
  static const String phoneVerificationRoute = '/auth/phone-verification';
  static const String roleSelectionRoute = '/auth/role-selection';
  static const String buyerDashboardRoute = '/buyer/dashboard';
  static const String sellerDashboardRoute = '/seller/dashboard';
  static const String adminDashboardRoute = '/admin/dashboard';

  // User roles
  static const String buyerRole = 'buyer';
  static const String sellerRole = 'seller';
  static const String adminRole = 'admin';

  // Order statuses
  static const String orderPending = 'pending_payment';
  static const String orderPaid = 'paid';
  static const String orderPacked = 'packed';
  static const String orderShipped = 'shipped';
  static const String orderDelivered = 'delivered';
  static const String orderCancelled = 'cancelled';
  static const String orderRefunded = 'refunded';

  // Payment statuses
  static const String paymentPending = 'pending';
  static const String paymentCompleted = 'completed';
  static const String paymentFailed = 'failed';
  static const String paymentRefunded = 'refunded';

  // Firestore collections
  static const String usersCollection = 'users';
  static const String storesCollection = 'stores';
  static const String productsCollection = 'products';
  static const String inventoryCollection = 'inventory';
  static const String cartsCollection = 'carts';
  static const String ordersCollection = 'orders';
  static const String paymentsCollection = 'payments';
  static const String shipmentsCollection = 'shipments';
  static const String refundsCollection = 'refunds';
  static const String reviewsCollection = 'reviews';
  static const String walletsCollection = 'wallets';
  static const String settlementsCollection = 'settlements';
  static const String transactionsCollection = 'transactions';

  // Local storage keys
  static const String authTokenKey = 'auth_token';
  static const String userIdKey = 'user_id';
  static const String userRoleKey = 'user_role';
  static const String userEmailKey = 'user_email';
  static const String userPhoneKey = 'user_phone';
  static const String lastSyncKey = 'last_sync';

  // Pagination
  static const int defaultPageSize = 20;
  static const int productPageSize = 15;
  static const int orderPageSize = 10;

  // Timeouts
  static const Duration httpTimeout = Duration(seconds: 30);
  static const Duration firebaseTimeout = Duration(seconds: 20);

  // UI
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration debounceDelay = Duration(milliseconds: 500);
}

class ValidationConstants {
  static const int minPasswordLength = 8;
  static const int minPhoneLength = 10;
  static const int maxPhoneLength = 15;
  static const int minProductNameLength = 3;
  static const int maxProductNameLength = 100;
  static const int minProductDescriptionLength = 10;
  static const int maxProductDescriptionLength = 2000;
}
