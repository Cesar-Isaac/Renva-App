import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renva/core/config/app_builder.dart';
import 'package:renva/core/style/repo.dart';
import 'package:renva/core/widgets/svg_icon.dart';
import 'package:renva/feature/profile/edit_profile/widget/form_list.dart';
import 'package:renva/feature/profile/profile/widget/pick_image_edit_profile.dart';
import 'package:renva/gen/assets.gen.dart';
import '../../../core/localization/strings.dart';
import '../profile/controller.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfilePageController>();
    final appBuilder = Get.find<AppBuilder>();
    final isProvider = appBuilder.isProviderMode.value;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StyleRepo.transparent,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: StyleRepo.black, width: 2),
            ),
            child: Center(
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: StyleRepo.black,
                size: 20,
              ),
            ),
          ),
        ),

        title: Text(
          tr(LocaleKeys.back),
          style: TextStyle(color: StyleRepo.black, fontSize: 20),
        ),
        titleSpacing: 0,
      ),

      body: Stack(
        children: [
          Positioned(
            top: -50,
            right: -20,

            child: SvgIcon(
              icon: Assets.icons.biglogo,
              size: 400,
              color: StyleRepo.blue,
            ),
          ),

          Form(
            key: controller.formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView(
                children: [
                  Center(child: PickImageEditProfile()),
                  SizedBox(height: 16),
                  FormList(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Obx(() {
                        return controller.isLoading.value
                            ? const Center(child: CircularProgressIndicator())
                            : ElevatedButton(
                              onPressed:
                                  () =>
                                      isProvider
                                          ? SizedBox()
                                          : controller.save(),
                              child: Text(
                                isProvider
                                    ? tr(LocaleKeys.next)
                                    : tr(LocaleKeys.save),
                                style: TextStyle(
                                  color: StyleRepo.white,
                                  fontSize: 16,
                                ),
                              ),
                            );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
