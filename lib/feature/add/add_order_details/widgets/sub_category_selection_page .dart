// ignore: file_names
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/core/services/state_management/widgets/obs_widget.dart';
import 'package:renvo_app/core/style/repo.dart';
import 'package:renvo_app/feature/add/add_order_details/controller.dart';

class SubCategorySelectionPage extends StatelessWidget {
  const SubCategorySelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddOrderDetailsController());

    return Scaffold(
      body: ObsListBuilder(
        obs: controller.subCategories,
        builder: (context, subCategories) {
          if (subCategories.isEmpty) {
            return Center(
              child: Text(
                tr(
                  LocaleKeys
                      .there_are_no_subcategories_available_for_this_category_at_the_moment,
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemCount: subCategories.length,
            itemBuilder: (context, index) {
              final item = controller.subCategories[index];
              return Obx(() {
                final selected = controller.isSelected(item);
                return GestureDetector(
                  onTap: () => controller.selectSubCategory(item),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: SvgPicture.string(
                            item.svg,
                            width: 40,
                            height: 40,
                            color: selected ? StyleRepo.blue : StyleRepo.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Flexible(
                          child: Text(
                            item.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight:
                                  selected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                              color: selected ? StyleRepo.blue : StyleRepo.grey,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
            },
          );
        },
      ),
    );
  }
}
