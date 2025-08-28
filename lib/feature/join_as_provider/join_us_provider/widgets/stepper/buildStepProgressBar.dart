import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/core/style/repo.dart';

import '../../controller.dart';

class BuildStepProgressBar extends StatelessWidget {
  const BuildStepProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JoinUsProviderPageController>();
    final List<String> stepTitles = [tr(LocaleKeys.add_information), tr(LocaleKeys.complete_information)];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Obx(() => Row(
          children: List.generate(2, (index) {
            final isActive = controller.currentStep.value == index;
            final isCompleted = controller.currentStep.value > index;
            final isLast = index == 1;

            return GestureDetector(
              onTap: () {
                if (index <= controller.currentStep.value) {
                  controller.currentStep.value = index;
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: 61,
                width: isActive ? 180 : 38,
                margin: EdgeInsets.only(right: isLast ? 0 : 8),
                decoration: BoxDecoration(
                  color: isCompleted || isActive
                      ? StyleRepo.green
                      : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    switchInCurve: Curves.easeIn,
                    switchOutCurve: Curves.easeOut,
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SizeTransition(
                          sizeFactor: animation,
                          axis: Axis.horizontal,
                          child: child,
                        ),
                      );
                    },
                    child: Center(
                      child: isActive || isCompleted
                          ? Row(
                        key: ValueKey('step-$index-${isActive ? 'active' : 'done'}'),
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isCompleted)
                            const Icon(
                              Icons.check,
                              color: StyleRepo.white,
                              size: 20,
                            ),
                          if (isCompleted) const SizedBox(width: 6),
                          if (isActive)
                            Flexible(
                              child: Text(
                                stepTitles[index],
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: StyleRepo.white,
                                ),
                              ),
                            ),
                        ],
                      )
                          : const SizedBox.shrink(),
                    ),
                  ),
                ),
              ),
            );
          }),
        )),
      ),
    );
  }
}



