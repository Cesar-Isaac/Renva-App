import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/core/style/repo.dart';
import 'package:renvo_app/core/widgets/error_widget.dart';
import 'package:renvo_app/core/widgets/image.dart';
import 'package:renvo_app/feature/MyOrder/Rating/widgets/rating_stars.dart';
import 'package:renvo_app/feature/provider_pages/provider_home_page/controller.dart';
import 'package:renvo_app/feature/provider_pages/provider_home_page/widgets/body_page.dart';
import 'package:renvo_app/gen/assets.gen.dart';

class ProviderHomePage extends StatelessWidget {
  const ProviderHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProviderHomePageController());
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: StyleRepo.deepBlue.withOpacity(0.9),
              child: Image.asset("assets/image/appBarHomeProvider.png"),
            ),
          ),

          SafeArea(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Assets.icons.renvoSVG.svg(
                          height: 27,
                          width: 111,
                          color: StyleRepo.white,
                        ),
                        SizedBox(width: 100),
                        Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: StyleRepo.white,
                              size: 30,
                            ),
                            SizedBox(width: 3),
                            Icon(
                              Icons.notifications_none_outlined,
                              color: StyleRepo.white,
                              size: 30,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Obx(() {
                      final isLoading = controller.isLoading.value;
                      final error = controller.profile.error;
                      final profile = controller.profile.value;

                      if (isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (error != null && profile == null) {
                        return SizedBox(
                          height: 120,
                          child: AppErrorWidget(
                            error: error,
                            onRetry: controller.fetchProfile,
                          ),
                        );
                      }

                      if (profile == null) {
                        return Center(
                          child: Text(tr(LocaleKeys.no_data_available)),
                        );
                      }

                      return Row(
                        children: [
                          AppImage(
                            path: profile.provider?.avatar?.originalUrl ?? "",
                            type: ImageType.CachedNetwork,
                            width: 34.31,
                            height: 34,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                profile.provider?.name ?? "No Provider Name",
                                style: const TextStyle(
                                  color: StyleRepo.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  Text(
                                    tr(LocaleKeys.provider_category),
                                    style: const TextStyle(
                                      color: StyleRepo.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.underline,
                                      decorationColor: StyleRepo.white,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  RatingStars(rating: profile.provider!.rate),
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                  ),
                
                  // Body
                  Expanded(child: Bodypage()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
