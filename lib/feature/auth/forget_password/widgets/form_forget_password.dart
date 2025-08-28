import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:renvo_app/core/localization/strings.dart';

import '../../../../core/style/repo.dart';
import '../../../../core/widgets/form_text_field.dart';
import '../../../../core/widgets/svg_icon.dart';
import '../../../../gen/assets.gen.dart';
import '../controller.dart';

class FormForgetPassword extends StatelessWidget {
  const FormForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForgetPasswordPageController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Form(
        key: controller.formKey,
        child: ListView(
          children: [
            Text(
              tr(LocaleKeys.enter_your_phone_number),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 20),
            FormTextField(
              keyboardType: TextInputType.phone,
              controller: controller.phoneNumber,
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
              hintText: 'Ex : +999 123 456 789',
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Obx(() {
                return controller.isLoading.value
                    ? const Center(
                      child: CircularProgressIndicator(color: StyleRepo.blue),
                    )
                    : ElevatedButton(
                      onPressed: controller.confirm,
                      child: Text(
                        tr(LocaleKeys.confirm),
                        style: TextStyle(color: StyleRepo.white, fontSize: 16),
                      ),
                    );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
