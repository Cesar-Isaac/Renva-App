import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/config/app_builder.dart';
import 'package:renvo_app/core/services/pagination/controller.dart';
import 'package:renvo_app/core/services/rest_api/api_service.dart';
import 'package:renvo_app/core/services/rest_api/constants/end_points.dart';
import 'package:renvo_app/core/services/rest_api/models/request.dart';
import 'package:renvo_app/core/services/rest_api/models/response_model.dart';
import 'package:renvo_app/core/services/state_management/obs.dart';
import 'package:renvo_app/feature/profile/profile/models/get_profile.dart';
import 'package:renvo_app/feature/provider_pages/provider_home_page/models/all_order_list.dart';

class ProviderHomePageController extends GetxController {
  final AppBuilder appBuilder = Get.find();
  late final String token;
  var isLoading = false.obs;
  late int id;
  late PaginationController pagerController;

  String formatTime(String? timeStr) {
    if (timeStr == null || timeStr.isEmpty) return "-";
    try {
      final time = DateFormat.Hms().parse(timeStr);
      return DateFormat('h:mm a').format(time); 
    } catch (e) {
      return "-";
    }
  }

  ObsList<AllOrderList> getAllOrders = ObsList([]);

  ObsVar<MainProfile> profile = ObsVar(null);

  fetchProfile() async {
    isLoading.value = true;

    final response = await APIService.instance.request(
      Request(
        endPoint: EndPoints.profile,
        fromJson: MainProfile.fromJson,
        header: {"Authorization": "Bearer ${appBuilder.token}"},
      ),
    );

    if (response.success) {
      profile.value = response.data;
      id = profile.value!.id;
    } else {
      profile.error = response.message;
    }
    isLoading.value = false;
  }

  Future<ResponseModel> fetchData(int page, CancelToken cancel) async {
    ResponseModel response = await APIService.instance.request(
      Request(
        endPoint: EndPoints.show_orders,
        params: {"page": page},
        header: {"Authorization": "Bearer ${appBuilder.token}"},
        cancelToken: cancel,
      ),
    );
    return response;
  }

  refreshData() {
    pagerController.refreshData();
  }

  @override
  void onInit() {

    fetchProfile();
    super.onInit();
  }
}
