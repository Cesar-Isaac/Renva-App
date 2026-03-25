import 'dart:math';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../core/config/app_builder.dart';
import '../../core/services/rest_api/api_service.dart';
import '../../core/services/rest_api/constants/end_points.dart';
import '../../core/services/rest_api/models/request.dart';
import '../../core/services/rest_api/models/response_model.dart';
import '../../core/services/state_management/obs.dart';
import '../../gen/assets.gen.dart';
import 'models/all_categories.dart';
import 'models/category_model.dart';
import 'models/stories.dart';

class HomePageController extends GetxController {
  ObsList<AllCategories> categories = ObsList([]);
  var isLoading = false.obs;
  final AppBuilder appBuilder = Get.find();
  fetch() async {
    final token = appBuilder.token;
    ResponseModel response = await APIService.instance.request(
      Request(
        endPoint: EndPoints.categories,
        fromJson: AllCategories.fromJson,
        header: {
          "Authorization": "Bearer $token",
        },
      ),
    );

    if (response.success) {
      categories.value = response.data;
    }else{
      categories.error = response.message;
    }
  }
  final List<CategoryModel> categoriesList = [
    CategoryModel(
        title: "Household Services",
        subtitle: "Cleaning , Ironing & Washing ....",
        iconPath: Assets.icons.shop.path),
    CategoryModel(
        title: "Professional Services",
        subtitle: "Electrical , Plumbing , Paint....",
        iconPath: Assets.icons.proffessional.path),
    CategoryModel(
        title: "Personal Services",
        subtitle: "Personal Training , Tutoring ...",
        iconPath: Assets.icons.personalServices.path),
    CategoryModel(
        title: "Logistical Services",
        subtitle: "Transport , Deliveries , Packing..",
        iconPath: Assets.icons.logistical.path),
  ];

  ///////    Stories /////////
  var isLoadingStories = false.obs;
  ObsList<Story> stories = ObsList([]);
  Future<void> fetchStories() async {
    try {
      isLoadingStories.value = true;

      final response = await dio.get(
        'https://my-json-server.typicode.com/Cesar-Isaac/fakeStoriesApi/stories',
      );

      final data = ShowStory.fromJson(response.data);
      stories.value = data.stories;
      print("############################ STORIES RESPONSE #########################################");
      print("Stories : ${response.data}");
      print("############################ STORIES RESPONSE #########################################");
    } catch (e) {
      print("ERROR: $e");
    } finally {
      isLoadingStories.value = false;
    }
  }
  final dio = Dio();




  var currentStoryIndex = 0.obs;
  var currentMediaIndex = 0.obs;



  /// next story
  void next() {
    final currentStory = stories.value![currentStoryIndex.value];

    if (currentMediaIndex.value < currentStory.story.length - 1) {
      currentMediaIndex.value++;
    } else {
      if (currentStoryIndex.value < stories.value!.length - 1) {
        currentStoryIndex.value++;
        currentMediaIndex.value = 0;
      } else {
        Get.back();
      }
    }
  }

  /// previous story
  void previous() {
    if (currentMediaIndex.value > 0) {
      currentMediaIndex.value--;
    } else {
      if (currentStoryIndex.value > 0) {
        currentStoryIndex.value--;
        currentMediaIndex.value =
            stories.value![currentStoryIndex.value].story.length - 1;
      }
    }
  }



  @override
  void onInit() {
    fetchStories();
    fetch();
    super.onInit();
  }
}

