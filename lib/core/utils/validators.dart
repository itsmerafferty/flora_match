/// Phone number validators for Philippine numbers
class PhoneValidator {
  /// Validates Philippine phone number
  /// Accepts: 09XX XXX XXXX, 09XXXXXXXXXX, +639XXXXXXXXX, etc.
  static bool isPhilippinePhone(String phone) {
    if (phone.isEmpty) return false;

    // Remove all non-digit characters
    final digits = phone.replaceAll(RegExp(r'\D'), '');

    // Valid lengths for Philippine numbers:
    // 10 digits starting with 9 (09XX XXX XXXX)
    // 12 digits starting with 639 (+63 9XX XXX XXXX)
    if (digits.length == 10 && digits.startsWith('9')) {
      return true;
    }
    if (digits.length == 12 && digits.startsWith('639')) {
      return true;
    }

    return false;
  }

  /// Formats Philippine phone number to E.164 format (+639XXXXXXXXX)
  static String formatToE164(String phone) {
    final digits = phone.replaceAll(RegExp(r'\D'), '');

    if (digits.startsWith('0')) {
      return '+63${digits.substring(1)}';
    }
    if (digits.startsWith('63')) {
      return '+$digits';
    }

    // Default: add +63
    return '+63$digits';
  }
}

/// Email validators
class EmailValidator {
  static bool isValid(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }
}

/// Password validators
class PasswordValidator {
  /// Validates password strength
  /// Requirements:
  /// - Minimum 8 characters
  /// - At least one uppercase letter
  /// - At least one lowercase letter
  /// - At least one digit
  static bool isStrong(String password) {
    if (password.length < 8) return false;
    if (!RegExp(r'[A-Z]').hasMatch(password)) return false;
    if (!RegExp(r'[a-z]').hasMatch(password)) return false;
    if (!RegExp(r'[0-9]').hasMatch(password)) return false;
    return true;
  }

  static String getStrengthMessage(String password) {
    if (password.isEmpty) return 'Password is required';
    if (password.length < 8) return 'Minimum 8 characters required';
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Must contain uppercase letter';
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return 'Must contain lowercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) return 'Must contain a digit';
    return 'Strong password';
  }
}
