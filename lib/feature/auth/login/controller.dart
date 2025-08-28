import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:renvo_app/feature/profile/profile/controller.dart';
import '../../../core/config/app_builder.dart';
import '../../../core/config/role.dart';
import '../../../core/routes/routes.dart';
import '../../../core/services/rest_api/api_service.dart';
import '../../../core/services/rest_api/constants/end_points.dart';
import '../../../core/services/rest_api/models/request.dart';
import '../../../core/style/repo.dart';

class LoginPageController extends GetxController {
  final AppBuilder appBuilder = Get.find();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var isLoading = false.obs;
  late TextEditingController phone;
  late TextEditingController password;

  final obscurePassword = true.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  @override
  void onInit() {
    phone = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    phone.dispose();
    password.dispose();
    super.onClose();
  }

  Future<void> confirm() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    final response = await APIService.instance.request(
      Request(
        endPoint: EndPoints.login,
        method: RequestMethod.Post,
        body: {
          "phone": phone.text,
          "dial_country_code": "963",
          "password": password.text,
          "device_token": "2127",
        },
      ),
    );

    isLoading.value = false;

    if (response.success) {
      if (response.data is List &&
          response.data.contains("OTP code generated successfully")) {
        Get.offNamed(
          Pages.verifiy.value,
          arguments: {"phone": phone.text, "purpose": "register"},
        );
      } else {
        final token = response.data['token'];
        if (response.data['is_completed'] == 0) {
          Get.offNamed(
            Pages.complete_info.value,
            arguments: {"phone": phone.text, "token": token},
          );
        } else {
          if (Get.isRegistered<ProfilePageController>()) {
            Get.delete<ProfilePageController>(force: true);
          }

          appBuilder.setRole(Role.user);
          appBuilder.setToken(token);
          
          appBuilder.box.write("isLoggedIn", true);

          appBuilder.box.write("token", token);
          Get.offAllNamed(Pages.home.value);
          debugPrint("token : $token");
        }
      }
    } else {
      Get.snackbar(
        "Error",
        response.message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: StyleRepo.red,
        colorText: StyleRepo.white,
      );
    }
  }
}
