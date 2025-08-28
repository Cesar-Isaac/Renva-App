import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/core/style/repo.dart';
import 'package:renvo_app/feature/add/add_order_details/widgets/steper/step_2/widgets/UploadPhotoOrder.dart';
import 'package:renvo_app/feature/add/add_order_details/widgets/steper/step_2/widgets/range_slider_widget.dart';
import 'package:renvo_app/feature/add/add_order_details/widgets/steper/step_3/controller.dart';
import 'package:renvo_app/feature/join_as_provider/join_us_provider/widgets/stepper/build_label.dart';

class StepCompletOrder extends StatelessWidget {
  const StepCompletOrder({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ControllerStep3>();
    return Form(
      key: controller.formKeyStep2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.08),
            RangeSliderWidget(),
            SizedBox(height: 10),

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
            const UploadPhotoOrder(),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
