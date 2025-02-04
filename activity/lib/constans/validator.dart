class MyValidators {
  static String? displayNameValidator(String? displayName) {
    if (displayName == null || displayName.isEmpty) {
      return 'Görünen ad boş olamaz';
    }
    if (displayName.length < 3 || displayName.length > 20) {
      return 'görünen ad 3 ila 20 karakter arasında olmalıdır';
    }
    return null;
  }

  static String? EmailValidator(String? value) {
    if (value!.isEmpty) {
      return 'lütfen bir e-posta girin';
    }
    if (!RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
        .hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? PasswordValidator(String? value) {
    if (value!.isEmpty) {
      return 'lütfen bir şifre girin';
    }
    if (value.length < 6) {
      return 'şifre en az 6 karakter olmalıdır';
    }

    return null;
  }

  static String? repeatPasswordValidator(String? value, String? password) {
    if (value != password) {
      return 'Parola eşleşmedi';
    }

    return null;
  }

  static String? uploadProdText({String? value, String? toBeReturnedString}) {
    if (value!.isEmpty) {
      return toBeReturnedString;
    }
    return null;
  }
}
