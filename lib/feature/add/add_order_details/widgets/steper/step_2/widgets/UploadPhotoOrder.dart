// ignore: file_names
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/core/style/repo.dart';
import 'package:renvo_app/feature/add/add_order_details/widgets/steper/step_3/controller.dart';

class UploadPhotoOrder extends StatelessWidget {
  const UploadPhotoOrder({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ControllerStep3>();

    return Obx(() {
      final photos = controller.uploadedPhotos;

      if (photos.isEmpty) {
        // if photo not found
        return GestureDetector(
          onTap: () async {
            await controller.pickImageUploadPhoto();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DottedBorder(
                color: StyleRepo.grey.withOpacity(0.4),
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                dashPattern: const [6, 4],
                child: Container(
                  padding: const EdgeInsets.all(12),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.upload, color: StyleRepo.grey),
                      const SizedBox(height: 8),
                      Text(
                        tr(LocaleKeys.upload_photo),
                        style: TextStyle(color: StyleRepo.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        // if photo found
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DottedBorder(
              color: Colors.grey.withOpacity(0.4),
              borderType: BorderType.RRect,
              radius: const Radius.circular(12),
              dashPattern: const [6, 4],
              child: Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ...photos.map(
                      (xfile) => Stack(
                        alignment: Alignment.topRight,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(xfile.path),
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.uploadedPhotos.remove(xfile);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await controller.pickImageUploadPhoto();
                      },
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Icon(Icons.add, size: 40, color: StyleRepo.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }
    });
  }
}
