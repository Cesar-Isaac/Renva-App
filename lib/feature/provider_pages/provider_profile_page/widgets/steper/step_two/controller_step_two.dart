import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/config/app_builder.dart';
import 'package:renvo_app/core/services/rest_api/api_service.dart';
import 'package:renvo_app/core/services/rest_api/constants/end_points.dart';
import 'package:renvo_app/core/services/rest_api/models/request.dart';
import 'package:renvo_app/core/services/rest_api/models/response_model.dart';

import 'package:renvo_app/core/services/state_management/obs.dart';
import 'package:renvo_app/feature/home/models/all_categories.dart';

class ControllerStepTwo extends GetxController {
  final AppBuilder appBuilder = Get.find();
  final RxSet<int> selectedCategoryIds = <int>{}.obs;
  final formKeyStep2 = GlobalKey<FormState>();

  void toggleSelection(int id) {
    if (selectedCategoryIds.contains(id)) {
      selectedCategoryIds.remove(id);
    } else {
      selectedCategoryIds.add(id);
    }
  }

  ObsList<AllCategories> categories = ObsList([]);

  fetch() async {
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

  @override
  void onInit() {
    fetch();

    super.onInit();
  }
}
