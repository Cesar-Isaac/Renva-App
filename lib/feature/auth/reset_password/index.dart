import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/localization/strings.dart';
import '../../../../../core/style/repo.dart';
import '../base_sliver_scaffold/base_sliver_scaffold.dart';
import 'controller.dart';
import 'widgets/form_change_password.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ResetPasswordPageController());
    return BaseSliverScaffold(
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Center(
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: StyleRepo.white,
              size: 20,
            ),
          ),
        ),
      ),
      title: Text(
        tr(LocaleKeys.back),
        style: TextStyle(color: StyleRepo.white,
            fontSize: 20
        ),
      ),
      child: FormChangePassword(),

    );
  }
}
