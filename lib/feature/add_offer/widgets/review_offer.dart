import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/core/style/repo.dart';
import 'package:renvo_app/feature/add_offer/controller.dart';
import 'package:renvo_app/gen/assets.gen.dart';

class ReviewOffer extends StatelessWidget {
  const ReviewOffer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddOfferControoler>();
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
          tr(LocaleKeys.review_offer),
          style: TextStyle(color: StyleRepo.black, fontSize: 20),
        ),
        titleSpacing: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tr(LocaleKeys.add_photo),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 10),
            Obx(() {
              final photos = controller.uploadedPhotos;
              if (photos.isEmpty) {
                return Text(
                  tr(LocaleKeys.no_photos_uploaded),
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                );
              } else {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: photos.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        File(photos[index].path),
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              }
            }),
            SizedBox(height: 10),
            Text(
              tr(LocaleKeys.description),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
            Text(
              controller.description.text,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  tr(LocaleKeys.price_range),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                SizedBox(width: 10),
                Text(
                  "${controller.price.text} SEK",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: StyleRepo.blue,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              tr(LocaleKeys.time_time_type),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Assets.icons.timer.svg(),
                SizedBox(width: 20),
                Text(
                  "${controller.time.text}   ${controller.selectedMonth}",
                  style: TextStyle(color: StyleRepo.grey),
                ),
              ],
            ),

            SizedBox(height: 30),
            Center(
              child: Obx(() {
                return controller.isLoading.value
                    ? const Center(
                      child: CircularProgressIndicator(color: StyleRepo.blue),
                    )
                    : ElevatedButton(
                      onPressed: controller.sendOffer,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 12,
                        ),
                        backgroundColor: StyleRepo.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        tr(LocaleKeys.done),
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
