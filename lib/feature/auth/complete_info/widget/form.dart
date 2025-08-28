
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/feature/auth/complete_info/widget/pick_image_id.dart';
import 'package:renvo_app/feature/auth/complete_info/widget/pick_image_profile.dart';

import '../../../../core/localization/strings.dart';
import '../../../../core/style/repo.dart';
import '../../../../core/widgets/form_text_field.dart';
import '../../../../core/widgets/svg_icon.dart';
import '../../../../gen/assets.gen.dart';
import '../controller.dart';

class CompleteInfoForm extends StatelessWidget {

  const CompleteInfoForm({super.key, });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CompleteInfoPageController>();
    return Form(
        key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(children: [
            Text(tr(LocaleKeys.complete_information),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:8.0),
              child: Text(tr(LocaleKeys.add_your_information_to_create_new_account),
                style: TextStyle(fontSize: 14),
              ),
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                PickImageProfile(controller: controller,),
              ],
            ),

            SizedBox(height: 30,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              //##### ID Photo #######
              Text(tr(LocaleKeys.id_photo),
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
              ),
                SizedBox(height: 12,),
                PickImageId(controller:controller),
                SizedBox(height: 16,),
              //##### Full Name #####
              Text(tr(LocaleKeys.first_name),
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
              ),
                SizedBox(height: 12,),
                FormTextField(
                  controller: controller.name,
                  svgIcon:  SvgIcon(
                    icon: Assets.icons.user,
                    size: 25,
                    color: StyleRepo.grey,
                  ), validator: (value) {
                  if (value!.isEmpty) {
                    return tr(LocaleKeys.this_field_is_required);
                  }
                  return null;
                },
                  hintText: tr(LocaleKeys.first_name),

                ),
                //##### last Name #####
                SizedBox(height: 16,),
                Text(tr(LocaleKeys.last_name),
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
                ),
                SizedBox(height: 12,),
                FormTextField(
                  controller: controller.lastName,
                  svgIcon:  SvgIcon(
                    icon: Assets.icons.user,
                    size: 25,
                    color: StyleRepo.grey,
                  ), validator: (value) {
                  if (value!.isEmpty) {
                    return tr(LocaleKeys.this_field_is_required);
                  }
                  return null;
                },
                  hintText: tr(LocaleKeys.last_name),

                ),

                //##### Email #####


                SizedBox(height: 16,),
                Text(tr(LocaleKeys.email),
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
                ),
                SizedBox(height: 12,),
                FormTextField(
                  controller: controller.email,
                  svgIcon: SvgIcon(
                    icon: Assets.icons.email,
                    size: 25,
                    color: StyleRepo.grey,
                  ),  validator: (value) {
                  if (value!.isEmpty) {
                    return tr(LocaleKeys.this_field_is_required);
                  }
                  if (!value.contains("@gmail.com")) {
                    return tr(LocaleKeys.wrong_email);
                  }
                  return null;
                }, hintText: 'username@gmail.com',
                ),

                //##### National Number #####


                SizedBox(height: 16,),
                Text(tr(LocaleKeys.national_number),
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
                ),
                SizedBox(height: 12,),

                FormTextField(
                  controller: controller.nationalNumber,
                  keyboardType: TextInputType.number,
                  svgIcon: SvgIcon(
                    icon: Assets.icons.namtionNumber,
                    size: 25,
                    color: StyleRepo.grey,),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return tr(LocaleKeys.this_field_is_required);
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) return tr(LocaleKeys.only_numbers_allowed);

                    return null;
                  },
                  hintText: tr(LocaleKeys.add_national_number),
                ),

                //##### Gender #####

                SizedBox(height: 16,),
                Text(tr(LocaleKeys.gender),
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
                ),
                SizedBox(height: 12,),
                FormTextField(
                  controller: controller.gender,
                  svgIcon: SvgIcon( icon: Assets.icons.gender,
                    size: 25,
                    color: StyleRepo.grey,),
                  validator: (value ) {
                    if (value!.isEmpty) {
                      return tr(LocaleKeys.this_field_is_required);
                    }
                    return null;
                  },
                  hintText: 'Male',
                ),
                SizedBox(height: 20,),

            ],),
            
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Obx((){
                return controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator(),)
                    :ElevatedButton(
                  onPressed: controller.confirm,
                  child: Text(
                    tr(LocaleKeys.confirm),
                    style: TextStyle(color: StyleRepo.white, fontSize: 16),
                  ),
                );
              })

            ),
          
          ],),
        ));
  }
}


