import 'dart:convert';

class Helper {
  static Map<String, dynamic>? decodeJwt(String token) {
    try {
      List<String> parts = token.split('.');
      if (parts.length != 3) {
        return null;
      }

      String payloadBase64 = parts[1];
      String decodedPayload = utf8.decode(base64Url.decode(payloadBase64));

      Map<String, dynamic> decodedMap = json.decode(decodedPayload);

      return decodedMap;
    } catch (e) {
      return null;
    }
  }

  static String formatNumberWithCommas(String number) {
    String formattedNumber = number;
    final RegExp regExp = RegExp(r'\B(?=(\d{3})+(?!\d))');

    return formattedNumber.replaceAllMapped(regExp, (Match match) => ',');
  }

  static String removeTrailingZeros(double value) {
    String stringValue = value.toString();
    if (stringValue.contains('.')) {
      // Remove trailing zeros after the decimal point
      stringValue = stringValue.replaceAll(RegExp(r"0*$"), "");
      // Remove the decimal point if no decimal part remains
      if (stringValue.endsWith('.')) {
        stringValue = stringValue.substring(0, stringValue.length - 1);
      }
    }
    return stringValue;
  }

  static bool isEmailValid(String email) {
    // Define a regular expression for a valid email format
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

    // Check if the provided email matches the regex pattern
    return emailRegex.hasMatch(email);
  }

  static bool hasSpecialCharacter(String password) {
    // Define a regular expression for detecting special characters
    final specialCharRegex = RegExp(r'[!@#\$%^&*(),.?":{}|<>]');

    // Check if the provided password contains at least one special character
    return specialCharRegex.hasMatch(password);
  }
}
