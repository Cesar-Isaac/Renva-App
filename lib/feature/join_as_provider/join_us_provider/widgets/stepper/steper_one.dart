import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../core/localization/strings.dart';
import '../../../../../core/style/repo.dart';
import '../../../../../core/widgets/form_text_field.dart';
import '../../../../../core/widgets/svg_icon.dart';
import '../../../../../gen/assets.gen.dart';
import '../../controller.dart';
import '../pick_image_provider.dart';
import '../radio_select.dart';
import 'build_label.dart';

class StepOne extends StatelessWidget {
  const StepOne({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JoinUsProviderPageController>();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: controller.formKeyStep1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(child: PickImageProviderPage()),
            const SizedBox(height: 20),
            buildLabel(LocaleKeys.user_name),
            FormTextField(
              controller: controller.nameProv,
              svgIcon: SvgIcon(
                icon: Assets.icons.user,
                size: 25,
                color: StyleRepo.grey,
              ),
              validator:
                  (value) =>
                      value!.isEmpty
                          ? tr(LocaleKeys.this_field_is_required)
                          : null,
              hintText: tr(LocaleKeys.user_name),
            ),
            const SizedBox(height: 16),
            buildLabel(LocaleKeys.email),
            FormTextField(
              controller: controller.email,
              svgIcon: SvgIcon(
                icon: Assets.icons.email,
                size: 25,
                color: StyleRepo.grey,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return tr(LocaleKeys.this_field_is_required);
                }
                if (!value.contains("@gmail.com")) {
                  return tr(LocaleKeys.wrong_email);
                }
                return null;
              },
              hintText: 'username@gmail.com',
            ),
            const SizedBox(height: 16),
            buildLabel(LocaleKeys.phone_number),
            FormTextField(
              controller: controller.phoneNumber,
              keyboardType: TextInputType.number,
              svgIcon: SvgIcon(
                icon: Assets.icons.phone,
                size: 25,
                color: StyleRepo.grey,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return tr(LocaleKeys.this_field_is_required);
                }
                if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                  return tr(LocaleKeys.only_numbers_allowed);
                }
                return null;
              },
              hintText: '+999 123 456 78',
            ),
            const SizedBox(height: 12),
            RadioSelect(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
