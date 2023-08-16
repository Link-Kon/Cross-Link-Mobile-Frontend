import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        height: 200,
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 20,),
            const Text(
              "Add link account",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500,),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15,),
            TextFormField(
              controller: emailController,
              style: const TextStyle(
                fontSize: 18,
              ),
              decoration: const InputDecoration(
                hintText: 'E-mail',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
            const SizedBox(height: 30,),
            TextButton(
              onPressed: () {
                debugPrint("Add user");
                //Navigator.pop(context);
                _addUser(context, emailController.text);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              child: const Text("Add", style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
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