

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/localization/strings.dart';
import '../../../../core/style/repo.dart';
import '../controller.dart';

class ResentCodeButton extends StatelessWidget {
  const ResentCodeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<VerifyPageController>();

    return Obx(() {
      return TextButton(
        onPressed: controller.isResendActive.value
            ? () {
          controller.resendOtp();
        }
            : null, 
        child: Text(
          controller.isResendActive.value
              ? tr(LocaleKeys.resent_code)
              : controller.formattedTime, 
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: controller.isResendActive.value
                ? StyleRepo.blue
                : StyleRepo.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    });
  }
}
