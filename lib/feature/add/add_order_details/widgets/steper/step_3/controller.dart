import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:dio/dio.dart';
import 'package:renvo_app/core/config/app_builder.dart';
import 'package:renvo_app/core/routes/routes.dart';
import 'package:renvo_app/core/services/rest_api/api_service.dart';
import 'package:renvo_app/core/services/rest_api/constants/end_points.dart';
import 'package:renvo_app/core/services/rest_api/models/request.dart';
import 'package:renvo_app/core/style/repo.dart';
import 'package:renvo_app/feature/MyOrder/controller.dart';
import 'package:renvo_app/feature/add/add_order_details/models/sub_categories.dart';
import 'package:renvo_app/feature/add/add_order_details/widgets/steper/step_1/controller.dart';
import 'package:renvo_app/feature/add/add_order_details/widgets/steper/step_2/controller.dart';
import 'package:renvo_app/feature/home/models/all_categories.dart';

class ControllerStep3 extends ControllerStep2 {
  final RxString formattedServiceType = ''.obs;
  final RxString formattedDate = ''.obs;
  final RxString formattedTime = ''.obs;
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

    ever(selectedType, (type) {
      formattedServiceType.value = _mapServiceTypeToString(type);
    });

    ever(selectedDate, (date) {
      formattedDate.value =
          date != null
              ? DateFormat('dd - EEE - yyyy', 'en_US').format(date)
              : "Not selected";
    });

    ever(selectedTime, (time) {
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
    formattedServiceType.value = _mapServiceTypeToString(selectedType.value);
    formattedDate.value =
        selectedDate.value != null
            ? DateFormat('dd - EEE - yyyy', 'en_US').format(selectedDate.value!)
            : "Not selected";
    if (selectedTime.value != null) {
      final now = DateTime.now();
      final dt = DateTime(
        now.year,
        now.month,
        now.day,
        selectedTime.value!.hour,
        selectedTime.value!.minute,
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
  isLoading.value = true;
  final token = appBuilder.token;

  final isScheduled = selectedType.value == ServiceType.specificDate;
  final isAsap = selectedType.value == ServiceType.asap;

  String? startAt;
  String? endAt;
  String? dateValue;

  if (isScheduled &&
      selectedDate.value != null &&
      selectedTime.value != null) {
    // specific date
    final dt = DateTime(
      selectedDate.value!.year,
      selectedDate.value!.month,
      selectedDate.value!.day,
      selectedTime.value!.hour,
      selectedTime.value!.minute,
    );
    dateValue = DateFormat('yyyy-MM-dd', 'en_US').format(selectedDate.value!);
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
    "description": description.text,
    "type": isAsap ? "immediately" : "none_immediately",
    "date": (isScheduled || isAsap) ? dateValue : "",
    "start_at": (isScheduled || isAsap) ? startAt : "",
    "end_at": (isScheduled || isAsap) ? endAt : "",

    "main_category_id": category.id,

    "min_price": priceRange.value.start.toStringAsFixed(0),
    "max_price": priceRange.value.end.toStringAsFixed(0),

    "address_lat": 32.000,
    "address_long": 24.5555,
    "address_title": "Damascuse",
    "address_id": 1,
    "prv_category_id": subCategory.id,
  };

  
  for (int i = 0; i < uploadedPhotos.length; i++) {
    map["gallery[$i]"] = await MultipartFile.fromFile(
      uploadedPhotos[i].path,
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

  isLoading.value = false;

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





