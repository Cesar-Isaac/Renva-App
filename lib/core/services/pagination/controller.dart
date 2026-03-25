import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../rest_api/constants/api_error.dart';
import '../rest_api/models/response_model.dart';
import '../state_management/constants/variable_status.dart';
import '../state_management/obs.dart';

class PaginationController<T> extends GetxController {
  final Future<ResponseModel> Function(int, CancelToken cancel) fetchApi;
  final T Function(Map<String, dynamic> json) fromJson;
  double closeToListEnd;

  late ScrollController scrollController;

  PaginationController({
    required this.fromJson,
    required this.fetchApi,
    ScrollController? scrollController,
    this.closeToListEnd = 500,
  }) {
    this.scrollController = scrollController ?? ScrollController();
  }

  updateValues({ScrollController? scrollController, double? closeToListEnd}) {
    if (scrollController != null) {
      this.scrollController = scrollController;
    }
    if (closeToListEnd != null) {
      this.closeToListEnd = closeToListEnd;
    }
    log("PaginationController update the values", name: "Pager");
  }

  int currentPage = 1;

  final RxBool _isFinished = false.obs;
  bool get isFinished => _isFinished.value;
  set isFinished(value) => _isFinished.value = value;

  final RxBool _loading = false.obs;
  bool get loading => _loading.value;
  set loading(value) => _loading.value = value;

  ObsList<T> data = ObsList<T>([]);

  CancelToken? cancel;

  Completer<ResponseModel>? completer;

  /// 🔹 Listener خاص بالـ ScrollController
  void _scrollListener() {
    if (!isFinished &&
        !loading &&
        scrollController.offset >
            scrollController.position.maxScrollExtent - closeToListEnd) {
      loadData();
    }
  }

  Future<ResponseModel> loadData() async {
    // منع التحميل المزدوج
    if (loading) {
      return completer?.future ??
          Future.value(ResponseModel(success: false, data: null, message: ''));
    }

    loading = true;

    if (completer == null || completer!.isCompleted) {
      completer = Completer<ResponseModel>();
    }

    if (currentPage != 1 && !data.hasData) {
      data.status = VariableStatus.HasData;
    } else if (currentPage == 1) {
      data.status = VariableStatus.Loading;
    }

    cancel = CancelToken();

    ResponseModel response;
    try {
      response = await fetchApi(currentPage, cancel!);
    } catch (e) {
      if (!completer!.isCompleted) {
        completer!.completeError(e);
      }
      loading = false;
      rethrow;
    }

    if (!completer!.isCompleted) {
      completer!.complete(response);
    }

    if (response.success) {
      if (response.data.isEmpty) {
        isFinished = true;
        if (currentPage == 1) {
          data.value = [];
        }
      } else {
        data.valueAppend =
            (response.data as List)
                .map((element) => fromJson(element))
                .toList();
        currentPage++;

        while (!scrollController.hasClients) {
          await 100.milliseconds.delay();
        }
        if (scrollController.position.maxScrollExtent > 1) {
          scrollController.jumpTo(scrollController.offset + 0.1);
        }

        if (scrollController.offset >
                scrollController.position.maxScrollExtent - closeToListEnd &&
            !isFinished) {
          await loadData();
        }
      }
    } else if (response.errorType is CANCELED) {
      // تم الإلغاء
    } else {
      data.error = response.message;
    }

    loading = false;
    return response;
  }

  Future<void> refreshData() async {
    currentPage = 1;
    isFinished = false;
    loading = false;
    data.reset();

    if (cancel != null) {
      cancel!.cancel();
    }

    await loadData();
  }

  onInitAsync() async {
    await loadData();
    if (scrollController.hasClients) {
      // 🔹 امسح القديم ثم أضف listener جديد
      scrollController.removeListener(_scrollListener);
      scrollController.addListener(_scrollListener);
    }
  }

  @override
  void onInit() {
    onInitAsync();
    super.onInit();
  }

  @override
  void onClose() {
    if (cancel != null) cancel!.cancel();
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.onClose();
  }
}

// class PaginationController<T> extends GetxController {
//   final Future<ResponseModel> Function(int, CancelToken cancel) fetchApi;
//   final T Function(Map<String, dynamic> json) fromJson;
//   double closeToListEnd;

//   late ScrollController scrollController;

//   PaginationController({
//     required this.fromJson,
//     required this.fetchApi,
//     ScrollController? scrollController,
//     this.closeToListEnd = 500,
//   }) {
//     if (scrollController == null) {
//       this.scrollController = ScrollController();
//     } else {
//       this.scrollController = scrollController;
//     }
//   }

//   updateValues({ScrollController? scrollController, double? closeToListEnd}) {
//     if (scrollController != null) {
//       this.scrollController = scrollController;
//     }
//     if (closeToListEnd != null) {
//       this.closeToListEnd = closeToListEnd;
//     }
//     log("PaginationController update the values", name: "Pager");
//   }

//   int currentPage = 1;

//   final RxBool _isFinished = false.obs;
//   bool get isFinished => this._isFinished.value;
//   set isFinished(value) => this._isFinished.value = value;

//   final RxBool _loading = false.obs;
//   get loading => this._loading.value;
//   set loading(value) => this._loading.value = value;
//   ObsList<T> data = ObsList<T>([]);

//   CancelToken? cancel;

//   Completer<ResponseModel>? completer;

//   // Future<ResponseModel> loadData() async {
//   //   loading = true;
//   //   if (currentPage != 1 && !data.hasData) {
//   //     data.status = VariableStatus.HasData;
//   //   } else if (currentPage == 1) {
//   //     data.status = VariableStatus.Loading;
//   //   }
//   //   cancel = CancelToken();
//   //   completer = Completer();
//   //   ResponseModel response = await fetchApi(currentPage, cancel!);
//   //   completer!.complete(response);
//   //   if (response.success) {
//   //     if (response.data.isEmpty) {
//   //       isFinished = true;
//   //       loading = false;
//   //       if (currentPage == 1) {
//   //         data.value = [];
//   //         return response;
//   //       }
//   //     } else {
//   //       data.valueAppend =
//   //           (response.data as List)
//   //               .map((element) => fromJson(element))
//   //               .toList();
//   //       currentPage++;
//   //       while (!scrollController.hasClients) {
//   //         await 100.milliseconds.delay();
//   //       }
//   //       if (scrollController.position.maxScrollExtent > 1) {
//   //         scrollController.jumpTo(scrollController.offset + 0.1);
//   //       }
//   //       log(
//   //         'scrollController.offset: ${scrollController.offset}',
//   //         name: "Pager",
//   //       );
//   //       log(
//   //         'scrollController.position.maxScrollExtent: ${scrollController.position.maxScrollExtent}',
//   //         name: "Pager",
//   //       );
//   //       if (scrollController.offset >
//   //               scrollController.position.maxScrollExtent - closeToListEnd &&
//   //           !isFinished) {
//   //         await loadData();
//   //       }
//   //     }
//   //   } else if (response.errorType is CANCELED) {
//   //     return response;
//   //   } else {
//   //     data.error = response.message;
//   //   }
//   //   loading = false;
//   //   return response;
//   // }

//   // refreshData() async {
//   //   currentPage = 1;
//   //   isFinished = false;
//   //   loading = false;
//   //   data.reset();
//   //   if (cancel != null) {
//   //     cancel!.cancel();
//   //   }
//   //   await loadData();
//   // }
//   Future<ResponseModel> loadData() async {
//     // منع التحميل المزدوج
//     if (loading) {
//       return completer?.future ??
//           Future.value(ResponseModel(success: false, data: null, message: ''));
//     }

//     loading = true;

//     // إنشاء completer جديد فقط إذا لم يكن موجود أو انتهى
//     if (completer == null || completer!.isCompleted) {
//       completer = Completer<ResponseModel>();
//     }

//     if (currentPage != 1 && !data.hasData) {
//       data.status = VariableStatus.HasData;
//     } else if (currentPage == 1) {
//       data.status = VariableStatus.Loading;
//     }

//     cancel = CancelToken();

//     ResponseModel response;
//     try {
//       response = await fetchApi(currentPage, cancel!);
//     } catch (e) {
//       // تأكد من إنهاء الـ completer في حالة الخطأ
//       if (!completer!.isCompleted) {
//         completer!.completeError(e);
//       }
//       loading = false;
//       rethrow;
//     }

//     // تأكد من عمل complete مرة واحدة
//     if (!completer!.isCompleted) {
//       completer!.complete(response);
//     }

//     if (response.success) {
//       if (response.data.isEmpty) {
//         isFinished = true;
//         if (currentPage == 1) {
//           data.value = [];
//         }
//       } else {
//         data.valueAppend =
//             (response.data as List)
//                 .map((element) => fromJson(element))
//                 .toList();
//         currentPage++;

//         while (!scrollController.hasClients) {
//           await 100.milliseconds.delay();
//         }
//         if (scrollController.position.maxScrollExtent > 1) {
//           scrollController.jumpTo(scrollController.offset + 0.1);
//         }

//         if (scrollController.offset >
//                 scrollController.position.maxScrollExtent - closeToListEnd &&
//             !isFinished) {
//           await loadData(); // سيعود فورًا إذا كان loading = true
//         }
//       }
//     } else if (response.errorType is CANCELED) {
//       // لا شيء، لأنه تم الإلغاء
//     } else {
//       data.error = response.message;
//     }

//     loading = false;
//     return response;
//   }

//   Future<void> refreshData() async {
//     currentPage = 1;
//     isFinished = false;
//     loading = false;
//     data.reset();

//     if (cancel != null) {
//       cancel!.cancel();
//     }

//     await loadData();
//   }

//   onInitAsync() async {
//     await loadData();
//     if (scrollController.hasClients) {
//       scrollController.addListener(() {
//         if (!isFinished &&
//             !loading &&
//             scrollController.offset >
//                 scrollController.position.maxScrollExtent - closeToListEnd) {
//           loadData();
//         }
//       });
//     }
//   }

//   @override
//   void onInit() {
//     onInitAsync();
//     super.onInit();
//   }

//   @override
//   void onClose() {
//     if (cancel != null) cancel!.cancel();
//     scrollController.dispose();
//     super.onClose();
//   }
// }
