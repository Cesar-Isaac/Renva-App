import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/core/style/repo.dart';
import 'package:renvo_app/feature/add/add_order_details/widgets/steper/step_1/controller.dart';
import 'package:renvo_app/feature/add/add_order_details/widgets/steper/step_3/controller.dart';
import 'package:renvo_app/gen/assets.gen.dart';

class StepReviewOrder extends StatelessWidget {
  const StepReviewOrder({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ControllerStep3>();
    return Form(
      key: controller.formKeyStep3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          
          children: [
            Text(
              tr(LocaleKeys.category),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 5),
            Text(
              controller.category.title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
            ),
            SizedBox(height: 16),
            Text(
              tr(LocaleKeys.picture),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 5),
            Obx(() {
              final photos = controller.uploadedPhotos;
              if (photos.isEmpty) {
                return Text(
                  tr(LocaleKeys.no_photos_uploaded),
                  style: const TextStyle(color: Colors.grey),
                );
              }
              return Wrap(
                spacing: 10,
                runSpacing: 10,
                children:
                    photos.map((file) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(file.path),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      );
                    }).toList(),
              );
            }),
            const SizedBox(height: 16),

            Text(
              tr(LocaleKeys.services_type),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 5),
            Obx(
              () => Text(
                controller.formattedServiceType.value,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
              ),
            ),

            const SizedBox(height: 16),

            Obx(() {
              if (controller.selectedType.value == ServiceType.specificDate) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr(LocaleKeys.date_time),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Assets.icons.calendar.svg(color: StyleRepo.grey),
                        const SizedBox(width: 10),
                        Text(
                          controller.formattedDate.value,
                          style: const TextStyle(
                            color: StyleRepo.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Assets.icons.timer.svg(color: StyleRepo.grey),
                        const SizedBox(width: 10),
                        Text(
                          controller.formattedTime.value,
                          style: const TextStyle(
                            color: StyleRepo.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            }),

            const SizedBox(height: 16),

            Text(
              tr(LocaleKeys.description),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 5),
            Text(
              controller.description.text,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  tr(LocaleKeys.price_range),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                SizedBox(width: 10),
                Text(
                  "${controller.priceRange.value.start.toInt()} - ${controller.priceRange.value.end.toInt()} SEK",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: StyleRepo.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
