class Validators {
  static bool isValidPassword(String string) {
    // Null or empty string is invalid
    // Password must be more than 8 character long or more.
    if (string == null || string.isEmpty) {
      return false;
    }
    if (string.length >= 8) {
      return true;
    }
    return false;
  }

  static bool isValidName(String string) {
    // Null or empty string is invalid.
    if (string == null || string.isEmpty) {
      return false;
    }
    // Valid Charactors include (A-Z) (a-z).
    const pattern = r'^[A-Za-z]+$';

    // Name should contain 1 words only.
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(string)) {
      return false;
    }
    return true;
  }

  static bool isValidOtp(String otp) {
    // Null or empty otp is invalid. Only for 4 Digit OTP.
    if (otp == null || otp.isEmpty) {
      return false;
    }

    Pattern pattern = r'^\d{4}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(otp)) {
      return false;
    }
    return true;
  }
}
