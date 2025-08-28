import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/core/style/repo.dart';
import 'package:renvo_app/feature/MyOrder/customer/viewOfferCust/CardOffer.dart';
import 'package:renvo_app/feature/MyOrder/customer/viewOfferCust/controller.dart';


class OrderOffersPage extends StatelessWidget {
  const OrderOffersPage({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderOffersPageController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: StyleRepo.transparent,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: StyleRepo.black, width: 2),
            ),
            child: Center(
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: StyleRepo.black,
                size: 20,
              ),
            ),
          ),
        ),
       
        title: Text(
          tr(LocaleKeys.view_offer),
          style: TextStyle(
            color: StyleRepo.black,
            fontSize: 20,
          ),
        ),
        titleSpacing: 0,
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.offers.value == null ||
            controller.offers.value!.isEmpty) {
          return  Center(child: Text(tr(LocaleKeys.no_offers_found)));
        }

        return ListView.separated(
          itemCount: controller.offers.value!.length,
          separatorBuilder: (_, __) => SizedBox(height: 10),
          itemBuilder: (context, index) {
            return CardOffer(orderOffer: controller.offers.value![index]);
          },
        );
      }),
    );
  }
}
