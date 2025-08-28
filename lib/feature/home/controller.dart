import 'package:get/get.dart';

import '../../core/config/app_builder.dart';
import '../../core/services/rest_api/api_service.dart';
import '../../core/services/rest_api/constants/end_points.dart';
import '../../core/services/rest_api/models/request.dart';
import '../../core/services/rest_api/models/response_model.dart';
import '../../core/services/state_management/obs.dart';
import 'models/all_categories.dart';

class HomePageController extends GetxController {
  ObsList<AllCategories> categories = ObsList([]);
  var isLoading = false.obs;
  final AppBuilder appBuilder = Get.find();
  fetch() async {
    final token = appBuilder.token;
    ResponseModel response = await APIService.instance.request(
      Request(
        endPoint: EndPoints.categories,
        fromJson: AllCategories.fromJson,
        header: {
          "Authorization": "Bearer $token",
        },
      ),
    );

    if (response.success) {
      categories.value = response.data;
    }else{
      categories.error = response.message;
    }
  }
  @override
  void onInit() {
    
    fetch();
    super.onInit();
  }
}

