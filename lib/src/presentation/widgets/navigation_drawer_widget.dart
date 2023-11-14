import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../main.dart';
import '../../config/router/routes.dart';
import '../../utils/common_widgets/menu_tile_widget.dart';
import '../../utils/constants/strings.dart';
import '../../utils/functions/auth_service.dart';
import 'sign_in_widget.dart';

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({super.key});

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  bool existUser = false;
  late String? token;
  StreamSubscription<User?>? _authSubscription;

  @override
  void initState() {
    super.initState();
    token = deviceTokenGlobal;
    _authSubscription = FirebaseAuth.instance
      .authStateChanges()
      .listen((User? user) {
        if (mounted) {
          existUser = user != null;
          setState(() {});
        }
    });
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 64.0, 8.0),
              child: SvgPicture.asset(
                logoNameImage,
                fit: BoxFit.fitWidth,
              ),
            ),
            existUser? MenuTileWidget(
              title: 'Profile',
              icon: Icons.person_outline,
              endIcon: false,
              onPress: () => selectedItem(context, 0),
            ) : const SizedBox(),
            !existUser? MenuTileWidget(
              title: 'Sign in / Sign up',
              icon: Icons.login,
              endIcon: false,
              onPress: () => selectedItem(context, 1),
            ) : const SizedBox(),
            existUser? MenuTileWidget(
              title: 'Summary',
              icon: Icons.folder_outlined,
              endIcon: false,
              onPress: () => selectedItem(context, 2),
            ) : const SizedBox(),
            existUser? MenuTileWidget(
              title: 'User Links',
              icon: Icons.link,
              endIcon: false,
              onPress: () => selectedItem(context, 3),
            ) : const SizedBox(),
            MenuTileWidget(
              title: 'Product Help',
              icon: Icons.error_outline_rounded,
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
              title: 'Find Device old',
              icon: Icons.device_unknown,
              endIcon: false,
              onPress: () => selectedItem(context, 7),
            ),
            MenuTileWidget(
              title: 'Find Device new',
              icon: Icons.device_unknown,
              endIcon: false,
              onPress: () => selectedItem(context, 8),
            ),
            /*MenuTileWidget(
              title: 'Find Device Serial',
              icon: Icons.device_unknown,
              endIcon: false,
              onPress: () => selectedItem(context, 9),
            ),*/
            const Divider(color: Colors.white, thickness: 1,),
            existUser? MenuTileWidget(
              title: 'Log out',
              icon: Icons.logout,
              endIcon: false,
              onPress: () => selectedItem(context, 6),
            ) : const SizedBox(),
          ],
        )
      ),
    );
  }

  void selectedItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.popAndPushNamed(context, Routes.PROFILE);
        break;
      case 1:
        Navigator.pop(context);
        showDialog(context: context, builder: (BuildContext context) => SignInWidget(deviceToken: token!,));
        break;
      case 2:
        Navigator.popAndPushNamed(context, Routes.SUMMARY);
        break;
      case 3:
        Navigator.popAndPushNamed(context, Routes.USER_LINKS);
        break;
      case 4:
        debugPrint('product help'); //TODO: create a Product Help page
        break;
      case 5:
        debugPrint('privacy policy'); //TODO: create a Privacy Policy
        break;
      case 6:
        //signOutCurrentUser().then((value) => Navigator.of(context).pop());
        AuthService().signOutWithGoogle();
        break;
      case 7:
        Navigator.popAndPushNamed(context, Routes.FIND_DEVICE);
        break;
      case 8:
        Navigator.popAndPushNamed(context, Routes.FIND_DEVICES);
        break;
      case 9:
        Navigator.popAndPushNamed(context, Routes.FIND_DEVICES_SERIAL);
        break;
    }
  }
}