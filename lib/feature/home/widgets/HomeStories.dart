// ignore: file_names
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:renva/feature/home/widgets/story_card.dart';
import '../../../core/localization/strings.dart';
import '../../../core/routes/routes.dart';
import '../../../core/style/repo.dart';
import '../controller.dart';

class Homestories extends StatelessWidget {
  const Homestories({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomePageController>();
    return
      SliverToBoxAdapter(
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          decoration: BoxDecoration(
            color: StyleRepo.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(tr(LocaleKeys.curated_stories),
                  style: Theme.of(context).textTheme.titleMedium),
              Text(tr(LocaleKeys.discover_new_horizons),
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: StyleRepo.grey,
                      )),
              SizedBox(
                height: 16,
              ),



              Obx(() {
                if (controller.isLoadingStories.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.stories.value!.isEmpty) {
                  return const SizedBox();
                }

                return SizedBox(
                  height: 190,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.stories.value!.length,
                    itemBuilder: (context, index) {
                      final story = controller.stories.value![index];
                      return StoryCard(story: story);
                    },
                  ),
                );
              }),

              SizedBox(
                height: 16,
              ),
              Text(tr(LocaleKeys.join_as_a_services_provider),
                  style: Theme.of(context).textTheme.titleMedium),
              
              Text(
                tr(LocaleKeys.top_rated_service_providers),
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: StyleRepo.grey,
                    ),
              ),
              SizedBox(height: 10),
              
              InkWell(
                onTap: () => Get.toNamed(Pages.join_us_provider.value),
                child: SizedBox(
                  width: 373,
                  height: 140,
                  child: Image.asset("assets/image/slider.png", fit: BoxFit.cover),
                ),
              ),

              SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }
}
