import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cross_link/src/data/datasources/remote/user_api_service.dart';
import 'package:cross_link/src/presentation/widgets/sign_up_widget.dart';
import 'package:flutter/material.dart';

class SignInWidget extends StatelessWidget {
  SignInWidget({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: MediaQuery.of(context).size.width,
        height: 340,
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 20,),
            const Text(
              "Enter your credentials",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15,),
            TextFormField(
              controller: usernameController,
              style: const TextStyle(
                fontSize: 18,
              ),
              decoration: const InputDecoration(
                hintText: 'Username',
                hintStyle: TextStyle(
                    color: Colors.grey, fontSize: 14),
              ),
            ),
            const SizedBox(height: 15,),
            TextFormField(
              controller: usernameController,
              style: const TextStyle(
                fontSize: 18,
              ),
              decoration: const InputDecoration(
                //labelStyle: TextStyle(color: Colors.red, fontSize: 16.0),
                hintText: 'Password',
                hintStyle: TextStyle(
                    color: Colors.grey, fontSize: 14),
              ),
            ),
            const SizedBox(height: 30,),
            TextButton(
              onPressed: () async {
                print("sign in");
                await signInUser('user1', 'Pa12345678#');
                print('currente user');
                AuthUser user = await getCurrentUser();
                print('currente userID: ${user.userId}');
                print('currente username: ${user.username}');
                print('currente user: ${user.signInDetails}');

                await printAccessToken();
                /*Auth.currentSession().then(res=>{
                let accessToken = res.getAccessToken()
                let jwt = accessToken.getJwtToken()

                //You can print them to see the full objects
                console.log(`myAccessToken: ${JSON.stringify(accessToken)}`)
                console.log(`myJwt: ${jwt}`)
                })*/
                //await signOutCurrentUser();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              child: const Text("Sign in", style: TextStyle(color: Colors.white),),
            ),
            const SizedBox(height: 20,),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: <Widget>[
                const Text(
                  "Don't have an account?",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () {
                      Navigator.pop(context);
                      showDialog(context: context, builder: (BuildContext context) => const SignUpWidget());
                    },
                  child: const Text("Sign up",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }

  Future<void> signOutCurrentUser() async {
    final result = await Amplify.Auth.signOut();
    if (result is CognitoCompleteSignOut) {
      safePrint('Sign out completed successfully');
    } else if (result is CognitoFailedSignOut) {
      safePrint('Error signing user out: ${result.exception.message}');
    }
  }

  Future<void> printAccessToken() async {
    try {
      final cognitoPlugin = Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
      final result = await cognitoPlugin.fetchAuthSession();
      final accessToken = result.userPoolTokensResult.value;
      safePrint("Access token: ${accessToken.accessToken}");
    } on AuthException catch (e) {
      safePrint('Error retrieving access token: ${e.message}');
    }
  }

  Future<void> fetchAuthSession() async {
    try {
      final result = await Amplify.Auth.fetchAuthSession();
      safePrint('User is signed in: ${result.isSignedIn}');
    } on AuthException catch (e) {
      safePrint('Error retrieving auth session: ${e.message}');
    }
  }

  Future<AuthUser> getCurrentUser() async {
    final user = await Amplify.Auth.getCurrentUser();
    return user;
  }

  Future<void> signInUser(String username, String password) async {
    try {
      final result = await Amplify.Auth.signIn(
        username: username,
        password: password,
      );
      await _handleSignInResult(result);
    } on AuthException catch (e) {
      safePrint('Error signing in: ${e.message}');
    }
  }

  Future<void> _handleSignInResult(SignInResult result) async {
    switch (result.nextStep.signInStep) {
      case AuthSignInStep.confirmSignInWithSmsMfaCode:
        final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        _handleCodeDelivery(codeDeliveryDetails);
        break;
      case AuthSignInStep.confirmSignInWithNewPassword:
        safePrint('Enter a new password to continue signing in');
        break;
      case AuthSignInStep.confirmSignInWithCustomChallenge:
        final parameters = result.nextStep.additionalInfo;
        final prompt = parameters['prompt']!;
        safePrint(prompt);
        break;
      /*case AuthSignInStep.resetPassword:
        final resetResult = await Amplify.Auth.resetPassword(
          username: username,
        );
        await _handleResetPasswordResult(resetResult);
        break;*/
      /*case AuthSignInStep.confirmSignUp:
      // Resend the sign up code to the registered device.
        final resendResult = await Amplify.Auth.resendSignUpCode(
          username: username,
        );
        _handleCodeDelivery(resendResult.codeDeliveryDetails);
        break;*/
      case AuthSignInStep.done:
        safePrint('Sign in is complete');
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