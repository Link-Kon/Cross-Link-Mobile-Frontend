import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

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

Future<void> confirmUser({
  required String username,
  required String confirmationCode,
}) async {
  try {
    final result = await Amplify.Auth.confirmSignUp(
      username: username,
      confirmationCode: confirmationCode,
    );
    // Check if further confirmations are needed or if
    // the sign up is complete.
    await _handleSignUpResult(result);
  } on AuthException catch (e) {
    safePrint('Error confirming user: ${e.message}');
  }
}

void _handleCodeDelivery(AuthCodeDeliveryDetails codeDeliveryDetails) {
  safePrint(
    'A confirmation code has been sent to ${codeDeliveryDetails.destination}. '
        'Please check your ${codeDeliveryDetails.deliveryMedium.name} for the code.',
  );
}

Future<bool> signInUser(String username, String password) async {
  try {
    final result = await Amplify.Auth.signIn(
      username: username,
      password: password,
    );
    await _handleSignInResult(result, username);
    return true;
  } on AuthException catch (e) {
    safePrint('Error signing in: ${e.message}');
    return false;
  }
}

Future<void> _handleSignInResult(SignInResult result, String username) async {
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
    case AuthSignInStep.resetPassword:
      final resetResult = await Amplify.Auth.resetPassword(
        username: username,
      );
      await _handleResetPasswordResult(resetResult);
      break;
    case AuthSignInStep.confirmSignUp:
    // Resend the sign up code to the registered device.
      final resendResult = await Amplify.Auth.resendSignUpCode(
        username: username,
      );
      _handleCodeDelivery(resendResult.codeDeliveryDetails);
      break;
    case AuthSignInStep.done:
      safePrint('Sign in is complete');
      break;
  }
}

Future<void> _handleResetPasswordResult(ResetPasswordResult result) async {
  switch (result.nextStep.updateStep) {
    case AuthResetPasswordStep.confirmResetPasswordWithCode:
      final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
      _handleCodeDelivery(codeDeliveryDetails);
      break;
    case AuthResetPasswordStep.done:
      safePrint('Successfully reset password');
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

Future<void> signOutCurrentUser() async {
  final result = await Amplify.Auth.signOut();
  if (result is CognitoCompleteSignOut) {
    safePrint('Sign out completed successfully');
  } else if (result is CognitoFailedSignOut) {
    safePrint('Error signing user out: ${result.exception.message}');
  }
}