import 'package:cross_link/src/config/router/routes.dart';
import 'package:cross_link/src/presentation/widgets/sign_in_widget.dart';
import 'package:flutter/material.dart';

class SignUpWidget extends StatelessWidget {
  const SignUpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height/2.5,
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 20,),
            const Text(
              "Create your account",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15,),
            const Text(
              "Your personal account with your healthcare information",
              style: TextStyle(
                fontSize: 18,
              )
            ),
            const Text(
              "The best personalized experience",
              style: TextStyle(
                fontSize: 18,
              )
            ),
            const Text(
              "Exclusive update and notices",
              style: TextStyle(
                fontSize: 18,
              )
            ),
            const SizedBox(height: 30,),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, Routes.USER_REGISTRATION);
                },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              child: const Text("Sign up with email", style: TextStyle(color: Colors.white),),
            ),
            const SizedBox(height: 20,),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: <Widget>[
                const Text(
                  "Already have an account?",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () {
                      Navigator.pop(context);
                      showDialog(context: context, builder: (BuildContext context) => SignInWidget());
                    },
                  child: const Text("Sign in",
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