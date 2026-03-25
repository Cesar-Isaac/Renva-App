import 'package:dio/dio.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';

import '../../core/services/state_management/obs.dart';
import '../home/models/stories.dart';

class StoryViewerController extends GetxController
    with GetSingleTickerProviderStateMixin {

  ObsList<Story> stories = ObsList([]);
  var isLoadingStories = false.obs;
  late int id;

  final dio = Dio();

  var currentStoryIndex = 0.obs;
  var currentMediaIndex = 0.obs;

  late AnimationController progressController;

  @override
  void onInit() {
    id = Get.arguments;
    fetchStoriesById();

    progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        next();
      }
    });

    super.onInit();
  }

  void startProgress() {
    progressController.forward(from: 0);
  }

  void resetProgress() {
    progressController.reset();
    progressController.forward();
  }

  @override
  void onClose() {
    progressController.dispose();
    super.onClose();
  }

  Future<void> fetchStoriesById() async {
    try {
      isLoadingStories.value = true;

      final response = await dio.get(
        'https://my-json-server.typicode.com/Cesar-Isaac/fakeStoriesApi/stories/$id',
      );

      final story = Story.fromJson(response.data);
      stories.value = [story];

      startProgress();
    } catch (e) {
      print("ERROR: $e");
    } finally {
      isLoadingStories.value = false;
    }
  }

  void next() {
    final currentStory = stories.value![currentStoryIndex.value];

    if (currentMediaIndex.value < currentStory.story.length - 1) {
      currentMediaIndex.value++;
      resetProgress();
    } else {
      Get.back();
    }
  }

  void previous() {
    if (currentMediaIndex.value > 0) {
      currentMediaIndex.value--;
      resetProgress();
    }
  }
}