

import 'package:email_validator/email_validator.dart';

class EmailValidation {
  static bool validate(String value) {
    return EmailValidator.validate(value);
  }
}
