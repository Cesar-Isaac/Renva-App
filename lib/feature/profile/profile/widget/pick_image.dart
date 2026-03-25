import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renva/core/config/app_builder.dart';
import 'package:renva/feature/profile/profile/controller.dart';
import '../../../../core/style/repo.dart';
import '../../../../core/widgets/svg_icon.dart';
import '../../../../gen/assets.gen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PickImageMyProfile extends StatelessWidget {
  const PickImageMyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfilePageController>();
    final appBuilder = Get.find<AppBuilder>();

    return Obx(() {
      final profile = controller.profile.value;
      final isProvider = appBuilder.isProviderMode.value;
      final imagePath = controller.image.value;

      Widget avatarImage;

      if (imagePath.isNotEmpty && File(imagePath).existsSync()) {
        avatarImage = Image.file(
          File(imagePath),
          fit: BoxFit.cover,
          width: 140,
          height: 140,
        );
      } else {
        final imageUrl =
            isProvider
                ? profile?.provider?.avatar?.originalUrl
                : profile?.avatar.originalUrl;

        if (imageUrl != null && imageUrl.isNotEmpty) {
          avatarImage = CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            width: 140,
            height: 140,
            errorWidget:
                (context, url, error) => SvgIcon(
                  icon: Assets.icons.user,
                  size: 140,
                  color: StyleRepo.softGrey,
                ),
            placeholder:
                (context, url) =>
                    const Center(child: CircularProgressIndicator()),
          );
        } else {
          avatarImage = Center(
            child: SvgIcon(
              icon: Assets.icons.user,
              size: 140,
              color: StyleRepo.softGrey,
            ),
          );
        }
      }

      return Container(
        width: 140,
        height: 140,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: ClipOval(child: avatarImage),
      );
    });
  }
}
