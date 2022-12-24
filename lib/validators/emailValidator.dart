String? emailValidator(email) {
  bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  if (email == null || email.isEmpty) {
    return 'This field is required';
  }

  // if (!RegExp(r'\S+@\S+\.\S+').hasMatch(email)) {
  //   return "Please enter a valid email address";
  // }

  // return null;
  if (emailValid == true) {
    return null;
  } else {
    return "Please enter a valid email address";
  }
}
