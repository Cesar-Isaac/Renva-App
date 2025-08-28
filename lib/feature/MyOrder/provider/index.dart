import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/core/style/repo.dart';
import 'package:renvo_app/core/widgets/image.dart';
import 'package:renvo_app/feature/MyOrder/Rating/widgets/rating_stars.dart';

import 'package:renvo_app/feature/MyOrder/provider/viewOfferProv/controller.dart';
import 'package:renvo_app/gen/assets.gen.dart';

class MyOffersPage extends StatelessWidget {
  const MyOffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OfferDetailsProviderPageController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StyleRepo.white,
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
          tr(LocaleKeys.offer_details),
          style: TextStyle(
            color: StyleRepo.black,
            fontSize: 20,
          ),
        ),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                controller.offer.provider!.avatar.originalUrl.isNotEmpty
                    ? AppImage(
                      path: controller.offer.provider!.avatar.originalUrl,
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
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.offer.provider!.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    (controller.offer.provider?.rate != null &&
                            controller.offer.provider!.rate! > 0)
                        ? RatingStars(
                          rating: controller.offer.provider!.rate!.toDouble(),
                        )
                        : SizedBox.shrink(),
                    SizedBox(width: 10),
                  ],
                ),
                SizedBox(width: 25),
              ],
            ),

            SizedBox(height: 20),
            Text(tr(LocaleKeys.picture), style: Theme.of(context).textTheme.labelLarge),
            SizedBox(height: 10),

            controller.offer.gallery.isNotEmpty
                ? Container(
                  padding: const EdgeInsets.all(5),
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          controller.offer.gallery.asMap().entries.map((entry) {
                            int index = entry.key;
                            var item = entry.value;

                            return Padding(
                              padding: const EdgeInsets.only(right: 13),
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder:
                                        (_) => Dialog(
                                          backgroundColor: Colors.black,
                                          insetPadding: EdgeInsets.zero,
                                          child: PhotoViewGallery.builder(
                                            itemCount:
                                                controller.offer.gallery.length,
                                            pageController: PageController(
                                              initialPage: index,
                                            ),
                                            builder: (context, i) {
                                              return PhotoViewGalleryPageOptions(
                                                imageProvider: NetworkImage(
                                                  controller
                                                      .offer
                                                      .gallery[i]
                                                      .originalUrl,
                                                ),
                                                heroAttributes:
                                                    PhotoViewHeroAttributes(
                                                      tag:
                                                          controller
                                                              .offer
                                                              .gallery[i]
                                                              .uuid ??
                                                          '$i',
                                                    ),
                                              );
                                            },
                                            backgroundDecoration:
                                                const BoxDecoration(
                                                  color: Colors.black,
                                                ),
                                          ),
                                        ),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: AppImage(
                                    path: item.originalUrl,
                                    type: ImageType.CachedNetwork,
                                    fit: BoxFit.cover,
                                    width: 80,
                                    height: 80,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                )
                :  Text(tr(LocaleKeys.no_photos_uploaded)),

            Text(tr(LocaleKeys.description), style: Theme.of(context).textTheme.labelLarge),
            SizedBox(height: 10),
            Text(
              controller.offer.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  tr(LocaleKeys.price_range),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                SizedBox(width: 18),
                Text(
                  "${controller.offer.price} - SEK",
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.copyWith(color: StyleRepo.blue),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  tr(LocaleKeys.excution_time),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                SizedBox(width: 18),
                Text(
                  "${controller.offer.time} - ${controller.offer.timeType}",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(color: StyleRepo.grey),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 62),
        child:
            controller.isDelete
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      style: Theme.of(
                        context,
                      ).outlinedButtonTheme.style!.copyWith(
                        fixedSize: MaterialStateProperty.all(
                          Size(MediaQuery.sizeOf(context).width * 0.42, 50),
                        ),
                      ),
                      onPressed: () {
                        controller.appBuilder.isProviderMode.value == true
                            ? controller.DeleteOffer(controller.offer.id)
                            : controller.DeclineOffer(controller.offer.id);
                      },
                      child:
                          controller.appBuilder.isProviderMode.value == true
                              ? Text(tr(LocaleKeys.delete))
                              : Text(tr(LocaleKeys.decline)),
                    ),
                    const SizedBox(width: 10),
                    controller.appBuilder.isProviderMode.value == false
                        ? ElevatedButton(
                          style: Theme.of(
                            context,
                          ).elevatedButtonTheme.style!.copyWith(
                            fixedSize: MaterialStateProperty.all(
                              Size(MediaQuery.sizeOf(context).width * 0.42, 50),
                            ),
                          ),
                          onPressed:
                              () => controller.AcceptOffer(controller.offer.id),
                          child:  Text(tr(LocaleKeys.accept)),
                        )
                        : SizedBox.shrink(),
                  ],
                )
                : SizedBox.shrink(),
      ),
    );
  }
}
