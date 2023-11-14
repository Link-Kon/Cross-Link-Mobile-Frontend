import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/themes/app_colors.dart';
import '../../domain/repositories/user_api_repository.dart';
import '../../locator.dart';
import '../../utils/common_widgets/text_form_field_label_widget.dart';
import '../cubits/user/user_cubit.dart';
import '../cubits/user/user_state.dart';
import '../cubits/user_links/user_links_cubit.dart';
import '../cubits/user_links/user_links_state.dart';

class AddUserWidget extends StatelessWidget {
  AddUserWidget({super.key, required this.userCode1});
  final String userCode1;

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final aCubit = UserCubit(
      locator<UserApiRepository>(),
    );
    final bCubit = BlocProvider.of<UserLinksCubit>(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<UserCubit, UserState>(
          listener: (context, state) {
            switch (state.runtimeType) {
              case UserLoading:
                debugPrint('searching user');
                break;

              case UserFailed:
                debugPrint('error searching user: ${state.error}');
                break;

              case UserGetSuccess:
                debugPrint('user found');
                String userCode2 = state.response!.userCode;
                print('userCode2: $userCode2');

                bCubit.addUserLink(apiKey: '', userCode: userCode1, user2Code: userCode2);

                break;
            }
          },
        ),
        BlocListener<UserLinksCubit, UserLinksState>(
          listener: (context, state) {
            switch (state.runtimeType) {
              case UserLinksLoading:
                debugPrint('adding user link');
                break;

              case UserLinksFailed:
                debugPrint('error adding user link: ${state.error}');
                break;

              case UserLinkAddSuccess:
                debugPrint('user link added');
                bCubit.getUserLinks(apiKey: '', userCode: userCode1);
                Navigator.pop(context);
                break;
            }
          },
        ),
      ],
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width,
          height: 180,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20,),
              const Text(
                "Add Cross Link account",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Palette.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15,),
              TextFormFieldLabelWidget(controller: emailController, label: 'Username', validator: emailValidator,),
              const SizedBox(height: 10,),
              TextButton(
                onPressed: () {
                  debugPrint("get user 2");
                  aCubit.getUser(username: emailController.text);
                  //_addUser(context, emailController.text);
                },
                style: TextButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width - 120, 40),
                  backgroundColor: Palette.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
                child: const Text("Add", style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
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

}