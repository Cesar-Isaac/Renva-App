import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/core/style/repo.dart';
import 'package:renvo_app/feature/add/add_order_details/widgets/steper/step_1/index.dart';
import 'package:renvo_app/feature/add/add_order_details/widgets/steper/step_2/index.dart';
import 'package:renvo_app/feature/add/add_order_details/widgets/steper/step_3/controller.dart';
import 'package:renvo_app/feature/add/add_order_details/widgets/steper/step_3/index.dart';
import 'package:renvo_app/feature/add/add_order_details/widgets/steper/widgets/steper_progress_bar.dart';

import 'package:renvo_app/gen/assets.gen.dart';

class AddOrderStep extends StatelessWidget {
  const AddOrderStep({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ControllerStep3());
    return Scaffold(
      body: Container(
        color: StyleRepo.white,
        child: Stack(
          children: [
            Positioned(
              top: 120,
              left: 0,
              right: 0,
              child: Assets.icons.renvaAddHome.svg(color: StyleRepo.softBlue),
            ),
            SafeArea(
              child: Obx(
                () => Column(
                  children: [
                    StepProgressBar(),
                    const SizedBox(height: 16),
                    Expanded(
                      child: IndexedStack(
                        index: controller.currentStep.value,
                        children: [
                          StepServiceType(),
                          StepCompletOrder(),
                          StepReviewOrder(),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (controller.currentStep.value > 0)
                            OutlinedButton(
                              style: ButtonStyle(
                                side: WidgetStateProperty.all(
                                  BorderSide(color: StyleRepo.blue),
                                ),
                              ),
                              onPressed: controller.onBackStep,
                              child:  Text(
                                tr(LocaleKeys.back),
                                style: TextStyle(color: StyleRepo.blue),
                              ),
                            ),
                          Obx(() {
                            return controller.isLoading.value
                                ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                                : controller.currentStep.value == 2
                                ? ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
                                      StyleRepo.green,
                                    ),
                                  ),
                                  onPressed: controller.addOrder,
                                  child: Text(
                                    tr(LocaleKeys.confirm),
                                    style: TextStyle(color: StyleRepo.white),
                                  ),
                                )
                                : ElevatedButton(
                                  onPressed: controller.onNextStep,
                                  child: Text(
                                    tr(LocaleKeys.next),
                                    style: TextStyle(color: StyleRepo.white),
                                  ),
                                );
                          }),
                        ],
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
