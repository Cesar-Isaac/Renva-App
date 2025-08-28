import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/style/repo.dart';

import '../../../../../core/localization/strings.dart';
import '../../controller.dart';
import '../upload_photo_field.dart';
import 'build_label.dart';

class StepTwo extends StatelessWidget {
  const StepTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JoinUsProviderPageController>();

    Future<void> selectTime(Rx<TimeOfDay?> timeField) async {
      final picked = await showTimePicker(
        context: context,
        initialTime: timeField.value ?? TimeOfDay.now(),
      );
      if (picked != null) {
        timeField.value = picked;
      }
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: controller.formKeyStep2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildLabel(LocaleKeys.working_time),
            const SizedBox(height: 8),
            Obx(() {
              bool isSelected = controller.selectedAnyTime.value;

              return FormField<bool>(
                validator: (value) {
                  if (!isSelected) {
                    if (controller.startTime.value == null ||
                        controller.endTime.value == null) {
                      return tr(
                        LocaleKeys.select_both_start_and_end_times_or_Any_Time,
                      );
                    }
                  }
                  return null;
                },
                builder: (FormFieldState<bool> field) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // حقل From
                          Obx(
                            () => Expanded(
                              child: TextFormField(
                                readOnly: true,
                                onTap: () {
                                  if (!controller.selectedAnyTime.value) {
                                    selectTime(controller.startTime);
                                  }
                                },
                                controller: TextEditingController(
                                  text:
                                      controller.startTime.value != null
                                          ? '${controller.startTime.value!.hour.toString().padLeft(2, '0')}'
                                              ':${controller.startTime.value!.minute.toString().padLeft(2, '0')}'
                                          : "",
                                ),
                                decoration: InputDecoration(
                                  hintText: tr(LocaleKeys.from),
                                  filled: true,
                                  fillColor:
                                      controller.selectedAnyTime.value
                                          ? Colors.grey.shade200
                                          : Colors.grey.shade100,
                                  enabled: !controller.selectedAnyTime.value,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.sizeOf(context).width * 0.1,
                                    vertical: 14,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      controller.selectedAnyTime.value
                                          ? Colors.grey
                                          : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),

                          // حقل To
                          Obx(
                            () => Expanded(
                              child: TextFormField(
                                readOnly: true,
                                onTap: () {
                                  if (!controller.selectedAnyTime.value) {
                                    selectTime(controller.endTime);
                                  }
                                },
                                controller: TextEditingController(
                                  text:
                                      controller.endTime.value != null
                                          ? '${controller.endTime.value!.hour.toString().padLeft(2, '0')}:${controller.endTime.value!.minute.toString().padLeft(2, '0')}'
                                          : "",
                                ),
                                decoration: InputDecoration(
                                  hintText: tr(LocaleKeys.to),
                                  filled: true,
                                  fillColor:
                                      controller.selectedAnyTime.value
                                          ? Colors.grey.shade200
                                          : Colors.grey.shade100,
                                  enabled: !controller.selectedAnyTime.value,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.sizeOf(context).width * 0.1,
                                    vertical: 14,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      controller.selectedAnyTime.value
                                          ? Colors.grey
                                          : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextFormField(
                          readOnly: true,
                          onTap: () {
                            if (isSelected) {
                              controller.selectAnyTime(false);
                            } else {
                              controller.selectAnyTime(true);
                              controller.startTime.value = null;
                              controller.endTime.value = null;
                            }
                            field.didChange(true); 
                          },
                          decoration: InputDecoration(
                            hintText: tr(LocaleKeys.any_time),
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.sizeOf(context).width * 0.1,
                              vertical: 14,
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            errorStyle: TextStyle(
                              color: StyleRepo.red,
                              fontWeight: FontWeight.w500,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            prefixIcon: Icon(
                              isSelected
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_unchecked,
                              color:
                                  isSelected ? StyleRepo.deepBlue : Colors.grey,
                            ),
                            errorText: field.errorText,
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }),

            const SizedBox(height: 20),

            buildLabel(LocaleKeys.description),
            const SizedBox(height: 5),
            DottedBorder(
              color: Colors.grey.withOpacity(0.4),
              borderType: BorderType.RRect,
              radius: const Radius.circular(12),
              dashPattern: [6, 4],
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextFormField(
                  controller: controller.description,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: tr(LocaleKeys.add_description),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    errorStyle: TextStyle(
                      color: StyleRepo.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  validator:
                      (value) =>
                          value == null || value.trim().isEmpty
                              ? tr(LocaleKeys.this_field_is_required)
                              : null,
                ),
              ),
            ),
            const SizedBox(height: 16),
            buildLabel(LocaleKeys.upload_photo),
            const SizedBox(height: 5),
            FormField<bool>(
              validator: (value) {
                final controller = Get.find<JoinUsProviderPageController>();
                return controller.uploadedPhotos.length < 2
                    ? tr(LocaleKeys.at_least_two_images_must_be_uploaded)
                    : null;
              },
              builder: (field) => UploadPhotoField(field: field),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
