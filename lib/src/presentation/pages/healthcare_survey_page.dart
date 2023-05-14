import 'package:cross_link/src/config/router/routes.dart';
import 'package:cross_link/src/utils/constants/nums.dart';
import 'package:flutter/material.dart';

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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultSize),
        child: Column(
          children: <Widget>[
            const Text("Healthcare Survey Page", style: TextStyle(fontSize: defaultTextSize), textAlign: TextAlign.center,),
            Container(
              padding: const EdgeInsets.symmetric(vertical: formHeight-10),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: defaultSize-5,),
                    const Text("What is your age"),
                    TextFormField(
                      controller: ageController,
                    ),
                    const SizedBox(height: defaultSize-5,),
                    const Text("What is your weight"),
                    TextFormField(
                      controller: weightController,
                    ),
                    const SizedBox(height: defaultSize-5,),
                    const Text("What is your height"),
                    TextFormField(
                      controller: heightController,
                    ),
                    const SizedBox(height: defaultSize-5,),
                    const Text("Do you suffer any illness"),
                    TextFormField(
                      controller: illnessController,
                    ),
                    const SizedBox(height: defaultSize-10,),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(context, Routes.HOME);
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