import 'package:get/get.dart';
import 'package:renvo_app/core/config/app_builder.dart';
import 'package:renvo_app/core/services/rest_api/api_service.dart';
import 'package:renvo_app/core/services/rest_api/constants/end_points.dart';
import 'package:renvo_app/core/services/rest_api/models/request.dart';
import 'package:renvo_app/core/services/rest_api/models/response_model.dart';
import 'package:renvo_app/core/services/state_management/obs.dart';
import 'package:renvo_app/feature/add/add_order_details/models/sub_categories.dart';
import 'package:renvo_app/feature/home/models/all_categories.dart';

class AddOrderDetailsController extends GetxController {
  late final AllCategories category;
  final AppBuilder appBuilder = Get.find();

  
  ObsList<SubCategories> subCategories = ObsList([]);

  
  Rxn<SubCategories> selectedSubCategory = Rxn<SubCategories>();

  late final int id;

  @override
  void onInit() {
    final args = Get.arguments as Map;
    category = args["category"] as AllCategories;
    id = category.id!;
    fetch();
    super.onInit();
  }

  var selectedSubCategories = <SubCategories>[].obs;


  void selectSubCategory(SubCategories item) {
  if (selectedSubCategories.contains(item)) {
    selectedSubCategories.remove(item);
  } else {
    selectedSubCategories.add(item);
  }
}

  bool isSelected(SubCategories item) {
  return selectedSubCategories.contains(item);
}

  Future<void> fetch() async {
    final token = appBuilder.token;
    ResponseModel response = await APIService.instance.request(
      Request(
        endPoint: EndPoints.sub_categories(id),
        header: {"Authorization": "Bearer $token",},
      ),
    );

    if (response.success) {
      
      List<dynamic> rawList = response.data;
      subCategories.value =
          rawList.map((e) => SubCategories.fromJson(e)).toList();
    } else {
      subCategories.error = response.message;
    }
  }
}
