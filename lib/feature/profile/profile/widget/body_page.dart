import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/services/state_management/widgets/obs_widget.dart';
import 'package:renvo_app/core/widgets/svg_icon.dart';
import 'package:renvo_app/feature/profile/profile/widget/slider_buttom_widget.dart';
import 'package:renvo_app/gen/assets.gen.dart';

import '../../../../core/localization/strings.dart';
import '../../../../core/style/repo.dart';
import '../../../../core/widgets/image.dart';
import '../controller.dart';
import 'dialod_delete_account.dart';
import 'dialog_logout.dart';

class BodyPage extends StatelessWidget {
  const BodyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfilePageController>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: ObsVariableBuilder(
        obs: controller.profile,
        builder: (context, profile) {
          final provider = profile.provider;
          return ListView(
            children: [
              if (provider != null) AccountSwitchMode(),
              SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: 183,
                      height: 146,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: StyleRepo.creamWhite,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            tr(LocaleKeys.loyalty_point),
                            style: TextStyle(
                              color: StyleRepo.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          AppImage(
                            path: 'assets/image/loyaltyPoint.png',
                            type: ImageType.Asset,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),

                  Expanded(
                    child: Container(
                      width: 183,
                      height: 146,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: StyleRepo.creamWhite,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            tr(LocaleKeys.payment),
                            style: TextStyle(
                              color: StyleRepo.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          AppImage(
                            path: 'assets/image/payment.png',
                            type: ImageType.Asset,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Text(
                    tr(LocaleKeys.account),
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: StyleRepo.black,
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgIcon(
                        icon: Assets.icons.location,
                        color: StyleRepo.grey,
                      ),
                      SizedBox(width: 10),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          tr(LocaleKeys.my_location),
                          style: TextStyle(
                            color: StyleRepo.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgIcon(
                        icon: Assets.icons.changePassword,
                        color: StyleRepo.grey,
                      ),
                      SizedBox(width: 10),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          tr(LocaleKeys.change_password),
                          style: TextStyle(
                            color: StyleRepo.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgIcon(
                            icon: Assets.icons.notificationBox,
                            color: StyleRepo.grey,
                          ),
                          SizedBox(width: 20),
                          Text(
                            tr(LocaleKeys.app_notification),
                            style: TextStyle(
                              color: StyleRepo.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Obx(
                        () => Switch(
                          activeTrackColor: Colors.green,
                          activeColor: StyleRepo.white,
                          inactiveThumbColor: StyleRepo.deepGrey,
                          inactiveTrackColor: StyleRepo.softGrey,
                          value: controller.isNotification.value,
                          onChanged: controller.toggleNotification,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgIcon(
                        icon: Assets.icons.privacy,
                        color: StyleRepo.grey,
                      ),
                      SizedBox(width: 10),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          tr(LocaleKeys.privacy_policy),
                          style: TextStyle(
                            color: StyleRepo.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgIcon(
                        icon: Assets.icons.contact,
                        color: StyleRepo.grey,
                      ),
                      SizedBox(width: 10),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          tr(LocaleKeys.contact_us),
                          style: TextStyle(
                            color: StyleRepo.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgIcon(icon: Assets.icons.faq, color: StyleRepo.grey),
                      SizedBox(width: 10),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          tr(LocaleKeys.faq),
                          style: TextStyle(
                            color: StyleRepo.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgIcon(
                            icon: Assets.icons.translate,
                            color: StyleRepo.grey,
                          ),
                          SizedBox(width: 20),
                          Text(
                            tr(LocaleKeys.language),
                            style: TextStyle(
                              color: StyleRepo.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      Obx(
                        () => Switch(
                          activeTrackColor: Colors.green,
                          activeColor: StyleRepo.white,
                          inactiveThumbColor: StyleRepo.deepGrey,
                          inactiveTrackColor: StyleRepo.softGrey,
                          value: controller.isTranslate.value,
                          onChanged:
                              (value) =>
                                  controller.toggleTranslation(value, context),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgIcon(icon: Assets.icons.logout, color: StyleRepo.red),
                      SizedBox(width: 10),
                      Obx(() {
                        return controller.isLoading.value
                            ? const Center(child: CircularProgressIndicator())
                            : TextButton(
                              onPressed: () {
                                Get.defaultDialog(
                                  barrierDismissible: false,
                                  radius: 20,
                                  backgroundColor: Colors.white,
                                  titlePadding: EdgeInsets.zero,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  title: '',
                                  content: DialogLogOut(),
                                );
                              },
                              child: Text(
                                tr(LocaleKeys.logout),
                                style: TextStyle(
                                  color: StyleRepo.red,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                      }),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgIcon(icon: Assets.icons.delete, color: StyleRepo.red),
                      SizedBox(width: 10),
                      Obx(() {
                        return controller.isLoading.value
                            ? const Center(child: CircularProgressIndicator())
                            : TextButton(
                              onPressed: () {
                                Get.defaultDialog(
                                  barrierDismissible: false,
                                  radius: 20,
                                  backgroundColor: Colors.white,
                                  titlePadding: EdgeInsets.zero,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  title: '',
                                  content: DialogDeleteAccount(),
                                );
                              },
                              child: Text(
                                tr(LocaleKeys.delete_my_account),
                                style: TextStyle(
                                  color: StyleRepo.red,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                      }),
                    ],
                  ),
                  SizedBox(height: 100),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
