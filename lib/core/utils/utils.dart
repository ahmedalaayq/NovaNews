class Utils {
  /*
    Form Validation 
  */

  // ================= Email =================
  static final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  // ================= Password =================
  static final RegExp passwordRegExp = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
  );

  static String? emailFieldValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email field is required';
    }

    if (!emailRegExp.hasMatch(value.trim())) {
      return 'Enter valid email';
    }

    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password field is required';
    }

    if (value.trim().length < 8) {
      return 'Password must be at least 8 characters';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain uppercase letter';
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain lowercase letter';
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain number';
    }

    if (!RegExp(r'[@$!%*?&]').hasMatch(value)) {
      return 'Password must contain special character';
    }

    return null;
  }

  /*
      Format Date 
   */


}
