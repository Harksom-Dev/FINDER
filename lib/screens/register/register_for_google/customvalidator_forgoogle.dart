import 'package:firebase_auth/firebase_auth.dart';
import 'package:form_field_validator/form_field_validator.dart';

class CustomValidatorForGoogle extends FieldValidator<String> {
  CustomValidatorForGoogle(String errorText) : super(errorText);
  bool result = false;

  Future checkIfEmailNotInUse(String value) async {
    final list = await FirebaseAuth.instance.fetchSignInMethodsForEmail(value);
    try {
      // Fetch sign-in methods for the email address
      // final list =
      //     await FirebaseAuth.instance.fetchSignInMethodsForEmail(value);
      // In case list is not empty
      // await Future.delayed(const Duration(seconds: 2));
      print(list);
      print(list.isEmpty);
      // if (list.isEmpty) {
      //   result = true;
      // } else {
      //   result = false;
      // }
      return result = list.isEmpty;
    } catch (error) {
      return false;
    }
  }

  @override
  bool isValid(value) {
    checkIfEmailNotInUse(value);
    print("output: $result");
    return result;
  }
}
