import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:dio/dio.dart';
import 'package:renvo_app/core/config/app_builder.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/core/routes/routes.dart';
import 'package:renvo_app/core/services/rest_api/api_service.dart';
import 'package:renvo_app/core/services/rest_api/constants/end_points.dart';
import 'package:renvo_app/core/services/rest_api/models/request.dart';
import 'package:renvo_app/core/style/repo.dart';
import 'package:renvo_app/feature/profile/profile/models/get_profile.dart';

import 'package:renvo_app/feature/provider_pages/provider_profile_page/widgets/steper/step_one/controller_step_one.dart';
import 'package:renvo_app/feature/provider_pages/provider_profile_page/widgets/steper/step_two/controller_step_two.dart';

class ProviderProfilePageController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final controllerStepOne = Get.put(ControllerStepOne());
  final controllerStepTwo = Get.put(ControllerStepTwo());
  var isLoading = false.obs;
  final AppBuilder appBuilder = Get.find();

  void loadProfileData(MainProfile profile) {
    controllerStepOne.oldGallery.clear();

    if (profile.provider?.gallery != null) {
      controllerStepOne.oldGallery.addAll(
        controllerStepOne.oldGallery,
      );
    }
  }

  final RxInt currentStep = 0.obs;
  void onBackStep() {
    if (currentStep.value > 0) currentStep.value--;
  }

  Future<void> updateProv() async {
    isLoading.value = true;
    final token = appBuilder.token;

    Map<String, dynamic> map = {
      "name": controllerStepOne.name.text,
      "dial_country_code": "963",
      "phone": controllerStepOne.phoneNumber.text,
      "description": controllerStepOne.description.text,
      "region_ids[0]": 1,
    
    };
    for (int i = 0; i < controllerStepOne.oldGallery.length; i++) {
      map["old_gallery[$i]"] = controllerStepOne.oldGallery[i].url;
    }

    for (int i = 0; i < controllerStepOne.uploadedPhotos.length; i++) {
      map["gallery[$i]"] = await MultipartFile.fromFile(
        controllerStepOne.uploadedPhotos[i].path,
        filename: "gallery_$i.jpg",
      );
    }

    final selectedIdsList = controllerStepTwo.selectedCategoryIds.toList();
    for (int i = 0; i < selectedIdsList.length; i++) {
      map["prv_category_ids[$i]"] = selectedIdsList[i];
    }

    map.forEach((key, value) {
      if (value is MultipartFile) {
        debugPrint("📷 $key: [File - ${value.filename}]");
      } else if (value is String && value.startsWith("http")) {
        debugPrint("🌐 $key: [URL - $value]");
      } else {
        debugPrint("🔹 $key: $value");
      }
    });

    final response = await APIService.instance.request(
      Request(
        endPoint: EndPoints.update_provider,
        method: RequestMethod.Post,
        header: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: FormData.fromMap(map),
      ),
    );

    isLoading.value = false;

    if (response.success) {
      Get.snackbar(
        "Success",
        response.message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.until((rout) => Pages.home.value == rout.settings.name);
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

  bool validateCustomFields() {
    bool isValid = true;

    if (controllerStepOne.uploadedPhotos.length < 2) {
      controllerStepOne.photoError.value = tr(
        LocaleKeys.at_least_two_images_must_be_uploaded,
      );
      isValid = false;
    }

    return isValid;
  }

  void onNextStep() {
    switch (currentStep.value) {
      case 0:
        if (controllerStepOne.formKeyStep1.currentState!.validate()) {
          currentStep.value++;
        }
        break;
      case 1:
        if (controllerStepTwo.formKeyStep2.currentState!.validate() &&
            validateCustomFields()) {
          updateProv();
        }
        break;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}
