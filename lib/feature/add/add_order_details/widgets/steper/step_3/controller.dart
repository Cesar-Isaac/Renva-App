import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:dio/dio.dart';

import '../../../../../../core/config/app_builder.dart';
import '../../../../../../core/routes/routes.dart';
import '../../../../../../core/services/rest_api/api_service.dart';
import '../../../../../../core/services/rest_api/constants/end_points.dart';
import '../../../../../../core/services/rest_api/models/request.dart';
import '../../../../../../core/style/repo.dart';
import '../../../../../MyOrder/controller.dart';
import '../../../../../home/models/all_categories.dart';
import '../../../models/sub_categories.dart';
import '../step_1/controller.dart';
import '../step_2/controller.dart';


class ControllerStep3 extends GetxController {
  final RxString formattedServiceType = ''.obs;
  final RxString formattedDate = ''.obs;
  final RxString formattedTime = ''.obs;
  final controllerStepTwo = Get.put(ControllerStep2());
  final controllerStepOne = Get.put(ControllerStep1());
  final MyOrderController = Get.put(
    MyOrderPageController(),
    tag: 'myOrderPage',
  );

  late final AllCategories category;
  late final SubCategories subCategory;

  late final int id;
  final AppBuilder appBuilder = Get.find();
  final RxSet<int> selectedIndexes = <int>{}.obs;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments as Map;
    category = AllCategories.fromJson(args["category"]);
    subCategory = SubCategories.fromJson(args["subCategoryId"]);

    ever(controllerStepOne.selectedType, (type) {
      formattedServiceType.value = _mapServiceTypeToString(type);
    });

    ever(controllerStepOne.selectedDate, (date) {
      formattedDate.value =
          date != null
              ? DateFormat('dd - EEE - yyyy', 'en_US').format(date)
              : "Not selected";
    });

    ever(controllerStepOne.selectedTime, (time) {
      if (time != null) {
        final now = DateTime.now();
        final dt = DateTime(
          now.year,
          now.month,
          now.day,
          time.hour,
          time.minute,
        );
        formattedTime.value = DateFormat('HH : mm', 'en_US').format(dt);
      } else {
        formattedTime.value = "Not selected";
      }
    });

    // init first time
    formattedServiceType.value = _mapServiceTypeToString(controllerStepOne.selectedType.value);
    formattedDate.value =
    controllerStepOne.selectedDate.value != null
            ? DateFormat('dd - EEE - yyyy', 'en_US').format(controllerStepOne.selectedDate.value!)
            : "Not selected";
    if (controllerStepOne.selectedTime.value != null) {
      final now = DateTime.now();
      final dt = DateTime(
        now.year,
        now.month,
        now.day,
        controllerStepOne.selectedTime.value!.hour,
        controllerStepOne.selectedTime.value!.minute,
      );
      formattedTime.value = DateFormat('HH : mm', 'en_US').format(dt);
    } else {
      formattedTime.value = "Not selected";
    }
  }

  String _mapServiceTypeToString(ServiceType type) {
    switch (type) {
      case ServiceType.asap:
        return "As soon as possible";
      case ServiceType.specificDate:
        return "Specific Date";
    }
  }

Future<void> addOrder() async {
  controllerStepOne.isLoading.value = true;
  final token = appBuilder.token;

  final isScheduled = controllerStepOne.selectedType.value == ServiceType.specificDate;
  final isAsap = controllerStepOne.selectedType.value == ServiceType.asap;

  String? startAt;
  String? endAt;
  String? dateValue;

  if (isScheduled &&
      controllerStepOne.selectedDate.value != null &&
      controllerStepOne.selectedTime.value != null) {
    // specific date
    final dt = DateTime(
      controllerStepOne.selectedDate.value!.year,
      controllerStepOne.selectedDate.value!.month,
      controllerStepOne.selectedDate.value!.day,
      controllerStepOne.selectedTime.value!.hour,
      controllerStepOne.selectedTime.value!.minute,
    );
    dateValue = DateFormat('yyyy-MM-dd', 'en_US').format(controllerStepOne.selectedDate.value!);
    startAt = DateFormat('HH:mm:ss', 'en_US').format(dt);
    endAt = DateFormat('HH:mm:ss', 'en_US').format(
      dt.add(const Duration(hours: 2)),
    );
  } else if (isAsap) {
    // as soon as possible
    final now = DateTime.now();
    dateValue = DateFormat('yyyy-MM-dd', 'en_US').format(now);
    startAt = DateFormat('HH:mm:ss', 'en_US').format(now);
    endAt = DateFormat('HH:mm:ss', 'en_US').format(
      now.add(const Duration(hours: 2)),
    );
  }

  Map<String, dynamic> map = {
    "description": controllerStepOne.description.text,
    "type": isAsap ? "immediately" : "none_immediately",
    "date": (isScheduled || isAsap) ? dateValue : "",
    "start_at": (isScheduled || isAsap) ? startAt : "",
    "end_at": (isScheduled || isAsap) ? endAt : "",

    "main_category_id": category.id,

    "min_price": controllerStepTwo.priceRange.value.start.toStringAsFixed(0),
    "max_price": controllerStepTwo.priceRange.value.end.toStringAsFixed(0),

    "address_lat": 32.000,
    "address_long": 24.5555,
    "address_title": "Damascuse",
    "address_id": 1,
    "prv_category_id": subCategory.id,
  };

  
  for (int i = 0; i < controllerStepTwo.uploadedPhotos.length; i++) {
    map["gallery[$i]"] = await MultipartFile.fromFile(
      controllerStepTwo.uploadedPhotos[i].path,
      filename: "gallery_$i.jpg",
    );
  }

  debugPrint("=== response data ===");
  map.forEach((key, value) {
    if (value is MultipartFile) {
      debugPrint('$key: MultipartFile(filename: ${value.filename})');
    } else {
      debugPrint('$key: $value');
    }
  });
  debugPrint("===================");

  final response = await APIService.instance.request(
    Request(
      endPoint: EndPoints.orders,
      method: RequestMethod.Post,
      header: {"Authorization": "Bearer $token"},
      body: FormData.fromMap(map),
    ),
  );

  controllerStepOne.isLoading.value = false;

  if (response.success) {
    Get.snackbar(
      "Success",
      "Your Order is Added",
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    MyOrderController.pagerControllerwaiting.refreshData();
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



}





