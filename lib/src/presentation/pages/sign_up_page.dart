import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cross_link/src/config/router/routes.dart';
import 'package:cross_link/src/utils/constants/nums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/themes/app_colors.dart';
import '../../utils/common_widgets/section_bold_text_widget.dart';
import '../../utils/common_widgets/text_form_field_label_widget.dart';
import '../../utils/functions/aws_functions.dart';
import '../cubits/user/user_cubit.dart';
import '../cubits/user/user_state.dart';
import '../cubits/user_data/user_data_cubit.dart';
import '../cubits/user_data/user_data_state.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool send = false;

  @override
  void initState() {
    // TODO: delete after test
    usernameController.text = 'Patrick';
    emailController.text = 'patrickortizlaura@gmail.com';
    passwordController.text = '123456Pa@';
    rePasswordController.text = '123456Pa@';


    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    codeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final aCubit = BlocProvider.of<UserCubit>(context);
    final udCubit = BlocProvider.of<UserDataCubit>(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<UserCubit, UserState>(
          listener: (context, state) {
            switch (state.runtimeType) {
              case UserLoading:
                debugPrint('adding user');
                break;

              case UserFailed:
                debugPrint('error adding user: ${state.error}');
                break;

              case UserSuccess:
                debugPrint('user added');
                String userCode = state.response!.userCode;

                udCubit.addUserData(email: emailController.text, name: usernameController.text,
                    lastname: '', photoUrl: '', userCode: userCode
                );
                break;
            }
          },
        ),
        BlocListener<UserDataCubit, UserDataState>(
          listener: (context, state) {
            switch (state.runtimeType) {
              case UserDataLoading:
                debugPrint('adding user data');
                break;

              case UserDataFailed:
                debugPrint('error adding user data: ${state.error}');
                break;

              case UserDataSuccess:
                debugPrint('user data added');
                udCubit.getUserData(userCode: state.response!.code!);
                Navigator.popAndPushNamed(context, Routes.HEALTHCARE_SURVEY);
                break;
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Registration"),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Palette.black,
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(defaultSize),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: formHeight-10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormFieldLabelWidget(
                          controller: usernameController, label: 'Username',
                          validator: usernameValidator, enable: !send,
                        ),
                        const SizedBox(height: defaultSize-20,),
                        TextFormFieldLabelWidget(
                          controller: emailController, label: 'E-mail',
                          validator: emailValidator, enable: !send,
                        ),
                        const SizedBox(height: defaultSize-20,),
                        TextFormFieldLabelWidget(
                          controller: passwordController, label: 'Password',
                          validator: passwordValidator, enable: !send, hideText: true,
                        ),
                        const SizedBox(height: defaultSize-20,),
                        TextFormFieldLabelWidget(
                          controller: rePasswordController, label: 'Re-Password',
                          validator: rePasswordValidator, enable: !send, hideText: true,
                        ),
                        const SizedBox(height: defaultSize,),
                        send? Column(
                          children: [
                            const SectionBoldTextWidget(text: 'Enter the code sent to your email'),
                            const SizedBox(height: 10),
                            TextFormFieldLabelWidget(
                              controller: codeController, label: 'Code',
                              validator: null, textLength: 6,
                            )
                          ],
                        ) : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 60,
              height: 55,
              padding: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Form submitted successfully'),
                      ));

                      if (send) {
                        await confirmUser(
                          username: usernameController.text,
                          confirmationCode: codeController.text,
                        ).then((value) async {

                          String token = 'df46e24578ddf6c6282dc999e8458532f3f0d9a146442420fb07dfe5568c584c1e452362e166893b4e3bf838d03f6f65af852be6f4b436'
                              'e3d3dd1d2f6f5f243ec8e2594ec8905f2bfb37fbcf468dc0cf6d558bb99ead95cd6b0bb56dab2e406478912f24c2d5d9fd6a0c784dae1f396505e8f44efaea48144'
                              'c68f8cc510b6a8d37eea1619a5cb01a8a487d36b39d9cf14319264747ef3ace814673f7d77866a4a6c5e7a84f87d154c74e49e65755da8f36b7a470e8d6dceaeb1d3855ffd919'
                              'd403dcb545a70c878b151fab4bf1907ed70b25fc4134eae8a5eb1de9e22f503b596dab9b98d810eaadfb9843a68a1daebd1e8acd178c901513fda940b963da26ec1163418e1bab8beb13c'
                              '85f19f83c057c56eaec64206fbca4d0878eda33ca75f58d3df126d5ef391743d5acd7ca92e9c623397073648a7205b4dc28b4d98257cdebb9874bb38ed1b6ca93f6b1cf86cc7e7e760643c8025'
                              'f625b29bd8db382ef58';

                          /*await signInUser(usernameController.text, passwordController.text)
                              .then((value) => aCubit.addUser(
                              username: usernameController.text,
                              userCode: 'code_${usernameController.text}',
                              token: token)
                          );*/
                        });

                      } else {
                        await signUpUser(
                            username: usernameController.text,
                            password: passwordController.text,
                            email: emailController.text
                        ).then((value) {
                          setState(() {});
                        });
                      }

                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Por favor corrija los errores del formulario'),
                      ));
                    }
                  },
                  child: Text(send? 'Send Code' : 'Sign Up',
                    style: const TextStyle(color: Colors.white, fontSize: textButtonSize),
                  )
              ),
            ),
          ],
        )
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
      await _handleSignUpResult(result).then((value) => send = true);
    } on AuthException catch (e) {
      safePrint('Error signing up user: ${e.message}');
      alertMessage(context, title: 'Error', content: e.message, button: 'Ok');
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
    alertMessage(context,
      title: 'Notification',
      content:'A confirmation code has been sent to ${codeDeliveryDetails.destination}. '
      'Please check your ${codeDeliveryDetails.deliveryMedium.name} for the code.',
      button: 'Ok'
    );
    safePrint(
      'A confirmation code has been sent to ${codeDeliveryDetails.destination}. '
          'Please check your ${codeDeliveryDetails.deliveryMedium.name} for the code.',
    );
    setState(() {});
  }

  void alertMessage(BuildContext context,
      {required String title,
        required String button,
        required String content,
        double height = 200,
        double width = 300,
        bool isError = false}) {

    Dialog fancyDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        height: height,
        width: width,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white, //TODO: change color
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.bottomCenter,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: TextStyle(
                      color: isError? Palette.error : Palette.primaryColor, //Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Container(margin: const EdgeInsets.all(20.0),
              height: 285,
              width: 300,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  content,
                  //textAlign: TextAlign.center,
                  style: const TextStyle( color: Color(0xFF909090),fontSize: 15.0, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),//bottomRight: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Align(
                      alignment: Alignment.center,
                      child:  OutlinedButton(
                        style: ElevatedButton.styleFrom(
                            side: const BorderSide(width: 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: Text(button, style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => fancyDialog, barrierDismissible: false);
  }



  String? usernameValidator(String? value) {
    if (value!.isEmpty) {
      return 'Please enter an username';
    }
    return null;
  }

  String? emailValidator(String? value) {
    const pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    final regex = RegExp(pattern);

    if (value!.isEmpty) {
      return 'Please enter an email';

    } else if (!regex.hasMatch(emailController.text)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  String? rePasswordValidator(String? value) {
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

}