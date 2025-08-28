import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/config/app_builder.dart';
import 'package:renvo_app/core/services/pagination/controller.dart';
import 'package:renvo_app/core/services/rest_api/api_service.dart';
import 'package:renvo_app/core/services/rest_api/constants/end_points.dart';
import 'package:renvo_app/core/services/rest_api/models/request.dart';
import 'package:renvo_app/core/services/rest_api/models/response_model.dart';
import 'package:renvo_app/core/services/state_management/obs.dart';
import 'package:renvo_app/core/style/repo.dart';
import 'package:renvo_app/feature/MyOrder/Model/orderOfferCust.dart';
import 'package:renvo_app/feature/MyOrder/Model/orderOfferrProv.dart';
import 'package:renvo_app/feature/MyOrder/widgets/order_status.dart';

//WidgetsBindingObserver
class MyOrderPageController extends GetxController
    with GetTickerProviderStateMixin, WidgetsBindingObserver {
  ObsList<OrderOfferProvModel> providerOrders = ObsList([]);
  ObsList<OrderOfferCustModel> customerOrders = ObsList([]);

  final AppBuilder appBuilder = Get.find();
  late PaginationController pagerControllerwaiting,
      pagerControllerwaitingProv,
      pagerControllerProccesing,
      pagerControllerProccesingProv,
      pagerControllerCompleted,
      pagerControllerCompletedProv,
      pagerControllerCanceld,
      pagerControllerCanceldProv;

  var isLoading = false.obs;
  RxInt loadingOrderId = (-1).obs; 

  

  Future<ResponseModel> fetchDataWaiting(int page, CancelToken cancel) async {
    ResponseModel response = await APIService.instance.request(
      Request(
        
        endPoint:
            appBuilder.isProviderMode.value == true
                ? EndPoints.orderOffer
                : EndPoints.orderCust,

        params: {
          "page": page,
          
          "status": "waiting",
        },
        cancelToken: cancel,
      ),
    );
    

    return response;
  }

  Future<ResponseModel> fetchDataProcessing(
    int page,
    CancelToken cancel,
  ) async {
    ResponseModel response = await APIService.instance.request(
      Request(
        endPoint:
            appBuilder.isProviderMode.value == true
                ? EndPoints.orderOffer
                : EndPoints.orderCust,

        
        params: {
          "page": page,
          
          "status": "processing",
        },
        cancelToken: cancel,
      ),
    );
    return response;
  }

  Future<ResponseModel> fetchDataCompleted(int page, CancelToken cancel) async {
    ResponseModel response = await APIService.instance.request(
      Request(
        
        endPoint:
            appBuilder.isProviderMode.value == true
                ? EndPoints.orderOffer
                : EndPoints.orderCust,
        params: {
          "page": page, "status": "completed",
        },
        cancelToken: cancel,
      ),
    );
    return response;
  }

  Future<ResponseModel> fetchDataCancelled(int page, CancelToken cancel) async {
    ResponseModel response = await APIService.instance.request(
      Request(
        endPoint:
            appBuilder.isProviderMode.value == true
                ? EndPoints.orderOffer
                : EndPoints.orderCust,

        params: {
          "page": page, "status": "cancelled",
        },
        cancelToken: cancel,
      ),
    );
    return response;
  }

  Future<ResponseModel> fetchDataCustWaiting(
    int page,
    CancelToken cancel,
  ) async {
    ResponseModel response = await APIService.instance.request(
      Request(
        endPoint:
            appBuilder.isProviderMode.value == true
                ? EndPoints.orderOffer
                : EndPoints.orderCust,
        params: {"page": page, "status": "waiting", "flagged_order": 1},
        cancelToken: cancel,
      ),
    );
    return response;
  }

  Future<ResponseModel> fetchDataCustProcessing(
    int page,
    CancelToken cancel,
  ) async {
    ResponseModel response = await APIService.instance.request(
      Request(
        endPoint:
            appBuilder.isProviderMode.value == true
                ? EndPoints.orderOffer
                : EndPoints.orderCust,
        params: {"page": page, "status": "processing", "flagged_order": 2},
        cancelToken: cancel,
      ),
    );
    return response;
  }

  Future<ResponseModel> fetchDataCustCompleted(
    int page,
    CancelToken cancel,
  ) async {
    ResponseModel response = await APIService.instance.request(
      Request(
        endPoint:
            appBuilder.isProviderMode.value == true
                ? EndPoints.orderOffer
                : EndPoints.orderCust,
        params: {"page": page, "status": "completed", "flagged_order": 3},
        cancelToken: cancel,
      ),
    );
    return response;
  }

  Future<ResponseModel> fetchDataCustCancelled(
    int page,
    CancelToken cancel,
  ) async {
    ResponseModel response = await APIService.instance.request(
      Request(
        endPoint:
            appBuilder.isProviderMode.value == true
                ? EndPoints.orderOffer
                : EndPoints.orderCust,

        params: {"page": page, "status": "cancelled", "flagged_order": 4},
        cancelToken: cancel,
      ),
    );
    return response;
  }

  
  Future<void> refreshAllPagers() async {
    await Future.wait([
      pagerControllerwaiting.refreshData(),
      pagerControllerwaitingProv.refreshData(),
      pagerControllerProccesing.refreshData(),
      pagerControllerProccesingProv.refreshData(),
      pagerControllerCompleted.refreshData(),
      pagerControllerCompletedProv.refreshData(),
      pagerControllerCanceld.refreshData(),
      pagerControllerCanceldProv.refreshData(),
    ]);
  }

  Future<void> refreshDataWating() async {
    await Future.wait([pagerControllerwaiting.refreshData()]);
  }

  Future<void> refreshDataProvWating() async {
    await Future.wait([pagerControllerwaitingProv.refreshData()]);
  }

  Future<void> refreshDataProccesing() async {
    await Future.wait([pagerControllerProccesing.refreshData()]);
  }

  Future<void> refreshDataProvProccesing() async {
    await Future.wait([pagerControllerProccesingProv.refreshData()]);
  }

  Future<void> refreshDataCompleted() async {
    await Future.wait([pagerControllerCompleted.refreshData()]);
  }

  Future<void> refreshDataProvCompleted() async {
    await Future.wait([pagerControllerCompletedProv.refreshData()]);
  }

  Future<void> refreshDataCanceld() async {
    await Future.wait([pagerControllerCanceld.refreshData()]);
  }

  Future<void> refreshDataProvCanceld() async {
    await Future.wait([pagerControllerCanceldProv.refreshData()]);
  }

  Future<void> refreshAcceptOffer() async {
    await Future.wait([
      pagerControllerwaiting.refreshData(),
      pagerControllerProccesing.refreshData(),
    ]);
  }

  Future<void> refreshCompleteOffer() async {
    await Future.wait([
      pagerControllerProccesingProv.refreshData(),
      pagerControllerCompletedProv.refreshData(),
    ]);
  }

  deleteOrderCust(int id) async {
    isLoading.value = true;
    ResponseModel response = await APIService.instance.request(
      Request(
        endPoint: EndPoints.delete_order_cust(id),
        method: RequestMethod.Delete,
      ),
    );
    isLoading.value = false;
    if (response.success) {
      pagerControllerwaiting.refreshData();
      Get.snackbar(
        "Success",
        response.message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: StyleRepo.green,
        colorText: StyleRepo.white,
      );
    } else {
      Get.snackbar(
        "Error",
        response.message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: StyleRepo.red,
        colorText: StyleRepo.white,
      );
    }
  }

  DeleteOffer(int id) async {
    ResponseModel response = await APIService.instance.request(
      Request(
        endPoint: EndPoints.delete_order_prov(id),
        method: RequestMethod.Delete,
      ),
    );
    if (response.success) {
      // refreshDataProvWating();
      pagerControllerwaitingProv.refreshData();

      Get.snackbar("Success", "Offer Deleted");
    } else {
      Get.snackbar("Error", "Deleted faild");
    }
  }


  late TabController tabController;
  var rating = 0.obs;

  void setRating(int value) {
    rating.value = value;
  }

  EndOrder(int id) async {
    loadingOrderId.value = id;
    ResponseModel response = await APIService.instance.request(
      Request(
        endPoint: EndPoints.EndOrder,
        method: RequestMethod.Post,
        body: {"order_id": id},
      ),
    );
    loadingOrderId.value = -1;
    if (response.success) {
      refreshCompleteOffer();

      Get.snackbar(
        "Success",
        "Finish Success",
        snackPosition: SnackPosition.TOP,
        backgroundColor: StyleRepo.green,
        colorText: StyleRepo.white,
      );
      
    } else {
      Get.snackbar("Error", "Finish faild");
    }
  }

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    tabController = TabController(
      length: StatusOrder.values.length,
      vsync: this,
    );
   

    pagerControllerwaitingProv = PaginationController<OrderOfferProvModel>(
      fromJson: (json) => OrderOfferProvModel.fromJson(json),
      fetchApi: fetchDataWaiting,
    );

    pagerControllerProccesingProv = PaginationController<OrderOfferProvModel>(
      fromJson: (json) => OrderOfferProvModel.fromJson(json),
      fetchApi: fetchDataProcessing,
    );

    pagerControllerCompletedProv = PaginationController<OrderOfferProvModel>(
      fromJson: (json) => OrderOfferProvModel.fromJson(json),
      fetchApi: fetchDataCompleted,
    );

    pagerControllerCanceldProv = PaginationController<OrderOfferProvModel>(
      fromJson: (json) => OrderOfferProvModel.fromJson(json),
      fetchApi: fetchDataCancelled,
    );

    pagerControllerwaiting = PaginationController<OrderOfferProvModel>(
      fromJson: (json) => OrderOfferProvModel.fromJson(json),
      fetchApi: fetchDataCustWaiting,
    );

    pagerControllerProccesing = PaginationController<OrderOfferProvModel>(
      fromJson: (json) => OrderOfferProvModel.fromJson(json),
      fetchApi: fetchDataCustProcessing,
    );

    pagerControllerCompleted = PaginationController<OrderOfferProvModel>(
      fromJson: (json) => OrderOfferProvModel.fromJson(json),
      fetchApi: fetchDataCustCompleted,
    );

    pagerControllerCanceld = PaginationController<OrderOfferProvModel>(
      fromJson: (json) => OrderOfferProvModel.fromJson(json),
      fetchApi: fetchDataCustCancelled,
    );
    super.onInit();
  }


  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      debugPrint(
        "APP RESUMED → re-init pagers & refresh...",
      ); 
      pagerControllerwaiting.refreshData();
      pagerControllerwaitingProv.refreshData();
      pagerControllerProccesing.refreshData();
      pagerControllerProccesingProv.refreshData();
      pagerControllerCompleted.refreshData();
      pagerControllerCompletedProv.refreshData();
      pagerControllerCanceld.refreshData();
      pagerControllerCanceldProv.refreshData();
    }
  }
}
