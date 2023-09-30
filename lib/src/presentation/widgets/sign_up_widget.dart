import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cross_link/src/config/router/routes.dart';
import 'package:cross_link/src/presentation/widgets/sign_in_widget.dart';
import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';
import '../../utils/constants/nums.dart';
import '../../utils/constants/strings.dart';

class SignUpWidget extends StatelessWidget {
  const SignUpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 330,
        child: Column(
          children: <Widget>[
            Container(
              height: 100,
              decoration: const BoxDecoration(
                color: Palette.splashColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
              ),
              child: Center(child: Image.asset(logoImage, height: 50, width: 50)),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const Text(
                    "Create your account",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Access your personal Healthcare information and get the best experience. One Cross Link at a time",
                    style: TextStyle(fontSize: 16, color: Color.fromRGBO(133,133,133,1),),
                    textAlign: TextAlign.center,
                  ), //TODO:disminuir un poco la altura
                  /*const Text(
                    " - The best personalized experience.",
                    style: TextStyle(fontSize: 16, color: Color.fromRGBO(133,133,133,1),)
                  ),
                  const Text(
                    " - Exclusive update and notices.",
                    style: TextStyle(fontSize: 16, color: Color.fromRGBO(133,133,133,1),)
                  ),*/
                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Routes.SIGN_UP);
                    },
                    style: TextButton.styleFrom(
                      minimumSize: Size(MediaQuery.of(context).size.width - 120, 40),
                      backgroundColor: Palette.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                    child: const Text("Sign up with email", style: TextStyle(color: Colors.white, fontSize: textButtonSize),),
                  ),
                  /*const SizedBox(height: 10),
                  RichText(
                    text: const TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(fontSize: 16, color: Color.fromRGBO(133,133,133,1)),
                      children: <TextSpan>[
                        TextSpan(text: 'Login', style: TextStyle(color: Palette.textSelected, fontSize: 16)),
                      ],
                    ),
                  ),*/
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Already have an account?",
                        style: TextStyle(fontSize: 16, color: Color.fromRGBO(133,133,133,1),)
                      ),
                      TextButton( //TODO: juntar textos
                        onPressed: () async {
                          print('sign up before');
                          //await signUpUser(username: 'user1', password: 'Pa12345678#', email: 'patrickortizlaura@gmail.com');
                          Navigator.pop(context);
                          showDialog(context: context, builder: (BuildContext context) => SignInWidget());
                        },
                        child: const Text("Login", style: TextStyle(color: Palette.textSelected, fontSize: 16),),
                      ),
                    ],
                  ),
                ],
              ),
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