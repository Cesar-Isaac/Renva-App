import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:renvo_app/feature/home/widgets/HomeCategories.dart';
import 'package:renvo_app/feature/home/widgets/HomeStories.dart';
import '../../core/style/repo.dart';
import 'controller.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    Get.put(HomePageController());
    return Container(
      color: StyleRepo.softBlue,
      child: CustomScrollView(
        slivers: [
          HomeCategories(),
          Homestories(),
        ],
      ),
    );
  }
}
