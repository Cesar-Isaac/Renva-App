
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/core/style/repo.dart';
import 'package:renvo_app/core/widgets/image.dart';
import 'package:renvo_app/feature/MyOrder/Model/orderOfferCust.dart';
import 'package:renvo_app/feature/MyOrder/Rating/controller.dart';
import 'package:renvo_app/gen/assets.gen.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class RatingBottomSheet extends StatelessWidget {
  final Provider provider;
  final int OrderId;
  const RatingBottomSheet({
    super.key,
    required this.provider,
    required this.OrderId,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RatingController());
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              tr(LocaleKeys.rating),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 16),
            AppImage(
              path:
                  provider.avatar.originalUrl.isNotEmpty == true
                      ? provider.avatar.originalUrl
                      : Assets.icons.user.path,
              type:
                  provider.avatar.originalUrl.isNotEmpty == true
                      ? ImageType.CachedNetwork
                      : ImageType.Asset,
              height: 120,
              width: 120,
              decoration: const BoxDecoration(shape: BoxShape.circle),
            ),
            SizedBox(height: 8),
            Text(
              provider.name,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
            SizedBox(height: 8),
            Obx(
              () => SmoothStarRating(
                onRatingChanged: controller.setRating, 
                starCount: 5,
                rating: controller.rating.value,
                size: 30.0,
                filledIconData: Icons.star,
                halfFilledIconData: Icons.star_half,
                color: Colors.yellow,
                borderColor: StyleRepo.softGrey,
                spacing: 2.0,
              ),
            ),
            SizedBox(height: 8),
            Obx(
              () => Text(
                controller.ratingLabel,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 5),

            Obx(
              () => Text(
                "You Rated Services Provider ${controller.rating.toInt()} STars",
              ),
            ),
            SizedBox(height: 16),
            TextField(
              onChanged: controller.setComment,
              decoration: InputDecoration(
                hintText: tr(LocaleKeys.add_your_comment),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              maxLines: 3,
            ),

            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Obx(() {
                    return controller.isLoading.value
                        ? const Center(
                          child: CircularProgressIndicator(
                            color: StyleRepo.blue,
                          ),
                        )
                        : ElevatedButton(
                          onPressed: () => controller.RateOrder(OrderId),
                          child: Text(
                            tr(LocaleKeys.done),
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                  }),
                ),
              ],
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
