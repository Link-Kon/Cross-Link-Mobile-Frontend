import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cross_link/src/config/router/routes.dart';
import 'package:cross_link/src/utils/constants/nums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/themes/app_colors.dart';
import '../../utils/common_widgets/section_bold_text_widget.dart';
import '../../utils/common_widgets/text_form_field_label_widget.dart';
import '../cubits/user/user_cubit.dart';
import '../cubits/user/user_state.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Palette.black,
        elevation: 0,
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (_, state) {
          return Column(
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
                            validator: passwordValidator, enable: !send,
                          ),
                          const SizedBox(height: defaultSize-20,),
                          TextFormFieldLabelWidget(
                            controller: rePasswordController, label: 'Re-Password',
                            validator: rePasswordValidator, enable: !send,
                          ),
                          const SizedBox(height: defaultSize-10,),
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
                          content: Text('Formulario enviado con éxito'),
                        ));

                        if (send) {
                          await confirmUser(
                            username: usernameController.text,
                            confirmationCode: codeController.text,
                          ).then((value) {
                            debugPrint('value 2');
                            createUser(context, aCubit);
                            Navigator.pushNamed(context, Routes.HEALTHCARE_SURVEY);
                          });

                        } else {
                          await signUpUser(
                              username: usernameController.text,
                              password: passwordController.text,
                              email: emailController.text
                          ).then((value) {
                            debugPrint('value');
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
          );
        },
      )
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
      title: 'Error',
      content:'A confirmation code has been sent to ${codeDeliveryDetails.destination}. '
      'Please check your ${codeDeliveryDetails.deliveryMedium.name} for the code.',
      button: 'Ok'
    );
    safePrint(
      'A confirmation code has been sent to ${codeDeliveryDetails.destination}. '
          'Please check your ${codeDeliveryDetails.deliveryMedium.name} for the code.',
    );
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
                color: Colors.white,
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
                  style: const TextStyle(
                      color: Colors.white,
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
    showDialog(context: context, builder: (BuildContext context) => fancyDialog,barrierDismissible: false);
  }



  void createUser(BuildContext context, UserCubit aCubit) {
    String token = 'df46e24578ddf6c6282dc999e8458532f3f0d9a146442420fb07dfe5568c584c1e452362e166893b4e3bf838d03f6f65af852be6f4b436'
        'e3d3dd1d2f6f5f243ec8e2594ec8905f2bfb37fbcf468dc0cf6d558bb99ead95cd6b0bb56dab2e406478912f24c2d5d9fd6a0c784dae1f396505e8f44efaea48144'
        'c68f8cc510b6a8d37eea1619a5cb01a8a487d36b39d9cf14319264747ef3ace814673f7d77866a4a6c5e7a84f87d154c74e49e65755da8f36b7a470e8d6dceaeb1d3855ffd919'
        'd403dcb545a70c878b151fab4bf1907ed70b25fc4134eae8a5eb1de9e22f503b596dab9b98d810eaadfb9843a68a1daebd1e8acd178c901513fda940b963da26ec1163418e1bab8beb13c'
        '85f19f83c057c56eaec64206fbca4d0878eda33ca75f58d3df126d5ef391743d5acd7ca92e9c623397073648a7205b4dc28b4d98257cdebb9874bb38ed1b6ca93f6b1cf86cc7e7e760643c8025'
        'f625b29bd8db382ef58';

    aCubit.addUser(username: 'user6', userCode: 'user6code', token: token);

    switch (context.read<UserCubit>().state.runtimeType) {
      case UserLoading:
        debugPrint('adding user');
        break;
      case UserFailed:
        debugPrint('error adding user');
        break;
      case UserSuccess:
        debugPrint('user added');
        break;
      default:
        debugPrint('default action');
        break;
    }
  }


  String? usernameValidator(String? value) {
    if (value!.isEmpty) {
      return 'Por favor ingrese un nombre';
    }
    return null;
  }

  String? emailValidator(String? value) {
    const pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    final regex = RegExp(pattern);

    if (value!.isEmpty) {
      return 'Por favor ingrese un correo';

    } else if (!regex.hasMatch(emailController.text)) {
      return 'Por favor ingrese un correo válido';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return 'Por favor ingrese una contraseña';
    }
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 8 caracteres';
    }
    return null;
  }

  String? rePasswordValidator(String? value) {
    if (value != passwordController.text) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }

}