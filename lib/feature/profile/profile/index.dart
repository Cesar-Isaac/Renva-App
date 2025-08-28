import 'dart:io';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/config/app_builder.dart';
import 'package:renvo_app/core/widgets/svg_icon.dart';
import 'package:renvo_app/feature/profile/profile/widget/body_page.dart';
import 'package:renvo_app/feature/profile/profile/widget/pick_image.dart';
import 'package:renvo_app/gen/assets.gen.dart';
import '../../../core/localization/strings.dart';
import '../../../core/routes/routes.dart';
import '../../../core/style/repo.dart';
import '../../../core/widgets/error_widget.dart';
import 'controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final appBuilder = Get.find<AppBuilder>();
    final controller = Get.put(ProfilePageController(), permanent: true);

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.profile.error != null) {
          return AppErrorWidget(
            error: controller.profile.error!,
            onRetry: controller.fetch,
          );
        }

        if (controller.profile.value == null) {
          return Center(child: Text(tr(LocaleKeys.no_data_available)));
        }

        final profile = controller.profile.value!;
        final isProvider = appBuilder.isProviderMode.value;

        return Stack(
          children: [
            Obx(() {
              final imagePath = controller.image.value;
              final profile = controller.profile.value!;
              final isProvider = appBuilder.isProviderMode.value;

              Widget backgroundImage;

              if (imagePath.isNotEmpty && File(imagePath).existsSync()) {
                backgroundImage = Image.file(
                  File(imagePath),
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height * 0.5,
                  fit: BoxFit.cover,
                );
              } else {
                final avatarUrl =
                    isProvider
                        ? profile.provider?.avatar?.originalUrl
                        : profile.avatar.originalUrl;

                if (avatarUrl != null && avatarUrl.isNotEmpty) {
                  backgroundImage = CachedNetworkImage(
                    imageUrl: avatarUrl,
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height * 0.5,
                    fit: BoxFit.cover,
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
                  backgroundImage = Center(
                    child: SvgIcon(
                      icon: Assets.icons.user,
                      size: 140,
                      color: StyleRepo.softGrey,
                    ),
                  );
                }
              }

              return ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: backgroundImage,
              );
            }),
            SafeArea(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    const PickImageMyProfile(),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isProvider
                            ? Text(
                              profile.provider?.name ?? "No Provider Name",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                            : Text(
                              profile.firstName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                        const SizedBox(width: 3),
                        isProvider
                            ? const Text('')
                            : Text(
                              profile.lastName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    isProvider
                        ? Text(
                          profile.provider?.phone ?? "No Provider Phone",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                        : Text(
                          profile.phone,
                          style: TextStyle(
                            color: StyleRepo.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                    TextButton(
                      onPressed:
                          () =>
                              appBuilder.isProviderMode.value == true
                                  ? Get.toNamed(Pages.edit_profile_prov.value)
                                  : Get.toNamed(Pages.edit_profile.value),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            tr(LocaleKeys.edit_profile),
                            style: TextStyle(
                              color: StyleRepo.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: StyleRepo.white,
                                width: 2,
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_forward,
                                color: StyleRepo.white,
                                size: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              profile.ordersCnt?.toString() ?? "0",
                              style: TextStyle(
                                color: StyleRepo.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              tr(LocaleKeys.orders),
                              style: const TextStyle(
                                color: StyleRepo.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              profile.ordersCnt?.toString() ?? "0",
                              style: TextStyle(
                                color: StyleRepo.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              tr(LocaleKeys.points),
                              style: const TextStyle(
                                color: StyleRepo.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        decoration: const BoxDecoration(
                          color: StyleRepo.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                          ),
                        ),
                        child: const BodyPage(),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
