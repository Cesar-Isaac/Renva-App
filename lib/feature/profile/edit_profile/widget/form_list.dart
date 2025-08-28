import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/services/state_management/widgets/obs_widget.dart';
import '../../../../core/localization/strings.dart';
import '../../../../core/style/repo.dart';
import '../../../../core/widgets/form_text_field.dart';
import '../../../../core/widgets/svg_icon.dart';
import '../../../../gen/assets.gen.dart';
import '../../profile/controller.dart';

class FormList extends StatelessWidget {
  const FormList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfilePageController>();

    return ObsVariableBuilder(
      obs: controller.profile,
      builder: (context, profile) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12),
            //##### First Name #####
            Text(
              tr(LocaleKeys.first_name),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            SizedBox(height: 12),
            FormTextField(
              controller: controller.firstName,

              svgIcon: SvgIcon(
                icon: Assets.icons.user,
                size: 25,
                color: StyleRepo.grey,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return tr(LocaleKeys.this_field_is_required);
                }
                return null;
              },
              hintText: tr(LocaleKeys.user_name),
            ),
            //##### Last Name #####
            SizedBox(height: 16),
            Text(
              tr(LocaleKeys.last_name),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            SizedBox(height: 12),
            FormTextField(
              controller: controller.lastName,
              svgIcon: SvgIcon(
                icon: Assets.icons.user,
                size: 25,
                color: StyleRepo.grey,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return tr(LocaleKeys.this_field_is_required);
                }
                return null;
              },
              hintText: tr(LocaleKeys.user_name),
            ),

            //##### Email #####
            SizedBox(height: 16),
            Text(
              tr(LocaleKeys.email),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            SizedBox(height: 12),
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

            //##### Phone Number #####
            SizedBox(height: 16),
            Text(
              tr(LocaleKeys.phone_number),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            SizedBox(height: 12),

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
                if (!RegExp(r'^[0-9]+$').hasMatch(value))
                  return tr(LocaleKeys.only_numbers_allowed);

                return null;
              },
              hintText: '+999 123 456 78',
            ),

            //##### Gender #####
            SizedBox(height: 16),
            Text(
              tr(LocaleKeys.gender),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            SizedBox(height: 12),
            FormTextField(
              controller: controller.gender,
              svgIcon: SvgIcon(
                icon: Assets.icons.gender,
                size: 25,
                color: StyleRepo.grey,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return tr(LocaleKeys.this_field_is_required);
                }
                return null;
              },
              hintText: tr(LocaleKeys.male_female),
            ),
          ],
        );
      },
    );
  }
}
