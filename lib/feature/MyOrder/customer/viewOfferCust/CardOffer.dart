import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/core/routes/routes.dart';
import 'package:renvo_app/core/style/repo.dart';
import 'package:renvo_app/core/widgets/image.dart';
import 'package:renvo_app/feature/MyOrder/customer/viewOfferCust/controller.dart';
import 'package:renvo_app/feature/MyOrder/customer/viewOfferCust/model/orderOffers.dart';
import 'package:renvo_app/gen/assets.gen.dart';

class CardOffer extends StatelessWidget {
  final OrderOffersModel orderOffer;
  const CardOffer({super.key, required this.orderOffer});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrderOffersPageController>();
    return Card(
      color: StyleRepo.softGrey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(3, 16, 3, 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: StyleRepo.white,
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 80),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              orderOffer.provider.name,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 2),
                          ],
                        ),
                      ),
                      Text(
                        "${orderOffer.price} SEK",
                        style: Theme.of(
                          context,
                        ).textTheme.titleSmall?.copyWith(color: StyleRepo.blue),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const Icon(Icons.location_pin, color: Colors.grey),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          orderOffer.provider.address?.title ?? "No Address",
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(color: StyleRepo.deepGrey),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.toNamed(
                              Pages.offerDetails.value,
                              arguments: orderOffer,
                            );
                          },
                          child: Text(
                            tr(LocaleKeys.details),
                            style: TextStyle(color: StyleRepo.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ],
              ),
            ),
          ),
          PositionedDirectional(
            top: 8,
            start: 25,
            child: Container(
              child:
                  orderOffer.provider.avatar.originalUrl.isNotEmpty
                      ? AppImage(
                        path: orderOffer.provider.avatar.originalUrl,
                        type: ImageType.CachedNetwork,
                        height: 64,
                        width: 64,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                      )
                      : AppImage(
                        path: Assets.icons.user.path,
                        type: ImageType.Asset,
                        height: 64,
                        width: 64,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
