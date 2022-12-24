// ignore: missing_return
String? phoneNumberValidator(phoneNumber) {
  if (phoneNumber.length != 10) {
    return "Please enter a 10 digit number.";
  }
  return null;
}

String? referralCodeValidator(phoneNumber) {
  if (phoneNumber.isNotEmpty && phoneNumber.length != 10)
    return "Please enter a 10 digit number.";

  return null;
}
