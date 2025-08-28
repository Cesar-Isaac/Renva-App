import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/core/routes/routes.dart';
import 'package:renvo_app/core/services/state_management/obs.dart';
import 'package:renvo_app/core/style/repo.dart';

import 'package:renvo_app/feature/home/models/all_categories.dart';
import '../../../core/config/app_builder.dart';
import '../../../core/services/rest_api/api_service.dart';
import '../../../core/services/rest_api/constants/end_points.dart';
import '../../../core/services/rest_api/models/request.dart';
import '../../../core/services/rest_api/models/response_model.dart';
import 'models/get_profile.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:dio/dio.dart';

class ProfilePageController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxSet<int> selectedCategoryIds = <int>{}.obs;
  final RxSet<int> selectedIndexes = <int>{}.obs;
  void toggleSelection(int id) {
    if (selectedCategoryIds.contains(id)) {
      selectedCategoryIds.remove(id);
    } else {
      selectedCategoryIds.add(id);
    }
  }

  bool isSelected(int categoryId) => selectedCategoryIds.contains(categoryId);

  late TextEditingController firstName, lastName, email, phoneNumber, gender;

  @override
  void onInit() {
    super.onInit();
    firstName = TextEditingController();
    lastName = TextEditingController();
    email = TextEditingController();
    phoneNumber = TextEditingController();
    gender = TextEditingController();
    token = appBuilder.token!;
    fetch();
  }

  @override
  void onClose() {
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    phoneNumber.dispose();
    gender.dispose();

    super.onClose();
  }

  RxString image = "".obs;
  Rx<String> imageId = "".obs;
  var isLoading = false.obs;

  RxBool isNotification = false.obs;

  void toggleNotification(bool value) {
    isNotification.value = value;
  }

  RxBool isTranslate = false.obs;

  void toggleTranslation(bool value, BuildContext context) async {
    isTranslate.value = value;
    final newLocale = value ? const Locale('ar') : const Locale('en');
    await EasyLocalization.of(context)?.setLocale(newLocale);
    Get.updateLocale(newLocale); 
  }

  final AppBuilder appBuilder = Get.find();
  late final String token;

  ObsVar<MainProfile> profile = ObsVar(null);

  void pickImage() async {
    XFile? picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;
    image.value = picked.path;
  }

  int getGenderIdFromText(String input) {
    final value = input.toLowerCase().trim();
    if (value == 'male' || value == 'ذكر') return 1;
    if (value == 'female' || value == 'أنثى') return 2;
    throw Exception('Invalid gender value: $input');
  }

  pickImageID() async {
    XFile? picked = await ImagePicker().pickImage(source: ImageSource.camera);
    if (picked == null) return;
    imageId.value = picked.path;
  }

  ObsList<AllCategories> categories = ObsList([]);

  fetchCategory() async {
    final token = appBuilder.token;
    ResponseModel response = await APIService.instance.request(
      Request(
        endPoint: EndPoints.categories,
        fromJson: AllCategories.fromJson,
        header: {"Authorization": "Bearer $token"},
      ),
    );
    if (response.success) {
      categories.value = response.data;
    } else {
      categories.error = response.message;
    }
  }

  fetch() async {
    final token = appBuilder.token;
    isLoading.value = true;

    image.value = "";
    imageId.value = "";

    ResponseModel response = await APIService.instance.request(
      Request(
        endPoint: EndPoints.profile,
        fromJson: MainProfile.fromJson,
        header: {"Authorization": "Bearer $token"},
      ),
    );

    if (response.success) {
      profile.value = response.data;
      profile.error = null;

      if (Get.isRegistered<ProfilePageController>()) {
        firstName.text = profile.value?.firstName ?? '';
        lastName.text = profile.value?.lastName ?? '';
        email.text = profile.value?.email ?? '';
        phoneNumber.text = profile.value?.phone ?? '';
        gender.text = profile.value?.gender.name ?? '';
      }
    } else {
      profile.error = response.message;
    }

    isLoading.value = false;
  }

  Future<void> save() async {
    final token = appBuilder.token;
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;

    Map<String, dynamic> bodyMap = {
      "first_name": firstName.text,
      "last_name": lastName.text,
      "phone": phoneNumber.text,
      "email": email.text,
      "dial_country_code": "963",
      "gender_id": getGenderIdFromText(gender.text),
    };

    if (image.value.isNotEmpty) {
      bodyMap["avatar"] = await MultipartFile.fromFile(
        image.value,
        filename: "avatar.jpg",
      );
    }

    if (imageId.value.isNotEmpty) {
      bodyMap["IDcard"] = await MultipartFile.fromFile(
        imageId.value,
        filename: "idcard.jpg",
      );
    }

    final response = await APIService.instance.request(
      Request(
        endPoint: EndPoints.update,
        method: RequestMethod.Post,
        header: {"Authorization": "Bearer $token", "Locale": "ar"},
        body: FormData.fromMap(bodyMap),
      ),
    );

    isLoading.value = false;

    if (response.success) {
      Get.snackbar(
        "Success",
        "Saved",
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

  Future<void> delete() async {
    final token = appBuilder.token;
    isLoading.value = true;

    ResponseModel response = await APIService.instance.request(
      Request(
        endPoint: EndPoints.delete,
        method: RequestMethod.Delete,
        header: {"Authorization": "Bearer $token"},
      ),
    );

    isLoading.value = false;

    if (response.success) {
      final successMessage =
          response.data is List && response.data.isNotEmpty
              ? response.data[0]
              : response.message;

      Get.offAllNamed(Pages.login.value);
      Get.snackbar(
        tr(LocaleKeys.success),
        successMessage,
        colorText: StyleRepo.white,
        backgroundColor: StyleRepo.green,
      );
    } else {
      Get.snackbar(
        tr(LocaleKeys.error),
        response.message,
        colorText: StyleRepo.white,
        backgroundColor: StyleRepo.red,
      );
    }
  }
}
