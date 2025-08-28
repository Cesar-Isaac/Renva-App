import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/core/style/repo.dart';
import 'package:renvo_app/feature/add/add_order_details/widgets/steper/step_1/controller.dart';

class ControllerStep2 extends ControllerStep1 {
  
  final Rx<RangeValues> priceRange = const RangeValues(50, 200).obs;
  final RxString photoError = ''.obs;
  final RxList<XFile> uploadedPhotos = <XFile>[].obs;

  void updateRange(RangeValues values) {
    priceRange.value = values;
  }

  Future<void> pickImageUploadPhoto() async {
    final List<XFile>? images = await ImagePicker().pickMultiImage();
    if (images == null || images.isEmpty) return;

    int total = uploadedPhotos.length + images.length;
    if (total > 5) {
      Get.snackbar(
        backgroundColor: StyleRepo.red,
        colorText: StyleRepo.white,
        tr(LocaleKeys.error),
        tr(LocaleKeys.the_maximum_number_of_images_is_5),
      );
      return;
    }

    uploadedPhotos.addAll(images);
    photoError.value = '';
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
