import 'package:get/get.dart';
import 'package:renvo_app/core/config/app_builder.dart';

import '../../core/routes/routes.dart';

import 'package:flutter/material.dart';

class SplashScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController rotationController;
  final appBuilder = Get.put(AppBuilder());
  // final AppBuilder appBuilder = Get.find();

  Future<void> loadData() async {
    await 2.seconds.delay();
    appBuilder.init();
    // Get.offNamed(Pages.login.value);
  }

  @override
  void onInit() {
    super.onInit();
    rotationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    )..repeat();

    loadData();
  }

  @override
  void onClose() {
    rotationController.dispose();
    super.onClose();
  }
}
