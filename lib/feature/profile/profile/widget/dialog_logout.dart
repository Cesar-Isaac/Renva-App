import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/config/app_builder.dart';
import 'package:renvo_app/core/routes/routes.dart';

import '../../../../core/localization/strings.dart';
import '../../../../core/style/repo.dart';
import '../../../../core/widgets/svg_icon.dart';
import '../../../../gen/assets.gen.dart';
import '../controller.dart';

class DialogLogOut extends StatelessWidget {
  const DialogLogOut({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<ProfilePageController>();
    return Column(
      children: [
        SvgIcon(
          icon: Assets.icons.delete3,
          color: StyleRepo.red.withOpacity(0.1),
          size: 80,
        ),
        const SizedBox(height: 12),
        Text(
          tr(LocaleKeys.are_you_want_to_logout),
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Get.back(),
                style: OutlinedButton.styleFrom(
                  foregroundColor: StyleRepo.deepPurple, // Text color
                  backgroundColor: StyleRepo.purpleSoft,
                  side: BorderSide(color: StyleRepo.purpleSoft), // Red border
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(tr(LocaleKeys.no)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  final appBuilder = Get.find<AppBuilder>();
                  appBuilder.logout();
                  Get.offNamedUntil(Pages.login.value, (route) => false);
                },

                style: OutlinedButton.styleFrom(
                  foregroundColor: StyleRepo.red, // Text color
                  backgroundColor: StyleRepo.red.withOpacity(0.3),
                  side: BorderSide(color: StyleRepo.red), // Red border
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(tr(LocaleKeys.yes)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
