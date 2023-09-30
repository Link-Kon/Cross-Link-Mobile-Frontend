import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/themes/app_colors.dart';
import '../../utils/common_widgets/text_form_field_label_widget.dart';
import '../cubits/user_links/user_links_cubit.dart';
import '../cubits/user_links/user_links_state.dart';

class AddUserWidget extends StatelessWidget {
  AddUserWidget({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
            TextFormFieldLabelWidget(controller: emailController, label: 'E-mail', validator: emailValidator,),
            const SizedBox(height: 10,),
            TextButton(
              onPressed: () {
                debugPrint("Add user");
                Navigator.pop(context);
                _addUser(context, emailController.text);
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

  void _addUser(BuildContext context, String user2code) {
    context.read<UserLinksCubit>().addUserLink(apiKey: '', userCode: 'user1code', user2Code: user2code);

    switch (context.read<UserLinksCubit>().state.runtimeType) {
      case UserLinksLoading:
        debugPrint('adding user');
        break;
      case UserLinksFailed:
        debugPrint('error adding user: ${context.read<UserLinksCubit>().state.error}');
        break;
      case UserLinksSuccess:
        debugPrint('response: ${context.read<UserLinksCubit>().state.userLinks}');
        break;
      default:
        debugPrint('default action');
        break;
    }
  }


}