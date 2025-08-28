import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/core/routes/routes.dart';

import '../../../core/services/rest_api/api_service.dart';
import '../../../core/services/rest_api/constants/end_points.dart';
import '../../../core/services/rest_api/models/request.dart';
import '../../../core/services/rest_api/models/response_model.dart';
import '../../../core/style/repo.dart';

class ForgetPasswordPageController extends GetxController{
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController phoneNumber;
  var isLoading = false.obs;


  Future<void> confirm() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    ResponseModel response = await APIService.instance.request(
      Request(
        endPoint: EndPoints.forget_password,
        method: RequestMethod.Post,
        body: {
          "phone": phoneNumber.text,
          "dial_country_code": "963",

        },
      ),
    );

    isLoading.value = false;

    if (response.success) {
      Get.toNamed(Pages.verifiy.value, arguments: {
        "phone": phoneNumber.text,
        "purpose": "forgot_password",
      });
    } else {
      Get.snackbar(
        tr(LocaleKeys.error),
        response.message,
        backgroundColor: StyleRepo.red,
        colorText: StyleRepo.white,

      );
    }
  }


  @override
  void onInit() {
    phoneNumber = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    phoneNumber.dispose();
    super.onClose();
  }
}