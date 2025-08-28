import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/feature/auth/verifiy/widget/verify_form.dart';
import '../base_sliver_scaffold/base_sliver_scaffold.dart';
import 'controller.dart';

class VerifyPage extends StatelessWidget {
  const VerifyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerifyPageController>(
      init: Get.put(VerifyPageController()),
      builder: (controller) {
        return BaseSliverScaffold(

          child: VerifyForm(),
        );
      },
    );

  }
}


