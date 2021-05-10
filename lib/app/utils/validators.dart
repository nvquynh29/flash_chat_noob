class Validators {
  static bool isValidEmail(String email) {
    RegExp _emailRegex = RegExp(
        '^[a-zA-Z0-9.!#\$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*');
    return _emailRegex.hasMatch(email);
  }

  static bool isValidPassword(String password) {
    return (password != null && password.length >= 8);
  }
}
