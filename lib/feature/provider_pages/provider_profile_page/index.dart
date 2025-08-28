import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/core/style/repo.dart';
import 'package:renvo_app/feature/provider_pages/provider_profile_page/controller.dart';
import 'package:renvo_app/feature/provider_pages/provider_profile_page/widgets/steper/step_one/step_one.dart';
import 'package:renvo_app/feature/provider_pages/provider_profile_page/widgets/steper/step_two/step_two.dart';
import 'package:renvo_app/feature/provider_pages/provider_profile_page/widgets/steper/widgets/steper_progress_bar.dart';

import 'package:renvo_app/gen/assets.gen.dart';

class UpdateProfileProv extends StatelessWidget {
  const UpdateProfileProv({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProviderProfilePageController());

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
                    StepProgressBar2(),
                    const SizedBox(height: 16),
                    Expanded(
                      child: IndexedStack(
                        index: controller.currentStep.value,
                        children: [UpdateStepOne(), UpdateStepTwo()],
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
                            if (controller.isLoading.value) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (controller.currentStep.value == 1) {
                              return ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                    StyleRepo.green,
                                  ),
                                ),
                                onPressed: controller.updateProv,
                                child: Text(
                                  tr(LocaleKeys.confirm),
                                  style: TextStyle(color: StyleRepo.white),
                                ),
                              );
                            } else {
                              return ElevatedButton(
                                onPressed: controller.onNextStep,
                                child: Text(
                                  tr(LocaleKeys.next),
                                  style: TextStyle(color: StyleRepo.white),
                                ),
                              );
                            }
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
