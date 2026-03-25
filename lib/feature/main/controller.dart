import 'package:get/get.dart';
import 'package:renva/core/config/app_builder.dart';
import 'package:renva/feature/profile/profile/controller.dart';

class MainPageController extends GetxController {
  Rx<int> currentPage = 0.obs;
  var showNavBar = true.obs;
  final AppBuilder appBuilder = Get.find();

  @override
  void onInit() {
    Get.put(ProfilePageController(), permanent: true);

    super.onInit();
  }
}
