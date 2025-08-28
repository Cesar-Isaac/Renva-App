import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/feature/auth/login/widget/form.dart';
import '../base_sliver_scaffold/base_sliver_scaffold.dart';
import 'controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginPageController());
    return BaseSliverScaffold(
      leading: null,
      title: null,
      child: FormLogin(controller: controller),
    );
  }
}



