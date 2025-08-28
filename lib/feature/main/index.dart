import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/config/app_builder.dart' show AppBuilder;
import 'package:renvo_app/feature/MyOrder/index.dart';
import 'package:renvo_app/feature/main/widget/nav_bar.dart';
import 'package:renvo_app/feature/provider_pages/provider_home_page/index.dart';
import '../profile/profile/index.dart';
import '../home/index.dart';
import 'controller.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appBuilder = Get.find<AppBuilder>();
    final controller = Get.put(MainPageController());
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Obx(() {
              final isProvider = appBuilder.isProviderMode.value;
              return switch (controller.currentPage.value) {
                0 => isProvider ? ProviderHomePage() : HomePage(),
                1 => isProvider ? MyOrderPage() : SizedBox.shrink(),
                2 => isProvider ? ProfilePage() : MyOrderPage(), 
                3 => ProfilePage(),
                _ => throw UnimplementedError(),

              };
            }),
          ),

          Obx(() => controller.showNavBar.value ? NavBar() : SizedBox()),
        ],
      ),
    );
  }
}
