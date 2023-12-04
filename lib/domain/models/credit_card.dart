class CreditCard {
  String cardNumber;
  String cardHolderName;
  String expirationDate;
  String cvv;

  CreditCard({
    required this.cardNumber,
    required this.cardHolderName,
    required this.expirationDate,
    required this.cvv,
  });

  bool isValidCardNumber() {
    return cardNumber.length == 16;
  }

  bool isValidExpirationDate() {
    var now = DateTime.now();
    var currentYear = now.year % 100;
    var currentMonth = now.month;

    var parts = expirationDate.split('/');
    if (parts.length != 2) {
      return false;
    }

    var month = int.tryParse(parts[0]);
    var year = int.tryParse(parts[1]);

    if (month == null || year == null) {
      return false;
    }

    return year > currentYear || (year == currentYear && month >= currentMonth);
  }

  bool isValidCVV() {
    // Implement your CVV validation logic here
    // For simplicity, let's assume a valid CVV is a 3-digit number
    return cvv.length == 3;
  }

  bool isValid() {
    // Check all validation criteria
    return isValidCardNumber() && isValidExpirationDate() && isValidCVV();
  }
}
