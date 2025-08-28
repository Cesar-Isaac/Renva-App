import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/feature/auth/signup/widget/form.dart';
import '../../../core/style/repo.dart';
import '../base_sliver_scaffold/base_sliver_scaffold.dart';
import 'controller.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpPageController());

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
        style: TextStyle(color: StyleRepo.white, fontSize: 20),
      ),

      child: FormsSignUp(controller: controller),
    );
  }
}
