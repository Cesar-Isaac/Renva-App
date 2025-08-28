// rating_controller.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:renvo_app/core/config/app_builder.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/core/services/rest_api/api_service.dart';
import 'package:renvo_app/core/services/rest_api/constants/end_points.dart';
import 'package:renvo_app/core/services/rest_api/models/request.dart';
import 'package:renvo_app/core/services/rest_api/models/response_model.dart';
import 'package:renvo_app/core/services/state_management/obs.dart';
import 'package:renvo_app/feature/MyOrder/CancelOrder/Model/CancelReasonModel.dart';
import 'package:renvo_app/feature/MyOrder/controller.dart';

class CancelController extends GetxController {
  ObsList<CancelReasonModel> resson = ObsList([]);
  final formKey = GlobalKey<FormState>();
  final appBuilder = Get.find<AppBuilder>();
  final MyOrderController = Get.find<MyOrderPageController>(tag: 'myOrderPage');
  var selectedReasonId = RxnInt();
  var isLoading = false.obs;

  RxBool Change_my_mind = false.obs;
  RxBool no_longer_need_the_service = false.obs;
  RxBool did_not_respond = false.obs;
  RxBool prices_are_high = false.obs;

  void onInit() {
    fetchCancelReasons();
    super.onInit();
  }

  Future<void> fetchCancelReasons() async {
    final token = appBuilder.token;
    ResponseModel response = await APIService.instance.request(
      Request(
        endPoint: EndPoints.CancelReason,
        fromJson: CancelReasonModel.fromJson,
        header: {"Authorization": "Bearer $token"},
        params: {
          "type":
              appBuilder.isProviderMode.value == true
                  ? "provider"
                  : " customer",
        },
      ),
    );

    if (response.success) {
      if (response.data != null) {
        resson.value = response.data;
      }
    } else {
      resson.error = response.errorType;
      Get.snackbar("Error", response.message);
    }
  }

  void CancelOrderCust(id) async {
    if (!formKey.currentState!.validate()) return;
    final token = appBuilder.token;

    isLoading.value = true;
    ResponseModel response = await APIService.instance.request(
      Request(
        endPoint: EndPoints.cancelOrderCust,
        method: RequestMethod.Post,
        header: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
          "Content-Type": "application/json",
        },

        body: {
          "order_id": id,
          "order_cancel_reason_id": selectedReasonId.value,
        },
      ),
    );
    print("Cansel Order: id: ${id} reason id : ${selectedReasonId.value}");
    isLoading.value = false;
    if (response.success) {
      MyOrderController.pagerControllerProccesing.refreshData();
      MyOrderController.pagerControllerCanceld.refreshData();
      Get.back();
      Get.snackbar(tr(LocaleKeys.success), "This Service is canceled ");
    } else {
      Get.snackbar(tr(LocaleKeys.error), response.message);
    }
  }

  void CancelOrderProv(id) async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;
    final token = appBuilder.token;

    ResponseModel response = await APIService.instance.request(
      Request(
        endPoint: EndPoints.cancelOrderProv,
        method: RequestMethod.Post,
        header: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
          "Content-Type": "application/json",
        },

        body: {
          "order_id": id,
          "order_cancel_reason_id": selectedReasonId.value,
        },
      ),
    );
    print("Cansel Offer: id: ${id} , reason id : ${selectedReasonId.value}");
    isLoading.value = false;
    if (response.success) {
      Get.back();
      MyOrderController.pagerControllerProccesingProv.refreshData();
      MyOrderController.pagerControllerCanceldProv.refreshData();

      Get.snackbar(tr(LocaleKeys.success), "This Service is canceled ");
    } else {
      Get.snackbar(tr(LocaleKeys.error), response.message);
    }
  }
}
