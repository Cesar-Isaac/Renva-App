import 'package:get/get.dart';
import 'package:renva/core/config/app_builder.dart';


import 'package:flutter/material.dart';

class SplashScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController rotationController;
  final appBuilder = Get.put(AppBuilder());

  Future<void> loadData() async {
    await 2.seconds.delay();
    appBuilder.init();
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
