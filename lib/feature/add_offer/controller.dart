import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:renvo_app/core/config/app_builder.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/core/routes/routes.dart';
import 'package:renvo_app/core/services/rest_api/rest_api.dart';
import 'package:renvo_app/core/style/repo.dart';
import 'package:renvo_app/feature/MyOrder/controller.dart';
import 'package:renvo_app/feature/provider_pages/provider_home_page/controller.dart';

class AddOfferControoler extends GetxController {
  late TextEditingController price, description, time;
  final AppBuilder appBuilder = Get.find();
  final homePageProviderController = Get.find<ProviderHomePageController>();

  final myOrderController = Get.put(
    MyOrderPageController(),
    tag: 'myOrderPage',
  );

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxList<XFile> uploadedPhotos = <XFile>[].obs;
  final RxString photoError = ''.obs;
  var selectedMonth = ''.obs;
  var isLoading = false.obs;
  late final String token;
  late final int orderId;

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

  // ⏰ فتح Time Picker
  void pickTime(BuildContext context, dynamic selectedTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      selectedTime.value = picked.format(context);
    }
  }

  Future<void> sendOffer() async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;
    final token = appBuilder.token;

    Map<String, dynamic> map = {
      "order_id": orderId,
      "description": description.text,
      "price": price.text,
      "time": time.text,
      "time_type": selectedMonth.toLowerCase(),
    };
    for (int i = 0; i < uploadedPhotos.length; i++) {
      map["gallery[$i]"] = await MultipartFile.fromFile(
        uploadedPhotos[i].path,
        filename: "gallery_$i.jpg",
      );
    }

    debugPrint("🚀 Sending Offer Data:");
    map.forEach((key, value) {
      if (value is MultipartFile) {
        print("📷 $key: [File - ${value.filename}]");
      } else {
        print("🔹 $key: $value");
      }
    });

    final response = await APIService.instance.request(
      Request(
        endPoint: EndPoints.add_offer,
        method: RequestMethod.Post,
        header: {"Authorization": "Bearer $token"},
        body: FormData.fromMap(map),
      ),
    );

    isLoading.value = false;

    if (response.success) {
      myOrderController.pagerControllerwaitingProv.refreshData();
      homePageProviderController.refreshData();
      Get.until((rout) => Pages.home.value == rout.settings.name);
      
      Get.snackbar(
        "Succsess",
        response.message,
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
  void onInit() {
    price = TextEditingController();
    description = TextEditingController();
    time = TextEditingController();
    orderId = Get.arguments as int;
    super.onInit();
  }

  @override
  void onClose() {
    price.dispose();
    description.dispose();
    time.dispose();
    super.onClose();
  }
}
