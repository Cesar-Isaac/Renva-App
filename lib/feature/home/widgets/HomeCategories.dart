
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/style/repo.dart';
import '../../../gen/assets.gen.dart';
import '../controller.dart';
import 'CardCategories.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomePageController>();
    return SliverAppBar(
      expandedHeight: MediaQuery.sizeOf(context).height * 0.5,
      collapsedHeight: MediaQuery.sizeOf(context).height * 0.1,
      pinned: true,
      floating: true,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [StyleRepo.blue, StyleRepo.softBlue],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Positioned.fill(child: Assets.icons.logohome.svg()),

                Positioned(
                  right: -20,
                  top: -20,
                  child: Assets.icons.logohome2.svg(),
                ),
                SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 60),
                        Assets.icons.renvoSVG.svg(
                          height: 27,
                          width: 111,
                          color: StyleRepo.white,
                        ),
                        SizedBox(height: 10),

                        Text(
                          "Recruitment,assistance and cooperation",
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(color: StyleRepo.white),
                        ),


                        // SizedBox(height: 1),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.categoriesList.length,
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1.2,
                          ),
                          itemBuilder: (context, index) {
                            // final category = categories[index];
                            final category = controller.categoriesList[index];
                            return Cardcategories(
                                service: category.title,
                                explain_service:category.subtitle,
                                iconPath:category.iconPath
                            );
                          },
                        ),
                        SizedBox(height: 35),

                        // RefreshIndicator(
                        //   onRefresh: () => controller.fetch(),
                        //   child: Center(
                        //     child: SizedBox(
                        //       height: 355,
                        //       child: ObsListBuilder(
                        //         obs: controller.categories,
                        //         builder: (context, categories) {
                        //           return GridView.builder(
                        //             itemCount: categories.length,
                        //             gridDelegate:
                        //                 SliverGridDelegateWithFixedCrossAxisCount(
                        //                   crossAxisCount: 2,
                        //                   crossAxisSpacing: 12,
                        //                   mainAxisSpacing: 12,
                        //                   childAspectRatio: 1.2,
                        //                 ),
                        //             itemBuilder: (context, index) {
                        //               // final category = categories[index];
                        //               final category = controller.categoriesList[index];
                        //               return Cardcategories(
                        //                 service: category.title,
                        //                 explain_service:category.subtitle,
                        //                 iconPath:category.iconPath
                        //               );
                        //             },
                        //           );
                        //         },
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
