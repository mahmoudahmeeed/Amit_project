class Validation {
  static String? emailValidated(String? email) {
    if (email!.isEmpty) {
      return 'Email cannot be left blank';
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return 'Enter a valid Email';
    }
    return null;
  }

// argument: password is empty String if no input is entered
  static String? passwordValidated(String? password) {
    if (password!.isEmpty) {
      return 'Password cannot be left blank';
    } else if (password.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

// argument: phone is empty String if no input is entered
  static String? phoneValidated(String? phone) {
    if (phone!.isEmpty) {
      return 'Phone cannot be left blank';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(phone)) {
      // for desktop and web versions
      return 'Phone cannot have chracters';
    } else if (phone.length != 11) {
      return 'Phone must be 11 digits';
    }
    return null;
  }
}
