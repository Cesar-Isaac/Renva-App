import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:renvo_app/core/config/app_builder.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/core/services/rest_api/api_service.dart';
import 'package:renvo_app/core/services/rest_api/constants/end_points.dart';
import 'package:renvo_app/core/services/rest_api/models/request.dart';
import 'package:renvo_app/core/services/rest_api/models/response_model.dart';
import 'package:renvo_app/core/services/state_management/obs.dart';
import 'package:renvo_app/feature/profile/profile/models/get_profile.dart';

class OldGallery {
  final String url;

  OldGallery({required this.url});

  factory OldGallery.fromJson(Map<String, dynamic> json) {
    return OldGallery(url: json['url']);
  }
}

class ControllerStepOne extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final formKeyStep1 = GlobalKey<FormState>();
  final RxList<XFile> uploadedPhotos = <XFile>[].obs;
  final RxString photoError = ''.obs;
  final RxList<OldGallery> oldGallery = <OldGallery>[].obs;

 

  Future<void> pickImageUpdatePhoto() async {
    final List<XFile>? images = await ImagePicker().pickMultiImage();
    if (images == null || images.isEmpty) return;

    int total = uploadedPhotos.length + images.length;
    if (total > 10) {
      Get.snackbar(
        tr(LocaleKeys.error),
        tr(LocaleKeys.the_maximum_number_of_images_is_10),
      );
      return;
    }

    uploadedPhotos.addAll(images);
    photoError.value = '';
  }

  ObsVar<MainProfile> profile = ObsVar(null);

  final AppBuilder appBuilder = Get.find();
  late final String token;
  var isLoading = false.obs;
  late TextEditingController name, phoneNumber, description;
  RxString image = "".obs;

  void pickImage() async {
    XFile? picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;
    image.value = picked.path;
  }

  fetch() async {
    final token = appBuilder.token;
    isLoading.value = true;

    image.value = "";

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

      name.text = profile.value?.provider?.name ?? '';
      phoneNumber.text = profile.value?.provider?.phone ?? '';
      description.text = profile.value?.provider?.description ?? '';
      oldGallery.value =
          profile.value?.provider?.gallery
              .map(
                (item) => OldGallery(url: item.originalUrl),
              ) 
              .toList() ??
          [];

      debugPrint("📌 Old gallery after fetch:");
      for (var g in oldGallery) {
        debugPrint("🌐 ${g.url}");
      }
    } else {
      profile.error = response.message;
    }

    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    name = TextEditingController();
    phoneNumber = TextEditingController();
    description = TextEditingController();
    token = appBuilder.token!;
    fetch();
  }
}
