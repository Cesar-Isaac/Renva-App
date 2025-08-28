import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/core/routes/routes.dart';
import 'package:renvo_app/core/services/state_management/widgets/obs_widget.dart';
import '../../core/style/repo.dart';
import '../../gen/assets.gen.dart';
import 'controller.dart';

class AddOrderPage extends StatelessWidget {
  final controller = Get.put(AddOrderPageController());
  AddOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [StyleRepo.softBlue, StyleRepo.blue],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 54,
              left: 0,
              right: 0,
              child: Assets.icons.renvaAddHome.svg(),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (Get.previousRoute != null &&
                                Get.previousRoute!.isNotEmpty) {
                              Get.back();
                            } else {
                              Get.offAllNamed(
                                '/home',
                              ); 
                            }
                          },
                          icon: Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 169.48794555664062,
                      height: 172.8550567626953,
                      child: Assets.icons.logoAddHome.svg(),
                    ),
                    Text(
                      tr(LocaleKeys.add_order),
                      style: TextStyle(
                        fontSize: 26,
                        color: StyleRepo.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tr(LocaleKeys.select_services_type_to_completed_order),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: StyleRepo.softGrey,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 10),

                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () => controller.fetch(),
                        child: ObsListBuilder(
                          obs: controller.categories,
                          builder: (context, categories) {
                            return ListView.builder(
                              padding: const EdgeInsets.only(bottom: 52),
                              itemCount: categories.length,
                              itemBuilder: (context, index) {
                                final category = categories[index];
                                return Obx(() {
                                  final isSelected = controller.isSelected(
                                    index,
                                  );
                                  return GestureDetector(
                                    onTap:
                                        () => controller.toggleSelection(index),
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 250),
                                      margin: EdgeInsets.only(bottom: 16),
                                      decoration: BoxDecoration(
                                        color: StyleRepo.white.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(17),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 12,
                                            height: 105,
                                            decoration: BoxDecoration(
                                              color:
                                                  isSelected
                                                      ? StyleRepo.white
                                                      : null,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(9.5),
                                                bottomLeft: Radius.circular(
                                                  9.5,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          SizedBox(
                                            width: 46.67,
                                            height: 42,
                                            child: Assets.icons.shop2.svg(),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  category.title,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: StyleRepo.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 25,
                                            height: 25,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 2,
                                              ),
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.arrow_forward,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 25),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ),

                    SizedBox(height: 15),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              StyleRepo.white,
                            ),
                          ),
                          onPressed: () {
                            final selected = controller.selectedIndex.value;
                            final categories = controller.categories.value;
                            if (selected == null || categories == null) {
                              Get.snackbar(
                                tr(LocaleKeys.error),
                                tr(LocaleKeys.please_select_one_category),
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                              return;
                            }
                            final selectedCategory = categories[selected];
                            Get.toNamed(
                              Pages.category_datails.value,
                              arguments: {'category': selectedCategory},
                            );
                          },

                          child: Text(
                            tr(LocaleKeys.next),
                            style: TextStyle(
                              color: StyleRepo.blue,
                              fontSize: 16,
                            ),
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
      ),
    );
  }
}
