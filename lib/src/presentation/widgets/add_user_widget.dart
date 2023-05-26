import 'package:flutter/material.dart';

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
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
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
                hintStyle: TextStyle(
                    color: Colors.grey, fontSize: 14),
              ),
            ),
            const SizedBox(height: 30,),
            TextButton(
              onPressed: () {
                debugPrint("Add user");
                Navigator.pop(context);
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

}