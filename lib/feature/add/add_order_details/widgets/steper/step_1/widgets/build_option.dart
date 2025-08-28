import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:renvo_app/core/style/repo.dart';
import 'package:renvo_app/feature/add/add_order_details/widgets/steper/step_1/controller.dart';
import 'package:renvo_app/feature/add/add_order_details/widgets/steper/step_3/controller.dart';

Widget buildOption({
  required String label,
  required ServiceType value,
  required ControllerStep3 controller,
}) {
  return Obx(
    () => InkWell(
      onTap: () => controller.selectedType.value = value ,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color:
                  controller.selectedType.value == value
                      ? StyleRepo.blue
                      : StyleRepo.softGrey,
            ),
            borderRadius: BorderRadius.circular(30),
            color:
                controller.selectedType.value == value
                    ? StyleRepo.softBlue.withOpacity(0.09)
                    : StyleRepo.transparent,
          ),
          child: Row(
            children: [
              Radio<ServiceType>(
                value: value,
                activeColor: StyleRepo.deepBlue,
                groupValue: controller.selectedType.value ,
                onChanged: (val) => controller.selectedType.value = val!,
              ),
              Text(
                label,
                style: TextStyle(
                  color:
                      controller.selectedType.value == value
                          ? StyleRepo.deepBlue
                          : StyleRepo.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
