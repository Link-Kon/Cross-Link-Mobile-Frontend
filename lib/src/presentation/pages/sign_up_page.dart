import 'package:cross_link/src/config/router/routes.dart';
import 'package:cross_link/src/utils/constants/nums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/user/user_cubit.dart';
import '../cubits/user/user_state.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final aCubit = BlocProvider.of<UserCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("User Registration Page"),
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (_, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(defaultSize),
            child: Column(
              children: <Widget>[
                const Text("User Registration", style: TextStyle(fontSize: defaultTextSize), textAlign: TextAlign.center,),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: formHeight-10),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: usernameController,
                          decoration: const InputDecoration(
                            label: Text("Username"),
                            prefixIcon: Icon(Icons.person_outline_outlined),
                          ),
                        ),
                        const SizedBox(height: defaultSize-20,),
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            label: Text("E-mail"),
                            prefixIcon: Icon(Icons.person_outline_outlined),
                          ),
                        ),
                        const SizedBox(height: defaultSize-20,),
                        TextFormField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                            label: Text("Password"),
                            prefixIcon: Icon(Icons.person_outline_outlined),
                          ),
                        ),
                        const SizedBox(height: defaultSize-20,),
                        TextFormField(
                          controller: rePasswordController,
                          decoration: const InputDecoration(
                            label: Text("Re-Password"),
                            prefixIcon: Icon(Icons.person_outline_outlined),
                          ),
                        ),
                        const SizedBox(height: defaultSize-10,),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                createUser(context, aCubit);
                                //Navigator.pushNamed(context, Routes.HEALTHCARE_SURVEY);
                              },
                              child: const Text("Sign Up")
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      )
    );
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

}