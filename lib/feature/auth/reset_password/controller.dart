import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../core/routes/routes.dart';
import '../../../../../core/services/rest_api/api_service.dart';
import '../../../../../core/services/rest_api/constants/end_points.dart';
import '../../../../../core/services/rest_api/models/request.dart';
import '../../../../../core/services/rest_api/models/response_model.dart';
import '../../../../../core/style/repo.dart';

class ResetPasswordPageController extends GetxController{
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController  password,confirmPassword;
  late final String phoneNumber;
  var isLoading = false.obs;
  late final String token;

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
        endPoint: EndPoints.reset_password,
        method: RequestMethod.Post,
        header: {
          "Authorization": "Bearer $token",
        },
        body: {
          "password": password.text,
          "password_confirmation": confirmPassword.text,

        },
      ),
    );

    isLoading.value = false;

    if (response.success) {
      Get.toNamed(Pages.login.value,
      );
      Get.snackbar(
        "Successfully",
        response.data,
        snackPosition: SnackPosition.TOP,
        backgroundColor: StyleRepo.green,
        colorText: StyleRepo.white,

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
    final args = Get.arguments as Map<String, dynamic>;
    phoneNumber = args["phone"];
    password = TextEditingController();
    confirmPassword = TextEditingController();
    token = args["token"] as String;
    super.onInit();
  }

  @override
  onClose() {
    password.dispose();
    confirmPassword.dispose();
    super.onClose();
  }



}