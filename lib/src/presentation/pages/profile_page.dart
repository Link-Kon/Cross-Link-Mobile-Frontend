import 'package:cross_link/src/config/router/routes.dart';
import 'package:cross_link/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';
import '../../utils/common_widgets/menu_tile_widget.dart';
import '../../utils/common_widgets/section_text_widget.dart';
import '../../utils/common_widgets/section_title_text_widget.dart';
import '../../utils/constants/nums.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: const Image(image: AssetImage(defaultProfileImage)),
            ),
          ),
          const SizedBox(height: 10,),
          const SectionTitleTextWidget(text: 'Maria Bustamante Zuloaga', size: 22),
          const SizedBox(height: 5),
          const SectionTextWidget(text: 'usermail@mail.com'),
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
            onPress: () {Navigator.pushNamed(context, Routes.ILLNESSES);},
          ),
          MenuTileWidget(title: 'Check your links', icon: Icons.link, endIcon: false,
            onPress: () {Navigator.pushNamed(context, Routes.USER_LINKS);},
          ),
          MenuTileWidget(
            title: 'Log out',
            icon: Icons.exit_to_app_rounded,
            endIcon: false,
            onPress: () {},
          ),
        ],
      ),
    );
  }

}
