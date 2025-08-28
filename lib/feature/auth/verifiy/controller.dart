import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../core/config/app_builder.dart';
import '../../../core/localization/strings.dart';
import '../../../core/routes/routes.dart';
import '../../../core/services/rest_api/api_service.dart';
import '../../../core/services/rest_api/constants/end_points.dart';
import '../../../core/services/rest_api/models/request.dart';
import '../../../core/services/rest_api/models/response_model.dart';
import '../../../core/style/repo.dart';

class VerifyPageController extends GetxController {
  AppBuilder appBuilder = Get.find();
  var isLoading = false.obs;
  RxInt secondsLeft = 60.obs;
  RxBool isResendActive = false.obs;
  late final String phoneNumber;
  late TextEditingController otp;
  Timer? _timer;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void startTimer() {
    secondsLeft.value = 60;
    isResendActive.value = false;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeft.value == 0) {
        isResendActive.value = true;
        timer.cancel();
      } else {
        secondsLeft.value--;
      }
    });
  }

  String get formattedTime {
    final minutes = (secondsLeft.value ~/ 60).toString().padLeft(2, '0');
    final secs = (secondsLeft.value % 60).toString().padLeft(2, '0');
    return '$minutes : $secs';
  }

  @override
  void onClose() {
    _timer?.cancel();
    otp.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    final arguments = Get.arguments as Map<String, dynamic>;
    phoneNumber = arguments['phone'];
    otp = TextEditingController();
    startTimer();
    super.onInit();
  }

  Future<void> confirm() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    final arguments = Get.arguments as Map<String, dynamic>;
    final String purpose = arguments['purpose'];

    ResponseModel response = await APIService.instance.request(
      Request(
        endPoint: EndPoints.Verify,
        method: RequestMethod.Post,
        body: {
          "otp": otp.text,
          "dial_country_code": "963",
          "phone": phoneNumber,
          "device_token": "55555",
        },
      ),
    );

    isLoading.value = false;

    if (response.success) {
      String? token = response.data['token'];

      if (token != null) {
        appBuilder.setToken(token);

        if (purpose == "forgot_password") {
          Get.offNamed(
            Pages.reset_password.value,
            arguments: {"phone": phoneNumber, "token": token},
          );
        } else if (purpose == "register" || purpose == "login") {
          Get.offAllNamed(
            Pages.complete_info.value,
            arguments: {
              "phone": phoneNumber,
              "token": token,
              "id": response.data["id"],
            },
          );
        }
      } else {
        Get.snackbar(
          tr(LocaleKeys.error),
          response.message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: StyleRepo.red,
          colorText: StyleRepo.white,
        );
      }
    } else {
      final errorMessage =
          response.data is List && response.data.isNotEmpty
              ? response.data[0]
              : response.message;

      Get.snackbar(
        tr(LocaleKeys.error_otp),
        errorMessage,
        snackPosition: SnackPosition.TOP,
        backgroundColor: StyleRepo.red,
        colorText: StyleRepo.white,
      );
    }
  }

  Future<void> resendOtp() async {
    if (!isResendActive.value) return;

    isResendActive.value = false;

    ResponseModel response = await APIService.instance.request(
      Request(
        endPoint: EndPoints.resent_otp,
        method: RequestMethod.Post,
        body: {"phone": phoneNumber, "dial_country_code": "963"},
      ),
    );

    if (response.success) {
      final successMessage =
          response.data is List && response.data.isNotEmpty
              ? response.data[0]
              : response.message;

      Get.snackbar(
        tr(LocaleKeys.success),
        "Your Verify Code is: 1111",
        snackPosition: SnackPosition.TOP,
        backgroundColor: StyleRepo.green,
        colorText: StyleRepo.white,
      );

      // Restart the timer after successful resend
      startTimer();
    } else {
      isResendActive.value = true; // Reactivate buttom if request faild
      final errorMessage = response.message ;
      Get.snackbar(
        tr(LocaleKeys.error),
        errorMessage,
        snackPosition: SnackPosition.TOP,
        backgroundColor: StyleRepo.red,
        colorText: StyleRepo.white,
      );
    }
  }
}
