import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/config/app_builder.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/core/routes/routes.dart';
import 'package:renvo_app/core/services/rest_api/api_service.dart';
import 'package:renvo_app/core/services/rest_api/constants/end_points.dart';
import 'package:renvo_app/core/services/rest_api/models/request.dart';
import 'package:renvo_app/core/services/rest_api/models/response_model.dart';
import 'package:renvo_app/core/style/repo.dart';
import 'package:renvo_app/feature/MyOrder/controller.dart';
import 'package:renvo_app/feature/MyOrder/customer/viewOfferCust/model/orderOffers.dart';

class OfferDetailsPageController extends GetxController {
  final AppBuilder appBuilder = Get.find();
  late OrderOffersModel offer;

  var isLoading = false.obs;

  @override
  void onInit() {
    offer = Get.arguments as OrderOffersModel;
    super.onInit();
  }

  Future<void> fetchAcceptOffers() async {
    final token = appBuilder.token;

    isLoading.value = true;
    ResponseModel response = await APIService.instance.request(
      Request(
        endPoint: EndPoints.offersAccept,
        method: RequestMethod.Post,
        header: {"Authorization": "Bearer $token"},
        body: {"offer_id": offer.id},
      ),
    );
    isLoading.value = false;

    if (response.success) {
      Get.snackbar(
        tr(LocaleKeys.success),
        tr(LocaleKeys.offer_is_accepted),
        backgroundColor: StyleRepo.green,
        colorText: StyleRepo.white,
        snackPosition: SnackPosition.TOP,
      );
      
      final controller = Get.find<MyOrderPageController>(tag: 'myOrderPage');
      controller.refreshAcceptOffer();
      Get.until((rout) => Pages.home.value == rout.settings.name);
    } else {
      Get.snackbar(
        tr(LocaleKeys.error),
        response.message,
        backgroundColor: StyleRepo.red,
        colorText: StyleRepo.white,
        snackPosition: SnackPosition.TOP,
      );
    }
    isLoading.value = false;
  }

  Future<void> fetchDeleteOffers() async {
    final token = appBuilder.token;

    isLoading.value = true;
    ResponseModel response = await APIService.instance.request(
      Request(
        endPoint: EndPoints.offersDelete,
        method: RequestMethod.Post,
        header: {"Authorization": "Bearer $token"},
        body: {"offer_id": offer.id},
      ),
    );
    isLoading.value = false;

    if (response.success) {
      Get.snackbar(
        tr(LocaleKeys.success),
        response.message,
        backgroundColor: StyleRepo.green,
        colorText: StyleRepo.white,
        snackPosition: SnackPosition.TOP,
      );
      Get.until((rout) => Pages.home.value == rout.settings.name);

    } else {
      Get.snackbar(
        tr(LocaleKeys.error),
        response.message,
        backgroundColor: StyleRepo.red,
        colorText: StyleRepo.white,
        snackPosition: SnackPosition.TOP,
      );
    }
    isLoading.value = false;
  }
}
