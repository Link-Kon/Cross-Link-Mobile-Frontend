import 'package:cross_link/src/config/router/routes.dart';
import 'package:cross_link/src/utils/constants/nums.dart';
import 'package:cross_link/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePage();
}

class _UpdateProfilePage extends State<UpdateProfilePage> {

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const Image(image: AssetImage(defaultProfileImage)),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.blue.withOpacity(0.1),
                      ),
                      child: const Icon(Icons.camera_alt_rounded, size: 18, color: Colors.black,),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 50,),
              Form(
                child: Column(
                  children: <Widget>[
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
                    const SizedBox(height: defaultSize,),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(context, Routes.PROFILE);
                          },
                          child: const Text('Edit Profile')
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}