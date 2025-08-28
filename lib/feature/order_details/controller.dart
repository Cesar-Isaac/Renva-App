
import 'package:get/get.dart';
import 'package:renvo_app/core/config/app_builder.dart';

import 'package:renvo_app/core/services/state_management/obs.dart';
import 'package:renvo_app/feature/provider_pages/provider_home_page/models/all_order_list.dart';

class OrderDetailsController extends GetxController {
  final AppBuilder appBuilder = Get.find();
  late AllOrderList Order;

  ObsVar<AllOrderList> order = ObsVar(null);
  var isLoading = false.obs;



  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
