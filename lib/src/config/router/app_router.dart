import 'package:cross_link/src/config/router/routes.dart';
import 'package:cross_link/src/presentation/pages/device_links_page.dart';
import 'package:cross_link/src/presentation/pages/device_settings_page.dart';
import 'package:cross_link/src/presentation/pages/healthcare_survey_page.dart';
import 'package:cross_link/src/presentation/pages/home_page.dart';
import 'package:cross_link/src/presentation/pages/profile_page.dart';
import 'package:cross_link/src/presentation/pages/settings_page.dart';
import 'package:cross_link/src/presentation/pages/summary_page.dart';
import 'package:cross_link/src/presentation/pages/sign_up_page.dart';
import 'package:flutter/widgets.dart';

Map<String, Widget Function(BuildContext)> appRoutes() {
  return {
    Routes.HOME: (_) => const HomePage(),
    Routes.DEVICE_LINKS: (_) => const DeviceLinksPage(),
    Routes.DEVICE_SETTINGS: (_) => const DeviceSettingsPage(),
    Routes.HEALTHCARE_SURVEY: (_) => HealthcareSurveyPage(),
    Routes.PROFILE: (_) => const ProfilePage(),
    Routes.SETTINGS: (_) => const SettingsPage(),
    Routes.SUMMARY: (_) => const SummaryPage(),
    Routes.USER_REGISTRATION: (_) => SignUpPage(),
  };
}