
import 'package:get/get.dart';
import 'package:renvo_app/core/config/app_builder.dart';
import 'package:renvo_app/feature/MyOrder/controller.dart';

import '../../../core/services/rest_api/rest_api.dart';

class RatingController extends GetxController {
  var rating = 3.0.obs;
  var comment = ''.obs;
  final appBuilder = Get.find<AppBuilder>();
  final myOrder = Get.find<MyOrderPageController>(tag: 'myOrderPage');
  var isLoading = false.obs;

  void setRating(double value) {
    rating.value = value;
  }

  void setComment(String value) {
    comment.value = value;
  }

  String get ratingLabel {
    if (rating.value >= 4.5) return "Excellent";
    if (rating.value >= 3.5) return "Very Good";
    if (rating.value >= 2.5) return "Good";
    if (rating.value >= 1.5) return "Bad";
    return "Poor";
  }

  void submit() {
    // Handle submission logic here
    print("Rating: ${rating.value}, Comment: ${comment.value}");
    Get.back(); // Close the bottom sheet
  }

  RateOrder(int id) async {
    isLoading.value = true;
    final token = appBuilder.token;
    ResponseModel response = await APIService.instance.request(
      Request(
        endPoint: EndPoints.ReviewOrderCustomer,
        method: RequestMethod.Post,
        header: {"Authorization": "Bearer $token"},
        body: {
          "order_id": id,
          "rate": rating.value.toInt(),
          "review": comment.value,
        },
      ),
    );
    print({"order_id": id, "rate": rating.value, "review": comment.value});
    isLoading.value = false;
    if (response.success) {
      Get.back();
      myOrder.refreshDataCompleted();
      Get.snackbar("Success", "Review sent successfully");
    } else {
      Get.snackbar("Error", "Review faild");
    }
  }
}
