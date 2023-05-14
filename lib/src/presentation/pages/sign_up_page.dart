import 'package:cross_link/src/config/router/routes.dart';
import 'package:cross_link/src/utils/constants/nums.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Registration Page"),
      ),
      body: SingleChildScrollView(
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
                            Navigator.pushNamed(context, Routes.HEALTHCARE_SURVEY);
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
      ),
    );
  }
}