import 'package:get/get.dart';
import '../../core/config/app_builder.dart';
import '../../core/services/rest_api/api_service.dart';
import '../../core/services/rest_api/constants/end_points.dart';
import '../../core/services/rest_api/models/request.dart';
import '../../core/services/rest_api/models/response_model.dart';
import '../../core/services/state_management/obs.dart';
import '../home/models/all_categories.dart';

class AddOrderPageController extends GetxController {
  final selectedIndex = RxnInt(); 

  ObsList<AllCategories> categories = ObsList([]);
  final AppBuilder appBuilder = Get.find();

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
  void toggleSelection(int index) {
  if (selectedIndex.value == index) {
    selectedIndex.value = null; 
  } else {
    selectedIndex.value = index;
  }
}

bool isSelected(int index) => selectedIndex.value == index;



  @override
  void onInit() {
    fetch();
    super.onInit();
  }
}
