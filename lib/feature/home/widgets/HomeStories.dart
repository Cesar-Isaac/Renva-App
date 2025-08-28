// ignore: file_names
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/routes/routes.dart';
import '../../../core/localization/strings.dart';
import '../../../core/style/repo.dart';
import 'StoryCard.dart';

class Homestories extends StatelessWidget {
  const Homestories({super.key});

  @override
  Widget build(BuildContext context) {
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


              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    8,
                        (index) => Padding(
                      padding: index == 7
                          ? EdgeInsets.zero
                          : const EdgeInsetsDirectional.only(end: 8),
                      child: StoryCard(index: index), 
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 16,
              ),
              Text(tr(LocaleKeys.join_as_a_services_provider),
                  style: Theme.of(context).textTheme.titleMedium),
              
              Text(
                tr(LocaleKeys.top_rated_service_providers),
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: StyleRepo.softGrey,
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
