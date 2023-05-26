import 'package:cross_link/src/config/router/routes.dart';
import 'package:cross_link/src/utils/constants/nums.dart';
import 'package:flutter/material.dart';

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
      ),
      body: Container(
        padding: const EdgeInsets.all(defaultSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Rename your link', style: Theme.of(context).textTheme.titleMedium,),
            Text('Here you can change the name of your device', style: Theme.of(context).textTheme.bodyMedium,),
            const SizedBox(height: 10,),
            TextFormField(
              controller: deviceNameController,
              style: const TextStyle(
                fontSize: 18,
              ),
              decoration: const InputDecoration(
                hintText: 'Device name',
                hintStyle: TextStyle(
                    color: Colors.grey, fontSize: 14),
              ),
            ),
            const SizedBox(height: 30,),
            Text('Product features', style: Theme.of(context).textTheme.titleMedium,),
            Text('Here you can see which are the stored color messages and their meanings',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 10,),
            DeviceButtonWidget(title: 'Color messages',
              onPress: () {},
            ),
            const SizedBox(height: 30,),
            Text('Product features', style: Theme.of(context).textTheme.titleMedium,),
            Text('Here you can see all the devices you have been connected',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 10,),
            DeviceButtonWidget(title: 'Check your links',
              onPress: () {Navigator.pushNamed(context, Routes.DEVICE_LINKS);},
            ),
            const SizedBox(height: 30,),
            Text('Product info', style: Theme.of(context).textTheme.titleMedium,),
            Text('Model: Link Elder', style: Theme.of(context).textTheme.bodyMedium,),
            Text('Version: XX.YY.ZZ', style: Theme.of(context).textTheme.bodyMedium,),
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
      borderRadius: BorderRadius.circular(5.0),
      color: Colors.blue,
      child: InkWell(
        onTap: onPress,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(title, style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),),
              const Icon(Icons.arrow_forward, size: 18, color: Colors.black,),
            ],
          ),
        ),
      ),
    );
  }
}