import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/core/style/repo.dart';
import 'package:renvo_app/core/widgets/image.dart';
import 'package:renvo_app/feature/MyOrder/customer/viewOfferCust/OfferDetails/controller.dart';
import 'package:renvo_app/feature/MyOrder/customer/viewOfferCust/model/orderOffers.dart';
import 'package:renvo_app/gen/assets.gen.dart';

class OfferDetailsPage extends StatelessWidget {
  const OfferDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OfferDetailsPageController());
    final args = Get.arguments;
    if (args == null || args is! OrderOffersModel) {
      return Scaffold(
        appBar: AppBar(title:  Text(tr(LocaleKeys.offer_details))),
        body:  Center(child: Text(tr(LocaleKeys.no_offer_data_provided))),
      );
    }

    final OrderOffersModel offer = args;

    

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
          tr(LocaleKeys.view_offer),
          style: TextStyle(fontSize: 20, color: StyleRepo.black),
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
                offer.provider.avatar.originalUrl.isNotEmpty
                    ? AppImage(
                      path: offer.provider.avatar.originalUrl,
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
                      offer.provider.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                  ],
                ),
                SizedBox(width: 25),
              ],
            ),
            SizedBox(height: 20),
            Text(
              tr(LocaleKeys.picture),
              style: Theme.of(context).textTheme.labelLarge,
            ),
            SizedBox(height: 10),
            offer.gallery.isNotEmpty
                ? Container(
                  padding: const EdgeInsets.all(5),
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          offer.gallery.asMap().entries.map((entry) {
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
                                            itemCount: offer.gallery.length,
                                            pageController: PageController(
                                              initialPage: index,
                                            ),
                                            builder: (context, i) {
                                              return PhotoViewGalleryPageOptions(
                                                imageProvider: NetworkImage(
                                                  offer.gallery[i].originalUrl,
                                                ),
                                                heroAttributes:
                                                    PhotoViewHeroAttributes(
                                                      tag:
                                                          offer
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

            SizedBox(height: 20),
            Text(
              tr(LocaleKeys.description),
              style: Theme.of(context).textTheme.labelLarge,
            ),
            SizedBox(height: 10),
            Text(
              offer.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Text(
                  tr(LocaleKeys.price_range),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                SizedBox(width: 18),
                Text(
                  "${offer.price.toString()} - SEK",
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.copyWith(color: StyleRepo.blue),
                ),
              ],
            ),
            SizedBox(height: 30),
            Text(
              tr(LocaleKeys.excution_time),
              style: Theme.of(context).textTheme.labelLarge,
            ),
            SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "${offer.time} - ${offer.timeType}",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(color: StyleRepo.grey),
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 62),
        child: Row(
          children: [
            Expanded(
              child: Obx(() {
                return controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : OutlinedButton(
                      onPressed: controller.fetchDeleteOffers,
                      child: Text(
                        tr(LocaleKeys.delete),

                        style: TextStyle(color: StyleRepo.blue),
                      ),
                    );
              }),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Obx(() {
                return controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          StyleRepo.green,
                        ),
                      ),
                      onPressed: controller.fetchAcceptOffers,
                      child: Text(
                        tr(LocaleKeys.accept),
                        style: TextStyle(color: StyleRepo.white),
                      ),
                    );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
