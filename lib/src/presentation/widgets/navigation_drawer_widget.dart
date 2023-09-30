import 'package:cross_link/src/config/router/routes.dart';
import 'package:cross_link/src/presentation/widgets/sign_up_widget.dart';
import 'package:cross_link/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';

import '../../utils/common_widgets/menu_tile_widget.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Image.asset(logoNameImage),
            ),
            MenuTileWidget(
              title: 'Profile',
              icon: Icons.person,
              endIcon: false,
              onPress: () => selectedItem(context, 0),
            ),
            MenuTileWidget(
              title: 'Sign in / Sign up',
              icon: Icons.login,
              endIcon: false,
              onPress: () => selectedItem(context, 1),
            ),
            MenuTileWidget(
              title: 'Summary',
              icon: Icons.folder_open,
              endIcon: false,
              onPress: () => selectedItem(context, 2),
            ),
            MenuTileWidget(
              title: 'User Links',
              icon: Icons.link,
              endIcon: false,
              onPress: () => selectedItem(context, 3),
            ),
            MenuTileWidget(
              title: 'Product Help',
              icon: Icons.help_outline,
              endIcon: false,
              onPress: () => selectedItem(context, 4),
            ),
            MenuTileWidget(
              title: 'Privacy Policy',
              icon: Icons.visibility,
              endIcon: false,
              onPress: () => selectedItem(context, 5),
            ),
            MenuTileWidget(
              title: 'Find Device',
              icon: Icons.device_unknown,
              endIcon: false,
              onPress: () => selectedItem(context, 7),
            ),
            const Divider(color: Colors.white, thickness: 1,),
            MenuTileWidget(
              title: 'Log out',
              icon: Icons.logout,
              endIcon: false,
              onPress: () => selectedItem(context, 6),
            ),
          ],
        )
      ),
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
        Navigator.pushNamed(context, Routes.USER_LINKS);
        break;
      case 4:
        debugPrint('product help'); //TODO: create a Product Help page
        break;
      case 5:
        debugPrint('privacy policy'); //TODO: create a Privacy Policy
        break;
      case 6:
        debugPrint('log out'); //TODO: make log out method
        break;
      case 7:
        Navigator.pushNamed(context, Routes.FIND_DEVICE);
        break;
    }
  }

}