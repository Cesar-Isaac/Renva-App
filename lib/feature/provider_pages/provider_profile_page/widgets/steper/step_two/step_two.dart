import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/services/state_management/widgets/obs_widget.dart';
import 'package:renvo_app/core/style/repo.dart';
import 'package:renvo_app/feature/provider_pages/provider_profile_page/widgets/steper/step_two/controller_step_two.dart';
import 'package:renvo_app/gen/assets.gen.dart';

class UpdateStepTwo extends StatelessWidget {
  const UpdateStepTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ControllerStepTwo>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: controller.formKeyStep2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60),
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
                          final isSelected = controller.selectedCategoryIds
                              .contains(category.id);

                          return GestureDetector(
                            onTap:
                                () => controller.toggleSelection(category.id!),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 250),
                              margin: EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: StyleRepo.softBlue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(17),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 105,
                                    decoration: BoxDecoration(
                                      color: isSelected ? StyleRepo.blue : null,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(9.5),
                                        bottomLeft: Radius.circular(9.5),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  SizedBox(
                                    width: 46.67,
                                    height: 42,
                                    child: Assets.icons.shop.svg(
                                      width: 56,
                                      height: 56,
                                      color: StyleRepo.blue,
                                    ),
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
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: StyleRepo.blue,
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
                                      color: StyleRepo.blue,
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
          ],
        ),
      ),
    );
  }
}
