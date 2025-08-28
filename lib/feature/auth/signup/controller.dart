import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/config/role.dart';
import '../../../core/config/app_builder.dart';
import '../../../core/routes/routes.dart';
import '../../../core/services/rest_api/api_service.dart';
import '../../../core/services/rest_api/constants/end_points.dart';
import '../../../core/services/rest_api/models/request.dart';
import '../../../core/services/rest_api/models/response_model.dart';
import '../../../core/style/repo.dart';

class SignUpPageController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AppBuilder appBuilder = Get.find();
  var isLoading = false.obs;
  late TextEditingController phone, password, confirmPassword;

  var obscurePassword = true.obs;
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  var obscureConfirmPassword = true.obs;
  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  Future<void> confirm() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    ResponseModel response = await APIService.instance.request(
      Request(
        endPoint: EndPoints.register,
        method: RequestMethod.Post,
        body: {
          "phone": phone.text,
          "dial_country_code": "963",
          "password": password.text,
          "password_confirmation": confirmPassword.text,
        },
      ),
    );
    debugPrint(
      "phone: ${phone.text} , password:${password.text},password confirmation : ${confirmPassword.text}",
    );

    isLoading.value = false;

    if (response.success) {
      appBuilder.setRole(Role.new_user);
      Get.offAllNamed(
        Pages.verifiy.value,
        arguments: {"phone": phone.text, "purpose": "register"},
      );
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

  @override
  onInit() {
    phone = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
    super.onInit();
  }

  @override
  onClose() {
    phone.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.onClose();
  }
}
