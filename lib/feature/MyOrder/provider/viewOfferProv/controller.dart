import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:renva/core/config/app_builder.dart';
import 'package:renva/core/localization/strings.dart';
import 'package:renva/core/routes/routes.dart';
import 'package:renva/core/services/rest_api/api_service.dart';
import 'package:renva/core/services/rest_api/constants/end_points.dart';
import 'package:renva/core/services/rest_api/models/request.dart';
import 'package:renva/core/services/rest_api/models/response_model.dart';
import 'package:renva/feature/MyOrder/Model/orderOfferCust.dart';
import 'package:renva/feature/MyOrder/controller.dart';

class OfferDetailsProviderPageController extends GetxController {
  late provider_offer offer;
  late bool isDelete;

  final AppBuilder appBuilder = Get.find();
  late final args;
  final myOrder = Get.find<MyOrderPageController>(tag: 'myOrderPage');

  @override
  void onInit() {
    args = Get.arguments as Map;
    offer = args['offer'] as provider_offer;
    isDelete = args['isDelete'] as bool;

    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  DeleteOffer(int id) async {
    ResponseModel response = await APIService.instance.request(
      Request(
        endPoint: EndPoints.delete_order_prov(id),
        method: RequestMethod.Delete,
      ),
    );
    if (response.success) {
      Get.until((route) => route.settings.name == Pages.home.value);
      myOrder.refreshDataProvWating();

      Get.snackbar("Success", "Offer Deleted");
    } else {
      Get.snackbar("Error", "Deleted faild");
    }
  }

  DeclineOffer(int id) async {
    ResponseModel response = await APIService.instance.request(
      Request(
        endPoint: EndPoints.offersDelete,
        method: RequestMethod.Post,
        body: {"offer_id": id},
      ),
    );
    if (response.success) {
      Get.until((route) => route.settings.name == Pages.home.value);
      await myOrder.pagerControllerwaiting.refreshData();

      Get.snackbar("Success", " Offer Decline");
    } else {
      Get.snackbar("Error", "Decline offer faild");
    }
  }

  void AcceptOffer(int id) async {
    String? token = appBuilder.token;
    ResponseModel response = await APIService.instance.request(
      Request(
        endPoint: EndPoints.offersAccept,
        method: RequestMethod.Post,
        header: {"Authorization": "Bearer $token"},
        body: {"offer_id": id},
      ),
    );

    if (response.success) {
      Get.until((route) => route.settings.name == Pages.home.value);
      await myOrder.pagerControllerProccesing.refreshData();
      await myOrder.pagerControllerwaiting.refreshData();
      Get.snackbar(tr(LocaleKeys.success), "The offer was accepted");
    } else {
      Get.snackbar(tr(LocaleKeys.error), "The offer not accepted");
    }
  }
}
