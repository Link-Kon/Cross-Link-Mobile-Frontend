import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cross_link/src/presentation/widgets/sign_up_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../config/themes/app_colors.dart';
import '../../utils/common_widgets/text_form_field_label_widget.dart';
import '../../utils/constants/nums.dart';
import '../../utils/constants/strings.dart';
import '../../utils/functions/auth_service.dart';
import '../../utils/functions/aws_functions.dart';
import '../cubits/user/user_cubit.dart';
import '../cubits/user/user_state.dart';
import '../cubits/user_data/user_data_cubit.dart';
import '../cubits/user_data/user_data_state.dart';

class SignInWidget extends StatelessWidget {
  SignInWidget({super.key, required this.deviceToken});
  final String deviceToken;
  late final User? user;


  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(deviceToken);
    final aCubit = BlocProvider.of<UserCubit>(context);
    final udCubit = BlocProvider.of<UserDataCubit>(context);
    bool createUserData = false;

    return MultiBlocListener(
      listeners: [
        BlocListener<UserCubit, UserState>(
          listener: (context, state) {
            switch (state.runtimeType) {
              case UserLoading:
                debugPrint(createUserData? 'adding user' : 'finding user');
                break;

              case UserFailed:
                debugPrint('ERROR finding user: ${state.error}');

                if (!createUserData) {
                  if (state.error!.message!.contains('400')) {
                    createUserData = true;
                    String token = '2A35F7F7BB15490EF65DC621773C3FA3F3185471ABCF5F20D1CFAD95D9C1A3386380048E70FEAB82AE3'
                        'E9EB095E9A9781AD8DDD4572DBDFDA27742BB7D9C1C9136B5E325D9EB13A3A32823713E5B5CFCBAE1AC7323290EEF9'
                        'F7F64A7D62F7BAE562A330A9305D3929F7B3F1B2CE7C97DCEDC2C47DDA04C870D43E6F814E623EFA492866CD3E5EF1'
                        '530E007BF86090BBDC3EAA2A61F2F020CCE5F3D7892775BEBB6CBBE4530F1C6CA4967F5471A62BF2CF7393D1E90419'
                        '4EFD039548B1FED9F410019CF9930305F0A0AEF1F6959DCF11A3A85676EAB75E2944891F50FAC29D6442838A29FF4E'
                        '8AEF2066B6F91FCFE410464863973236876460115588C6C3FED76C989193CCABC9E75CE8939CEA52FC5DE320FE9A50'
                        '2C19EC590C8ECA7DC8542BB582C139E3FC69C1A612EDDFEE4EEED2442B95BC705736F207E3CF1960AC9EC484EC6DC5'
                        'B202E33F23683AD7549518AF02914DC526105095DDB2A2A572D6200B4';

                    debugPrint('adding user');
                    aCubit.addUser(
                        username: user!.displayName!,
                        deviceToken: deviceToken,
                        token: token
                    );
                  }
                }
                break;

              case UserSuccess:
                debugPrint('user created');
                String userCode = state.response!.userCode;
                debugPrint('userCode: $userCode');
                udCubit.addUserData(email: user!.email!, name: user!.displayName!,
                    lastname: '', photoUrl: '', userCode: userCode
                );

                Navigator.pop(context);
                break;

              case UserGetSuccess:
                debugPrint('user found');
                createUserData = false;
                udCubit.getUserData(userCode: state.response!.userCode);

                Navigator.pop(context);
                break;
            }
          },
        ),
        BlocListener<UserDataCubit, UserDataState>(
          listener: (context, state) {
            switch (state.runtimeType) {
              case UserDataLoading:
                debugPrint(createUserData? 'adding user data' : 'getting user data');
                break;

              case UserDataFailed:
                debugPrint('error adding user data: ${state.error}');
                break;

              case UserDataSuccess:
                if (createUserData) {
                  debugPrint('user data added');
                  udCubit.getUserData(userCode: state.response!.code!);
                } else {
                  debugPrint('get user data');
                }

                Navigator.pop(context);
                break;
            }
          },
        ),
      ],
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 480,
          child: Column(
            children: [
              Container(
                height: 100,
                decoration: const BoxDecoration(
                  color: Palette.splashColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
                ),
                child: Center(child: SvgPicture.asset(logoImage, height: 50, width: 50)),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const Text("Enter to Cross Link",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 15,),
                    TextFormFieldLabelWidget(controller: emailController, label: 'Username', validator: null,),
                    const SizedBox(height: 15,),
                    TextFormFieldLabelWidget(controller: passwordController, label: 'Password', hideText: true, validator: null,),
                    const SizedBox(height: 15,),

                    TextButton(
                      onPressed: () async {
                        debugPrint("sign in");
                        await signInUser(emailController.text, passwordController.text);
                        AuthUser user = await getCurrentUser();
                        print(user.userId);
                        await printAccessToken();

                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                      style: TextButton.styleFrom(
                        minimumSize: Size(MediaQuery.of(context).size.width - 120, 40),
                        backgroundColor: Palette.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                      child: const Text("Sign in", style: TextStyle(color: Colors.white, fontSize: textButtonSize),),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        AuthService().signInWithGoogle().then((value) {
                          user = FirebaseAuth.instance.currentUser;
                          aCubit.getUser(username: user!.displayName!);
                        });
                      },
                      style: TextButton.styleFrom(
                        minimumSize: Size(MediaQuery.of(context).size.width - 120, 40),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                      child: const Text("Sign in with Google", style: TextStyle(color: Palette.primaryColor, fontSize: textButtonSize),),
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(fontSize: 16, color: Color.fromRGBO(133,133,133,1),)
                        ),
                        TextButton(
                          onPressed: () { //TODO: juntar textos
                              Navigator.pop(context);
                              showDialog(context: context, builder: (BuildContext context) => SignUpWidget(token: deviceToken,));
                            },
                          child: const Text("Sign up", style: TextStyle(color: Palette.textSelected, fontSize: 16),),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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

}