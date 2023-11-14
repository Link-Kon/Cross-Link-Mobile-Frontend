import 'package:cross_link/src/config/router/routes.dart';
import 'package:cross_link/src/utils/constants/nums.dart';
import 'package:cross_link/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/themes/app_colors.dart';
import '../../utils/common_widgets/text_form_field_label_widget.dart';

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
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Palette.black,
        elevation: 0,
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
                      child: SvgPicture.asset(defaultProfileImage),
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
                    TextFormFieldLabelWidget(
                      controller: usernameController, label: 'Username',
                      validator: null,
                    ),
                    const SizedBox(height: 10,),
                    TextFormFieldLabelWidget(
                      controller: emailController, label: 'E-mail',
                      validator: null,
                    ),
                    const SizedBox(height: 10,),
                    TextFormFieldLabelWidget(
                      controller: passwordController, label: 'Password',
                      validator: null,
                    ),
                    const SizedBox(height: defaultSize,),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(context, Routes.PROFILE);
                          },
                          child: const Text('Update Profile', style: TextStyle(color: Colors.white),)
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