// ignore_for_file: file_names

import 'package:noya_app/core/constant.dart';

class Validator {
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return "Email can't be empty";
    }
    if (!RegExp(Constant.regExValidateEmail).hasMatch(value)) {
      return "Enter a valid email address";
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return "Password can't be empty";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return "Password can't be empty";
    }
    if (value != password) {
      return "Passwords do not match";
    }
    return null;
  }

  static String? userName(String? value) {
    if (value == null || value.isEmpty) {
      return "Username can't be empty";
    }
    if (value.length > 20) {
      return "Username cannot be more than 20 characters";
    }
    return null;
  }

  static String? firstName(String? value) {
    if (value == null || value.isEmpty) {
      return "First name can't be empty";
    }
    if (value.length > 20) {
      return "First name cannot be more than 20 characters";
    }
    return null;
  }

  static String? lastName(String? value) {
    if (value == null || value.isEmpty) {
      return "Last name can't be empty";
    }
    if (value.length > 20) {
      return "Last name cannot be more than 20 characters";
    }
    return null;
  }

  static String? phoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number can't be empty";
    }
    if (value.length > 20) {
      return "Phone number cannot be more than 20 characters";
    }
    return null;
  }
}
