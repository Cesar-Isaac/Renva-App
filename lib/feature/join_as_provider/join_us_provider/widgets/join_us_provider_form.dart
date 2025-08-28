import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/feature/join_as_provider/join_us_provider/widgets/stepper/buildStepProgressBar.dart';
import 'package:renvo_app/feature/join_as_provider/join_us_provider/widgets/stepper/steper_one.dart';
import 'package:renvo_app/feature/join_as_provider/join_us_provider/widgets/stepper/steper_two.dart';

import '../../../../core/style/repo.dart';
import '../controller.dart';


class JoinUsProviderForm extends StatelessWidget {
  const JoinUsProviderForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JoinUsProviderPageController>();

    return Scaffold(
      appBar: AppBar(
        title:  Text(tr(LocaleKeys.join_as_a_services_provider)),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: StyleRepo.black, width: 2),
            ),
            child: const Center(
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: StyleRepo.black,
                size: 15,
              ),
            ),
          ),
        ),
      ),
      body: Obx(
        () => Column(
          children: [
            BuildStepProgressBar(),
            const SizedBox(height: 16),
            Expanded(
              child: IndexedStack(
                index: controller.currentStep.value,
                children: [StepOne(), StepTwo()],
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
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                          onPressed: controller.onNextStep,
                      
                          child: Text(
                            controller.currentStep.value == 1 ? tr(LocaleKeys.join) : tr(LocaleKeys.next),
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
    );
  }
}
