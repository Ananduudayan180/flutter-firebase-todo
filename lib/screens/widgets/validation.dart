class Validation {
  static String? emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return "Email is required";
    } else if (!RegExp(r'^[\w.-]+@[\w.-]+\.\w+$').hasMatch(email)) {
      return "Invalid email address";
    }
    return null;
  }

  static String? passValidator(String? pass) {
    if (pass == null || pass.isEmpty) {
      return "Password is required";
    } else if (pass.length < 6) {
      return "Password must be at least 6 characters";
    } else if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)').hasMatch(pass)) {
      return "Password too weak";
    }
    return null;
  }

  static String? nameValidator(String? name) {
    if (name == null || name.isEmpty) {
      return "Name is required";
    } else if (name.length <= 2) {
      return "Name too short";
    } else if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(name)) {
      return "Invalid characters in name";
    }
    return null;
  }

  static String? taskTitleValidator(String? taskTitle) {
    if (taskTitle == null || taskTitle.isEmpty) {
      return "Name is required";
    }
    return null;
  }

  static String? taskContentValidator(String? taskContent) {
    if (taskContent == null || taskContent.isEmpty) {
      return "Content is required";
    }
    return null;
  }
}
