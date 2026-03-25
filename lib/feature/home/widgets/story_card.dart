import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:renva/core/style/repo.dart';
import 'package:renva/core/widgets/image.dart';
import 'package:renva/core/widgets/svg_icon.dart';

import '../../../core/routes/routes.dart';
import '../../../gen/assets.gen.dart';
import '../controller.dart';
import '../models/stories.dart';

class StoryCard extends StatelessWidget {
  final Story story;

  const StoryCard({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final controller = Get.find<HomePageController>();
        controller.currentStoryIndex.value =
            controller.stories.indexOf(story);
        controller.currentMediaIndex.value = 0;

        Get.toNamed(Pages.viewStory.value,arguments: story.id);
      },
      child: Container(
        width: 160,

        margin: const EdgeInsets.only(right: 12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child:
          AppImage(
            path: story.story.first,
            type: ImageType.CachedNetwork,
            fit: BoxFit.cover,
            errorWidget: Image.asset("assets/image/noInternet.png",color: StyleRepo.blue,)
          )

        ),
      ),
    );
  }
}