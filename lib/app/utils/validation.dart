/// Checks if string is email.
bool isValidEmail(
  String? inputString, {
  bool isRequired = false,
}) {
  bool isInputStringValid = false;

  if (!isRequired && (inputString == null ? true : inputString.isEmpty)) {
    isInputStringValid = true;
  }

  if (inputString != null && inputString.isNotEmpty) {
    const pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    final regExp = RegExp(pattern);

    isInputStringValid = regExp.hasMatch(inputString);
  }

  return isInputStringValid;
}

/// Password should have,
/// at least a upper case letter
///  at least a lower case letter
///  at least a digit
///  at least a special character [@#$%^&+=]
///  length of at least 4
/// no white space allowed
bool isValidPassword(
  String? inputString, {
  bool isRequired = false,
}) {
  bool isInputStringValid = false;

  if (!isRequired && (inputString == null ? true : inputString.isEmpty)) {
    isInputStringValid = true;
  }

  if (inputString != null && inputString.isNotEmpty) {
    const pattern =
        r'^(?=.*?[a-z])(?=.*?[A-Z])(?=(.*[\d]){1,})(?=(.*[\W]){1,})(?!.*\s).{8,}$';

    final regExp = RegExp(pattern);

    isInputStringValid = regExp.hasMatch(inputString);
  }

  return isInputStringValid;
}

/// Checks if string consist only Alphabet. (No Whitespace)

bool isText(
  String? inputString, {
  bool isRequired = false,
}) {
  bool isInputStringValid = false;

  if (!isRequired && (inputString == null ? true : inputString.isEmpty)) {
    isInputStringValid = true;
  }

  if (inputString != null && inputString.isNotEmpty) {
    const pattern = r'^[a-zA-Z]+$';

    final regExp = RegExp(pattern);

    isInputStringValid = regExp.hasMatch(inputString);
  }

  return isInputStringValid;
}

bool isValidPin(String? inputString, {bool isRequired = false}) {
  bool isInputStringValid = false;

  // Check if the input string is required and if it's null or empty
  if (!isRequired && (inputString == null || inputString.isEmpty)) {
    isInputStringValid = true;
  }

  // If the input string is not empty, validate it against the pattern
  if (inputString != null && inputString.isNotEmpty) {
    // Regular expression to check if the input is exactly 4 digits
    const pattern = r'^\d{4}$';
    final regExp = RegExp(pattern);

    isInputStringValid = regExp.hasMatch(inputString);
  }

  return isInputStringValid;
}

/// Checks if string is phone number

bool isValidPhone(String? inputString, {bool isRequired = false}) {
  bool isInputStringValid = false;

  if (!isRequired && (inputString == null ? true : inputString.isEmpty)) {
    isInputStringValid = true;
  }

  if (inputString != null && inputString.isNotEmpty) {
    if (inputString.length != 10) return false;

    const pattern = r'^[0-9]+$';

    final regExp = RegExp(pattern);

    isInputStringValid = regExp.hasMatch(inputString);
  }

  return isInputStringValid;
}

bool isEmptyOrNull(
  String? inputString, {
  bool isRequired = false,
}) {
  bool isInputStringValid = false;

  if (!isRequired && (inputString == null ? true : inputString.isEmpty)) {
    isInputStringValid = false;
  }

  if (inputString != null && inputString.isNotEmpty) {
    return true;
  }

  return isInputStringValid;
}

bool isValidInput(
  String? inputString, {
  bool isRequired = false,
  RegExp? customPattern, // Optional parameter for custom pattern
  bool allowEmpty = true, // Allows empty strings if not required
}) {
  if (inputString == null || inputString.isEmpty) {
    return !isRequired; // Return true if not required and empty or null, false otherwise
  }

  if (customPattern != null) {
    return customPattern.hasMatch(inputString);
  }

  return true; // If no custom pattern is provided, just return true if the string is not empty
}

bool isCommonText(String? inputString) {
  return isValidInput(inputString, isRequired: true);
}

//validate dare

String? fareValidator(
    {required String? value,
    required double? maxFarePrice,
    required double? minFarePrice}) {
  // Check if the value is empty or contains invalid characters
  if (value == null ||
      value.isEmpty ||
      value == "," ||
      value == "." ||
      value == " " ||
      value == "-") {
    return 'Enter a pricing';
  }

  // Parse the value to a double
  double? parsedValue = double.tryParse(value);
  if (parsedValue == null) {
    return 'Enter a valid pricing';
  }

  // Check if the value is greater than maxFarePrice
  if (parsedValue > (maxFarePrice ?? double.infinity)) {
    return 'Cost exceeded';
  }

  // Check if the value is less than minFarePrice
  if (parsedValue < (minFarePrice ?? double.negativeInfinity)) {
    return 'Cost under limit';
  }

  // Check if the value contains a decimal point
  if (value.contains('.')) {
    return 'Decimal not allowed';
  }

  // Check if the value is a valid number format without decimals
  final RegExp phoneExp = RegExp(r'^\d{1,4}$');

  if (!phoneExp.hasMatch(value)) {
    return 'Enter a valid pricing';
  }

  return null;
}



//r'^(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*[\d]){1,})(?=(.*[\W]){1,})(?!.*\s).{8,}$'
