import 'package:cross_link/src/config/router/routes.dart';
import 'package:cross_link/src/utils/constants/nums.dart';
import 'package:cross_link/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Container(
        padding: const EdgeInsets.all(defaultSize),
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: const Image(image: AssetImage(defaultProfileImage)),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.blue.withOpacity(0.1),
                    ),
                    child: const Icon(Icons.brush, size: 18, color: Colors.black,),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10,),
            const Text('Profile Name', style: TextStyle(fontSize: 20),),
            const Text('useremail@mail.com', style: TextStyle(fontSize: 16),),
            const SizedBox(height: 20,),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {Navigator.pushNamed(context, Routes.UPDATE_PROFILE);},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, side: BorderSide.none, shape: const StadiumBorder()
                ),
                child: const Text('Edit Profile', style: TextStyle(color: Colors.white),),
              ),
            ),
            const SizedBox(height: 30,),
            const Divider(),
            const SizedBox(height: 10,),

            //Menu
            ProfileMenuWidget(title: 'Settings', icon: Icons.settings, onPress: () {},),
            ProfileMenuWidget(title: 'Healthcare Survey', icon: Icons.sticky_note_2_rounded, onPress: () {},),
            ProfileMenuWidget(title: 'Check your links', icon: Icons.people_alt_rounded, onPress: () {},),
            const Divider(),
            const SizedBox(height: 10,),
            ProfileMenuWidget(
              title: 'Log out',
              icon: Icons.exit_to_app_rounded,
              textColor: Colors.red,
              onPress: () {},
            ),
          ],
        ),
      ),
    );
  }

}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.blue.withOpacity(0.1),
        ),
        child: Icon(icon, color: Colors.blue,),
      ),
      title: Text(title, style: const TextStyle(fontSize: 16).apply(color: textColor),),
      trailing: endIcon? Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.grey.withOpacity(0.1),
        ),
        child: const Icon(Icons.arrow_forward, size: 18, color: Colors.grey,),
      ) : null,
    );
  }
}