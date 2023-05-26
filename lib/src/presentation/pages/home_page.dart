import 'package:cross_link/src/config/router/routes.dart';
import 'package:cross_link/src/presentation/widgets/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text("Cross Link"),
        actions: [
          IconButton(
            onPressed: () {Navigator.pushNamed(context, Routes.DEVICE_SETTINGS);},
            icon: const Icon(Icons.device_hub_rounded)
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: const Text("Home Page"),
      ),
    );
  }
}