import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cross_link/src/config/router/routes.dart';
import 'package:cross_link/src/presentation/widgets/sign_in_widget.dart';
import 'package:flutter/material.dart';

class SignUpWidget extends StatelessWidget {
  const SignUpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: MediaQuery.of(context).size.width,
        height: 310,
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 20,),
            const Text(
              "Create your account",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15,),
            const Text(
              "Your personal account with your healthcare information",
              style: TextStyle(
                fontSize: 18,
              )
            ),
            const Text(
              "The best personalized experience",
              style: TextStyle(
                fontSize: 18,
              )
            ),
            const Text(
              "Exclusive update and notices",
              style: TextStyle(
                fontSize: 18,
              )
            ),
            const SizedBox(height: 30,),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, Routes.SIGN_UP);
                },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              child: const Text("Sign up with email", style: TextStyle(color: Colors.white),),
            ),
            const SizedBox(height: 20,),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: <Widget>[
                const Text(
                  "Already have an account?",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                      print('sign up before');
                      await signUpUser(username: 'user1', password: 'Pa12345678#', email: 'patrickortizlaura@gmail.com');
                      Navigator.pop(context);
                      showDialog(context: context, builder: (BuildContext context) => SignInWidget());
                    },
                  child: const Text("Sign in",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signUpUser({
    required String username,
    required String password,
    required String email,
    String? phoneNumber,
  }) async {
    try {
      final userAttributes = {
        AuthUserAttributeKey.email: email,
        if (phoneNumber != null) AuthUserAttributeKey.phoneNumber: phoneNumber,
        // additional attributes as needed
      };
      final result = await Amplify.Auth.signUp(
        username: username,
        password: password,
        options: SignUpOptions(
          userAttributes: userAttributes,
        ),
      );
      await _handleSignUpResult(result);
    } on AuthException catch (e) {
      safePrint('Error signing up user: ${e.message}');
    }
  }

  Future<void> _handleSignUpResult(SignUpResult result) async {
    switch (result.nextStep.signUpStep) {
      case AuthSignUpStep.confirmSignUp:
        final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        _handleCodeDelivery(codeDeliveryDetails);
        break;
      case AuthSignUpStep.done:
        safePrint('Sign up is complete');
        break;
    }
  }

  void _handleCodeDelivery(AuthCodeDeliveryDetails codeDeliveryDetails) {
    safePrint(
      'A confirmation code has been sent to ${codeDeliveryDetails.destination}. '
          'Please check your ${codeDeliveryDetails.deliveryMedium.name} for the code.',
    );
  }

}