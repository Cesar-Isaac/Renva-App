import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renva/core/style/repo.dart';

import 'package:renva/core/widgets/image.dart';
import 'package:renva/core/widgets/svg_icon.dart';

import '../../gen/assets.gen.dart';
import '../MyOrder/Rating/widgets/rating_stars.dart';
import 'controller.dart';

class StoryViewer extends StatelessWidget {
  const StoryViewer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StoryViewerController());

    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        if (controller.stories.isEmpty!) {
          return const Center(child: CircularProgressIndicator());
        }


        final story =
        controller.stories[controller.currentStoryIndex.value];

        final image =
        story.story[controller.currentMediaIndex.value];

        return GestureDetector(
          onTapUp: (details) {
            final width = MediaQuery.of(context).size.width;
            if (details.globalPosition.dx < width / 2) {
              controller.previous();
            } else {
              controller.next();
            }
          },
          child: Stack(
            fit: StackFit.expand,    
            children: [

              AppImage(
                  path: image,
                  type: ImageType.CachedNetwork,
                fit: BoxFit.cover,
                errorWidget: Icon(Icons.error,color: StyleRepo.white,),
              ),
              Positioned(
                top: 50,
                left: 8,
                right: 8,
                child: Obx(() {
                  final story =
                  controller.stories[controller.currentStoryIndex.value];

                  return Row(
                    children: List.generate(story.story.length, (index) {
                      return Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          height: 4,
                          child: AnimatedBuilder(
                            animation: controller.progressController,
                            builder: (context, child) {
                              double value;

                              if (index < controller.currentMediaIndex.value) {
                                value = 1;
                              } else if (index == controller.currentMediaIndex.value) {
                                value = controller.progressController.value;
                              } else {
                                value = 0;
                              }

                              return LinearProgressIndicator(
                                value: value,
                                backgroundColor: StyleRepo.grey,
                                valueColor:
                                const AlwaysStoppedAnimation<Color>(StyleRepo.blue),
                              );
                            },
                          ),
                        ),
                      );
                    }),
                  );
                }),
              ),


              Positioned(
                top: 60,
                left: 16,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),


              Positioned(
                bottom: 40,
                left: 16,
                right: 16,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: SizedBox(
                        width: 44,
                        height: 44,
                        child: AppImage(
                          path: story.avatar, 
                          type: ImageType.CachedNetwork,
                          fit: BoxFit.cover,
                          errorWidget: SvgIcon(icon: Assets.icons.user,color: StyleRepo.grey,),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      children: [
                        Text(
                          story.providerName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,  
                        ),
                        RatingStars(
                          rating: story.rate.toDouble(),
                        )
                      ],
                    ),
                   
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}



