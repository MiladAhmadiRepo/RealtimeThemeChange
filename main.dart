import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:losts_guide/data/services/notification_service.dart';
import 'package:losts_guide/presentation/pages/choose_language_view.dart';
import 'package:losts_guide/presentation/pages/home_view.dart';
import 'application/controllers/settings_controller.dart';
import 'firebase_options.dart';
import 'locales/ar.dart';
import 'locales/en.dart';
import 'locales/fa.dart';
import 'locales/ur.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'presentation/theme/AppColors.dart';
import 'presentation/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Get.put(SettingsController());
  await Get.putAsync<NotificationService>(() async {
    final service = NotificationService();
    await service.init();
    return service;
  });

  final settingsController = Get.find<SettingsController>();
  await settingsController.loadSelectedLanguage();
  await settingsController.loadSelectedTheme();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController = Get.find();

    return Obx(() {
      return GetMaterialApp(
        title: 'guidance_of_lost'.tr,
        translations: MyTranslations(),
        locale: settingsController.getLocale(),
        fallbackLocale: const Locale('en', 'US'),
        themeMode: settingsController.getThemeMode(),
        theme: ThemeData.light().copyWith(
          extensions: <ThemeExtension<AppColors>>[
            AppColors(
              backgroundColor:  AppThemeLight.lightBackgroundColor  ,
              textColor:     AppThemeLight.lightTextColor ,
              appBarTextColor:     AppThemeLight.lightAppBarTextColor  ,
              cardColor:     AppThemeLight.lightCardColor  ,
              accentColor:     AppThemeLight.lightAccentColor  ,
            ),
          ],
        ),
        darkTheme: ThemeData.dark().copyWith(
          extensions: <ThemeExtension<AppColors>>[
            AppColors(
              backgroundColor:  AppThemeDark.darkBackgroundColor  ,
              textColor:     AppThemeDark.darkTextColor  ,
              appBarTextColor:     AppThemeDark.darkAppBarTextColor  ,
              cardColor:     AppThemeDark.darkCardColor  ,
              accentColor:    AppThemeDark.darkAccentColor  ,
            ),
          ],
        ),
        home: settingsController.selectedLanguage.value.isEmpty
            ? const ChooseLanguageView()
            : const HomeView(),
      );
    });
  }
}

class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'ar_SA': ar,
    'en_US': en,
    'fa_FA': fa,
    'ur_PK': ur,
  };
}
