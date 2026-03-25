import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renva/feature/add/add_order_details/widgets/steper/step_1/widgets/build_option.dart';

import '../../../../../../core/localization/strings.dart';
import '../../../../../../core/style/repo.dart';
import '../step_3/controller.dart';
import 'controller.dart';

class StepServiceType extends StatelessWidget {
  const StepServiceType({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ControllerStep3>();
    return Form(
      key: controller.controllerStepOne.formKeyStep1,
      child: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
              Center(
                child: Text(
                  tr(LocaleKeys.select_service_type),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                tr(
                  LocaleKeys.choose_the_time_and_type_of_service_that_suits_you,
                ),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: StyleRepo.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Radio Buttons
              buildOption(
                label: 'As Soon As Possible',

                value: ServiceType.asap,
                controller: controller,
              ),
              const SizedBox(height: 12),
              buildOption(
                label: 'Specific Date',
                value: ServiceType.specificDate,
                controller: controller,
              ),

              const SizedBox(height: 20),

              if (controller.controllerStepOne.selectedType.value == ServiceType.specificDate)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Date Field
                        Expanded(
                          child: TextFormField(
                            readOnly: true,
                            onTap: () => controller.controllerStepOne.pickDate(context),
                            controller: controller.controllerStepOne.date,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: tr(LocaleKeys.date),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 16,
                              color: StyleRepo.blue,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return tr(LocaleKeys.please_select_a_date);
                              }
                              return null;
                            },
                          ),
                        ),

                        const SizedBox(width: 6),

                        // Time Field
                        Expanded(
                          child: TextFormField(
                            readOnly: true,
                            onTap: () => controller.controllerStepOne.pickTime(context),
                            controller: controller.controllerStepOne.time,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: tr(LocaleKeys.time),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 16,
                              color: StyleRepo.blue,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return tr(LocaleKeys.please_select_a_time);
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        );
      }),
    );
  }
}
