/// Payment configuration constants
class PaymentConfig {
  // Xendit configuration
  static const String xenditBaseUrl = 'https://api.xendit.co';
  static const String xenditSandboxUrl = 'https://api.xendit.co'; // Same for testing

  // Payment timeout
  static const Duration paymentTimeout = Duration(minutes: 15);

  // Currency
  static const String currency = 'PHP';
  static const int currencyDecimals = 2;

  // Fees (Platform Fees)
  static const double platformFeePercentage = 0.10; // 10%

  // Tax (PH VAT)
  static const double vatPercentage = 0.12; // 12%

  // Payout settings
  static const int defaultHoldDays = 7; // Hold payment 7 days before settlement
  static const double minimumPayoutAmount = 1000.00; // PHP

  // Payment methods available
  static const List<String> availablePaymentMethods = [
    'GCASH',
    'CARD',
    'BANK_TRANSFER',
  ];

  // Refund window
  static const int maxRefundWindowDays = 30;

  // Idempotency key prefix
  static const String idempotencyKeyPrefix = 'flora_match_';
}

class ShippingConfig {
  // Shipping cost configuration (base rate in PHP)
  static const Map<String, double> regionalRates = {
    'NCR': 150.0, // Metro Manila
    'CAR': 200.0, // Cordillera Administrative Region
    'REGION_I': 180.0,
    'REGION_II': 200.0,
    'REGION_III': 180.0,
    'REGION_IV_A': 150.0,
    'REGION_IV_B': 250.0,
    'REGION_V': 200.0,
    'REGION_VI': 220.0,
    'REGION_VII': 200.0,
    'REGION_VIII': 250.0,
    'REGION_IX': 280.0,
    'REGION_X': 250.0,
    'REGION_XI': 220.0,
    'REGION_XII': 250.0,
    'REGION_XIII': 300.0,
  };

  // Shipping carriers
  static const List<String> availableCarriers = [
    'LBC',
    'J&T',
    '2GO',
    'LALAMOVE',
  ];

  // Max delivery days by region
  static const Map<String, int> maxDeliveryDays = {
    'NCR': 2,
    'CAR': 3,
    'REGION_I': 3,
    'REGION_II': 4,
    'REGION_III': 3,
    'REGION_IV_A': 3,
    'REGION_IV_B': 4,
    'REGION_V': 4,
    'REGION_VI': 4,
    'REGION_VII': 4,
    'REGION_VIII': 5,
    'REGION_IX': 5,
    'REGION_X': 5,
    'REGION_XI': 4,
    'REGION_XII': 5,
    'REGION_XIII': 5,
  };
}
