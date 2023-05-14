import 'package:cross_link/src/config/router/routes.dart';
import 'package:cross_link/src/presentation/widgets/sign_up_widget.dart';
import 'package:flutter/material.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({super.key});

  final padding = const EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.lightBlue,
        child: ListView(
          padding: padding,
          children: <Widget>[
            const DrawerHeader(
              child: Icon(Icons.watch_rounded, size: 60,),
            ),
            buildMenuItem(
              text: 'Profile',
              icon: Icons.person,
              onClicked: () => selectedItem(context, 0),
            ),
            buildMenuItem(
              text: 'Sign up / Sign in',
              icon: Icons.person,
              onClicked: () => selectedItem(context, 1),
            ),
            const Divider(color: Colors.white, thickness: 1,),
            buildMenuItem(
              text: 'Summary',
              icon: Icons.monitor_heart_rounded,
              onClicked: () => selectedItem(context, 2),
            ),
            buildMenuItem(
              text: 'Links',
              icon: Icons.people,
              onClicked: () => selectedItem(context, 3),
            ),
            buildMenuItem(
              text: 'Product Help',
              icon: Icons.help,
              onClicked: () => selectedItem(context, 4),
            ),
            buildMenuItem(
              text: 'Privacy Policy',
              icon: Icons.file_open,
              onClicked: () => selectedItem(context, 5),
            ),
            const Divider(color: Colors.white, thickness: 1,),
            buildMenuItem(
              text: 'Log out',
              icon: Icons.person,
              onClicked: () => selectedItem(context, 6),
            ),
          ],
        )
      ),
    );
  }

  Widget buildMenuItem({required String text, required IconData icon, VoidCallback? onClicked}) {
    // ignore: prefer_const_declarations
    final color = Colors.white;
    // ignore: prefer_const_declarations
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color,),
      title: Text(text, style: TextStyle(color: color),),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, Routes.PROFILE);
        break;
      case 1:
        showDialog(context: context, builder: (BuildContext context) => const SignUpWidget());
        break;
      case 2:
        Navigator.pushNamed(context, Routes.SUMMARY);
        break;
      case 3:
        Navigator.pushNamed(context, Routes.DEVICE_LINKS);
        break;
      case 4:
        Navigator.pushNamed(context, Routes.HOME); //TODO: create a Product Help page
        break;
      case 5:
        Navigator.pushNamed(context, Routes.HOME); //TODO: create a Privacy Policy
        break;
      case 6:
        Navigator.pushReplacementNamed(context, Routes.HOME); //TODO: make log out method
        break;
    }
  }

}