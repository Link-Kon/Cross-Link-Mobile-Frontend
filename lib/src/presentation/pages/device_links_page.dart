import 'package:flutter/material.dart';

class DeviceLinksPage extends StatefulWidget {
  const DeviceLinksPage({super.key});
  @override
  State<DeviceLinksPage> createState() => _DeviceLinksPageState();
}

class _DeviceLinksPageState extends State<DeviceLinksPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cross Link"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: const Text("Device Links Page"),
      ),
    );
  }
}