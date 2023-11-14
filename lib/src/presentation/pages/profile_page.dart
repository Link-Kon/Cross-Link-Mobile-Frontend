import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:cross_link/src/config/router/routes.dart';
import 'package:cross_link/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/themes/app_colors.dart';
import '../../utils/common_widgets/menu_tile_widget.dart';
import '../../utils/common_widgets/section_text_widget.dart';
import '../../utils/common_widgets/section_title_text_widget.dart';
import '../../utils/constants/nums.dart';
import '../../utils/functions/auth_service.dart';
import '../../utils/functions/aws_functions.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthUser? user;

  @override
  void initState() {
    Future.delayed(Duration.zero,() async {
      try {
        user = await getCurrentUser();
        setState(() {});
      } catch (e) {
        debugPrint('User is not logged in');
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Palette.black,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            width: 120,
            height: 120,
            child: SvgPicture.asset(defaultProfileImage),
          ),
          const SizedBox(height: 10,),
          SectionTitleTextWidget(text: 'user.username', size: 22), //'Maria Bustamante Zuloaga'
          const SizedBox(height: 5),
          const SectionTextWidget(text: 'usermail@mail.com'), //'usermail@mail.com' user.signInDetails
          const SizedBox(height: 15,),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {Navigator.pushNamed(context, Routes.UPDATE_PROFILE);},
              style: ElevatedButton.styleFrom(
                side: BorderSide.none,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text('Edit Profile', style: TextStyle(color: Colors.white, fontSize: textButtonSize),),
            ),
          ),
          const SizedBox(height: 30,),

          //Menu
          MenuTileWidget(title: 'Settings', icon: Icons.settings, endIcon: false,
            onPress: () {},
          ),
          MenuTileWidget(title: 'Healthcare Survey', icon: Icons.copy, endIcon: false,
            onPress: () {Navigator.pushNamed(context, Routes.HEALTHCARE_SURVEY);},
          ),
          MenuTileWidget(title: 'Check your links', icon: Icons.link, endIcon: false,
            onPress: () {Navigator.pushNamed(context, Routes.USER_LINKS);},
          ),
          MenuTileWidget(
            title: 'Log out',
            icon: Icons.exit_to_app_rounded,
            endIcon: false,
            onPress: () {
              AuthService().signOutWithGoogle();
              Navigator.pop(context);
              Navigator.pushNamed(context, Routes.HOME);
            },
          ),
        ],
      ),
    );
  }
}
