import 'package:get/get.dart';
import 'package:renvo_app/core/config/app_builder.dart';

import 'package:renvo_app/core/services/rest_api/api_service.dart';
import 'package:renvo_app/core/services/rest_api/constants/end_points.dart';
import 'package:renvo_app/core/services/rest_api/models/request.dart';
import 'package:renvo_app/core/services/rest_api/models/response_model.dart';
import 'package:renvo_app/core/services/state_management/obs.dart';
import 'package:renvo_app/feature/MyOrder/customer/viewOfferCust/model/orderOffers.dart';

class OrderOffersPageController extends GetxController {
  final AppBuilder appBuilder = Get.find();
  late int orderId;
  var isLoading = false.obs;

  ObsList<OrderOffersModel> offers = ObsList([]);

  @override
  void onInit() {
    orderId = Get.arguments as int;

    fetchOrderOffers();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> fetchOrderOffers() async {
    final token = appBuilder.token;

    isLoading.value = true;
    ResponseModel response = await APIService.instance.request(
      Request(
        endPoint: EndPoints.orderOffers(orderId),
        fromJson: OrderOffersModel.fromJson,

        header: {
          "Authorization": "Bearer $token",
          "Accept":"application/json",
          

          },
      ),
    );
    isLoading.value = false;

    if (response.success) {
      if (response.data != null) {
        offers.value = response.data;
        isLoading.value = false;
      }
    } else {
      isLoading.value = false;
      offers.error = response.message;
      Get.snackbar("Error", response.message);
    }
  }
}
