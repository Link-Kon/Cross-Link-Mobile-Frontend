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
              onPressed: () {print("sign up");},
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

}