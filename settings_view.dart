import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:losts_guide/application/controllers/settings_controller.dart';
import 'package:losts_guide/presentation/widgets/custom_app_bar.dart';
import '../theme/AppColors.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav_bar.dart';

import 'about_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsView extends StatelessWidget {
  final SettingsController controller = Get.put(SettingsController());
  SettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).extension<AppColors>()!.backgroundColor,
      appBar:CustomAppBar(title:  'settings'.tr),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text(
                'app_language'.tr,
                style: TextStyle(
                  fontFamily: 'Alexandria',
                  color: Theme.of(context).extension<AppColors>()!.textColor,
                ),
              ),
              subtitle: Obx(
                () => Text(
                  controller.selectedLanguage.value,
                  style: const TextStyle(fontFamily: 'Alexandria'),
                ),
              ),
              leading: const Icon(Icons.language),
              trailing: Obx(() {
                String selectedCode = controller.languages.firstWhere((lang) =>
                    lang['name'] == controller.selectedLanguage.value)['code']!;
                return DropdownButton<String>(
                  value: selectedCode,
                  items: controller.languages.map((language) {
                    return DropdownMenuItem(
                      value: language['code'],
                      child: Text(
                        language['name']!,
                        style: const TextStyle(fontFamily: 'Alexandria'),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      controller.changeLanguage(value);
                    }
                  },
                );
              }),
            ),
            ListTile(
              title: Text(
                'app_theme'.tr,
                style: const TextStyle(fontFamily: 'Alexandria'),
              ),
              subtitle: Obx(
                () => Text(
                  controller.selectedTheme.value,
                  style: const TextStyle(fontFamily: 'Alexandria'),
                ),
              ),
              leading: const Icon(Icons.brightness_6),
              trailing: DropdownButton<String>(
                value: controller.selectedTheme.value,
                items: controller.themes.map((theme) {
                  return DropdownMenuItem(
                    value: theme,
                    child: Text(
                      theme.tr,
                      style: const TextStyle(fontFamily: 'Alexandria'),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    controller.changeTheme(value);
                  }
                },
              ),
            ),
            ListTile(
              title: Text(
                'about_app'.tr,
                style: const TextStyle(fontFamily: 'Alexandria'),
              ),
              leading: const Icon(Icons.info),
              onTap: () {
                Get.to(() => AboutView(
                    title: 'about_app'.tr, content: 'app_description'.tr));
              },
            ),
            ListTile(
              title: Text(
                'about_org'.tr,
                style: const TextStyle(fontFamily: 'Alexandria'),
              ),
              leading: const Icon(Icons.info_outline),
              onTap: () {
                Get.to(() => AboutView(
                    title: 'about_org'.tr, content: 'org_description'.tr));
              },
            ),
            const Spacer(),
            SvgPicture.asset(
              'assets/images/iahs-wn-logo1.svg',
              height: 70,
              width: 70,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            const Text(
              'جميع الحقوق محفوظة\nلمركز تكنولوجيا المعلومات في العتبة العلوية المقدسة\n© 2024',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Alexandria', color: Color(0xFFA7B4D4)),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar:
          const BottomNavBar(currentIndex: 2), // Use the custom BottomNavBar
    );
  }
}
