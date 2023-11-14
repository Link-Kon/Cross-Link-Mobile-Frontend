import 'package:flutter/widgets.dart';

import '../../presentation/pages/device_links_page.dart';
import '../../presentation/pages/device_settings_page.dart';
import '../../presentation/pages/find_device_page.dart';
import '../../presentation/pages/find_devices_page.dart';
import '../../presentation/pages/find_devices_serial_page.dart';
import '../../presentation/pages/healthcare_survey_page.dart';
import '../../presentation/pages/home_page.dart';
import '../../presentation/pages/illnesses_page.dart';
import '../../presentation/pages/profile_page.dart';
import '../../presentation/pages/settings_page.dart';
import '../../presentation/pages/sign_up_page.dart';
import '../../presentation/pages/summary_page.dart';
import '../../presentation/pages/update_profile_screen.dart';
import '../../presentation/pages/user_links_page.dart';
import 'routes.dart';

Map<String, Widget Function(BuildContext)> appRoutes() {
  return {
    Routes.HOME: (_) => const HomePage(),
    Routes.DEVICE_LINKS: (_) => const DeviceLinksPage(),
    Routes.DEVICE_SETTINGS: (_) => const DeviceSettingsPage(),
    Routes.USER_LINKS: (_) => const UserLinksPage(),
    Routes.HEALTHCARE_SURVEY: (_) => HealthcareSurveyPage(),
    Routes.PROFILE: (_) => const ProfilePage(),
    Routes.UPDATE_PROFILE: (_) => const UpdateProfilePage(),
    Routes.SETTINGS: (_) => const SettingsPage(),
    Routes.SUMMARY: (_) => const SummaryPage(),
    Routes.SIGN_UP: (_) => const SignUpPage(),
    Routes.ILLNESSES: (_) => const IllnessesPage(),
    Routes.FIND_DEVICE: (_) => const FindDevicePage(),
    Routes.FIND_DEVICES: (_) => const FindDevicesPage(),
    Routes.FIND_DEVICES_SERIAL: (_) => const FindDevicesSerialPage(),
  };
}