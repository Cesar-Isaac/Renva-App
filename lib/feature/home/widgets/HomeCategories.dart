import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/localization/strings.dart';
import '../../../core/services/state_management/widgets/obs_widget.dart';
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
      expandedHeight: 455,
      collapsedHeight: 130,
      pinned: true,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Assets.icons.renvoSVG.svg(
                              height: 27,
                              width: 111,
                              color: StyleRepo.white,
                            ),
                            SizedBox(width: 100),
                            Assets.icons.notification.svg(),
                          ],
                        ),

                        Row(
                          children: [
                            Text(
                              tr(LocaleKeys.your_location),
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(color: StyleRepo.white),
                            ),
                            SizedBox(width: 10),
                            Text(
                              tr(LocaleKeys.location_name),
                              style: Theme.of(context).textTheme.bodySmall!
                                  .copyWith(color: StyleRepo.white),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                color: StyleRepo.white,
                                Icons.arrow_downward_rounded,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),

                        RefreshIndicator(
                          onRefresh: () => controller.fetch(),
                          child: Center(
                            child: SizedBox(
                              height: 350,
                              child: ObsListBuilder(
                                obs: controller.categories,
                                builder: (context, categories) {
                                  return GridView.builder(
                                    itemCount: categories.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 12,
                                          mainAxisSpacing: 12,
                                          childAspectRatio: 1.2,
                                        ),
                                    itemBuilder: (context, index) {
                                      final category = categories[index];
                                      return Cardcategories(
                                        service: category.title,
                                        explain_service: "sss",
                                        pictureSvg: Assets.icons.shop.svg(
                                          width: 56,
                                          height: 56,
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
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
