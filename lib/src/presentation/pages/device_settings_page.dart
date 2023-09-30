import 'package:cross_link/src/config/router/routes.dart';
import 'package:cross_link/src/utils/constants/nums.dart';
import 'package:flutter/material.dart';

import '../../utils/common_widgets/section_bold_text_widget.dart';
import '../../utils/common_widgets/section_text_widget.dart';
import '../../utils/common_widgets/text_form_field_widget.dart';

class DeviceSettingsPage extends StatefulWidget {
  const DeviceSettingsPage({super.key});
  @override
  State<DeviceSettingsPage> createState() => _DeviceSettingsPageState();
}

class _DeviceSettingsPageState extends State<DeviceSettingsPage>{

  final TextEditingController deviceNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Device Settings"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: defaultSize, right: 20, top: 15),
        child: ListView(
          children: <Widget>[
            const SectionBoldTextWidget(text: 'Rename'),
            const SizedBox(height: 5),
            const SectionTextWidget(text: 'Here you can change the name of your device'),
            const SizedBox(height: 10),
            TextFormFieldWidget(controller: deviceNameController, hintText: 'Device name'),
            const SizedBox(height: 30,),
            const SectionBoldTextWidget(text: 'Product features'),
            const SizedBox(height: 5),
            const SectionTextWidget(text: 'Here you can see which are the stored color messages and their meanings'),
            const SizedBox(height: 10,),
            DeviceButtonWidget(title: 'Color messages',
              onPress: () {},
            ),
            const SizedBox(height: 20,),
            const SectionTextWidget(text: 'Here you can see all the devices you have been connected'),
            const SizedBox(height: 10,),
            DeviceButtonWidget(title: 'Check your links',
              onPress: () {Navigator.pushNamed(context, Routes.DEVICE_LINKS);},
            ),
            const SizedBox(height: 30,),
            const SectionBoldTextWidget(text: 'Product info'),
            const SizedBox(height: 5),
            RichText(
              text: const TextSpan(
                text: 'Model: ',
                style: TextStyle(color: Color.fromRGBO(143,143,143,1), fontSize: 14.0, fontWeight: FontWeight.w600),
                children: <TextSpan>[
                  TextSpan(text: 'Link Elder', style: TextStyle(fontWeight: FontWeight.normal)),
                ],
              ),
            ),
            const SizedBox(height: 5),
            RichText(
              text: const TextSpan(
                text: 'Version: ',
                style: TextStyle(color: Color.fromRGBO(143,143,143,1), fontSize: 14.0, fontWeight: FontWeight.w600),
                children: <TextSpan>[
                  TextSpan(text: 'XX.YY.ZZ', style: TextStyle(fontWeight: FontWeight.normal)),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class DeviceButtonWidget extends StatelessWidget {
  const DeviceButtonWidget({
    super.key,
    required this.title,
    required this.onPress,
  });

  final String title;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
          side: BorderSide(color: Colors.grey.shade300)
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(6.0),
        onTap: onPress,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(title, style: const TextStyle(fontSize: 16, color: Colors.black),),
              Icon(Icons.arrow_forward, size: 20, color: Colors.grey.shade400,),
            ],
          ),
        ),
      ),
    );
  }
}