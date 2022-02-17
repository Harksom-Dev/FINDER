import 'package:firebase_auth/firebase_auth.dart';
import 'package:form_field_validator/form_field_validator.dart';

class CustomValidator extends FieldValidator<String> {
  CustomValidator(String errorText) : super(errorText);
  bool result = false;
  Future<void> checkIfEmailNotInUse(String value) async {
    try {
      // Fetch sign-in methods for the email address
      final list =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(value);
      // In case list is not empty
      Future.delayed(const Duration(seconds: 1));
      if (list.isEmpty) {
        result = true;
      } else {
        result = false;
      }
    } catch (error) {
      result = false;
    }
  }

  @override
  bool isValid(value) {
    // TODO: implement isValid
    checkIfEmailNotInUse(value);
    return result;
  }
}
