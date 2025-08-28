import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/widgets/form_text_field.dart';
import 'package:renvo_app/feature/auth/signup/controller.dart';

import '../../../../core/localization/strings.dart';
import '../../../../core/style/repo.dart';
import '../../../../core/widgets/svg_icon.dart';
import '../../../../gen/assets.gen.dart';

class FormsSignUp extends StatelessWidget {
  final SignUpPageController controller;
  const FormsSignUp({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            Text(
              tr(LocaleKeys.create_new_account),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            ),
            SizedBox(height: 12),
            Text(tr(LocaleKeys.add_your_information_to_create_new_account)),
            SizedBox(height: 50),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ====== Phone Number ======
                Text(
                  tr(LocaleKeys.phone_number),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                FormTextField(
                  keyboardType: TextInputType.phone,
                  controller: controller.phone,
                  svgIcon: SvgIcon(
                    icon: Assets.icons.phone,
                    size: 25,
                    color: StyleRepo.grey,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return tr(LocaleKeys.this_field_is_required);
                    }
                    return null;
                  },
                  hintText: 'Ex : +999 123 456 789',
                ),
                const SizedBox(height: 20),

                // ====== Password ======
                Text(
                  tr(LocaleKeys.password),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Obx(
                  () => TextFormField(
                    controller: controller.password,
                    obscureText: controller.obscurePassword.value,
                    decoration: InputDecoration(
                      hintText: '*** *** ***',
                      prefixIcon: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        width: 60,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgIcon(
                              icon: Assets.icons.key,
                              size: 25,
                              color: StyleRepo.grey,
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 1,
                              height: 24,
                              color: StyleRepo.grey,
                            ),
                          ],
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon:
                            controller.obscurePassword.value
                                ? SvgIcon(
                                  icon: Assets.icons.invisible,
                                  color: StyleRepo.grey,
                                )
                                : SvgIcon(
                                  icon: Assets.icons.visible,
                                  color: StyleRepo.grey,
                                ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return tr(LocaleKeys.this_field_is_required);
                      }
                      if (value.length < 5) {
                        return tr(
                          LocaleKeys.password_must_be_at_least_6_characters,
                        );
                      }

                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),

                // ====== Confirm Password ======
                Text(
                  tr(LocaleKeys.confirm_password),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Obx(
                  () => TextFormField(
                    controller: controller.confirmPassword,
                    obscureText: controller.obscureConfirmPassword.value,
                    decoration: InputDecoration(
                      hintText: '*** *** ***',
                      prefixIcon: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        width: 60,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgIcon(
                              icon: Assets.icons.key,
                              size: 25,
                              color: StyleRepo.grey,
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 1,
                              height: 24,
                              color: StyleRepo.grey,
                            ),
                          ],
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon:
                            controller.obscureConfirmPassword.value
                                ? SvgIcon(
                                  icon: Assets.icons.invisible,
                                  color: StyleRepo.grey,
                                )
                                : SvgIcon(
                                  icon: Assets.icons.visible,
                                  color: StyleRepo.grey,
                                ),
                        onPressed: controller.toggleConfirmPasswordVisibility,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return tr(LocaleKeys.this_field_is_required);
                      }
                      if (value.length < 5) {
                        return tr(
                          LocaleKeys.password_must_be_at_least_6_characters,
                        );
                      }

                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
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
