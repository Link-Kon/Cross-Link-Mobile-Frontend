import 'package:cross_link/src/config/router/routes.dart';
import 'package:cross_link/src/utils/constants/nums.dart';
import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';
import '../../utils/common_widgets/text_form_field_label_widget.dart';

class HealthcareSurveyPage extends StatelessWidget {
  HealthcareSurveyPage({super.key});

  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController illnessController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Healthcare Survey Page"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Palette.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultSize),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: formHeight-10),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormFieldLabelWidget(
                      controller: ageController, label: 'What is your age?',
                      validator: null,
                    ),
                    const SizedBox(height: defaultSize-5,),
                    TextFormFieldLabelWidget(
                      controller: weightController, label: 'What is your weight?',
                      validator: null,
                    ),
                    const SizedBox(height: defaultSize-5,),
                    TextFormFieldLabelWidget(
                      controller: heightController, label: 'What is your height?',
                      validator: null,
                    ),
                    const SizedBox(height: defaultSize-5,),
                    TextFormFieldLabelWidget(
                      controller: illnessController, label: 'Do you suffer any illness?',
                      validator: null,
                    ),
                    const SizedBox(height: defaultSize,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 60,
                      height: 55,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(context, Routes.HOME);
                          },
                          child: const Text("Sign Up",
                            style: TextStyle(color: Colors.white, fontSize: textButtonSize)
                          )
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