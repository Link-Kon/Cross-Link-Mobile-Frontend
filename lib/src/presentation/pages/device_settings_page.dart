import 'package:flutter/material.dart';

class DeviceSettingsPage extends StatefulWidget {
  const DeviceSettingsPage({super.key});
  @override
  State<DeviceSettingsPage> createState() => _DeviceSettingsPageState();
}

class _DeviceSettingsPageState extends State<DeviceSettingsPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cross Link"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: const Text("Device Settings Page"),
      ),
    );
  }
}