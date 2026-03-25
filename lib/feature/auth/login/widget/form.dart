import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/localization/strings.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/style/repo.dart';
import '../../../../core/widgets/form_text_field.dart';
import '../../../../core/widgets/svg_icon.dart';
import '../../../../gen/assets.gen.dart';
import '../controller.dart';

class FormLogin extends StatelessWidget {
  final LoginPageController controller;
  const FormLogin({
    super.key, required this.controller,
  });
  @override
  Widget build(BuildContext context) {

    return
      Form(
        key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(children: [
            Row(
              children: [
                Text(tr(LocaleKeys.welcome_to),
                  style:TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                  ) ,
                ),
                SizedBox(width: 12,),
                SvgIcon(
                  icon: Assets.icons.renvoSVG,
                  color: StyleRepo.blue,
                  size: 70,
                ),

              ],
            ),
            SizedBox(height: 8,),
            Row(children: [
              Expanded(
                child: Text(tr(LocaleKeys.login_to_your_account),
                  style:TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                  ) ,),
              ),
              SizedBox(width: 8,),
              SvgIcon(
                icon: Assets.icons.smileSVG,
                color: StyleRepo.green,
                size: 30,
              ),
            ],),
            SizedBox(height: 5,),

            Text(tr(LocaleKeys.enter_the_following_info_to_reach_your_account)
              ,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 20,),


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
                        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return tr(LocaleKeys.only_numbers_allowed) ;
                        }
                        return null;
                        },
                    hintText: 'Ex : +999 123 456 789'
                ),



                const SizedBox(height: 24),

                // ====== Password ======
                Text(
                  tr(LocaleKeys.password),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Obx(() =>
                    TextFormField(
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
                                icon: Assets.icons.password,
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
                          icon: controller.obscurePassword.value
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
                          return  tr(LocaleKeys.this_field_is_required);
                        }
                        if (value.length < 5) {
                          return tr(LocaleKeys.password_must_be_at_least_6_characters);
                        }

                        return null;
                      },
                    
                    ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Get.toNamed(Pages.forget_password.value),
                  child: Text(tr(LocaleKeys.forget_passwords),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: StyleRepo.black
                  ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 50,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Obx((){
                  return controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator(
                    color: StyleRepo.blue,
                  ))
                    : ElevatedButton(
                    onPressed: controller.confirm,
                    child:  Text(tr(LocaleKeys.login),
                      style: TextStyle(
                          color: StyleRepo.white,
                          fontSize: 16
                      ),
                    ),
                  );
                })

            ),
            TextButton(
              onPressed: () => Get.toNamed(Pages.signup.value),
              child: Text(tr(LocaleKeys.sign_up),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: StyleRepo.green,
                  fontSize: 16

                ),
              ),
            ),

         
          
          ],),
        )
    );
  }
}

