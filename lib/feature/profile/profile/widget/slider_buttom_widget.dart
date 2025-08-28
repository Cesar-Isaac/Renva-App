import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/config/app_builder.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/core/style/repo.dart';
import 'package:renvo_app/core/widgets/svg_icon.dart';
import 'package:renvo_app/feature/MyOrder/controller.dart';
import 'package:renvo_app/gen/assets.gen.dart';

import 'package:slide_to_act/slide_to_act.dart';

class AccountSwitchMode extends StatelessWidget {
  const AccountSwitchMode({super.key});

  @override
  Widget build(BuildContext context) {
    final myOrder = Get.put(MyOrderPageController(), tag: 'myOrderPage');

    return Obx(() {
      final appBuilder = Get.find<AppBuilder>();
      final isProvider = appBuilder.isProviderMode.value;

      final label =
          isProvider
              ? tr(LocaleKeys.login_as_user)
              : tr(LocaleKeys.login_as_a_service_provider);

      final background = isProvider ? StyleRepo.softGreen : StyleRepo.white;
      final sliderColor = isProvider ? StyleRepo.softGreen : StyleRepo.white;
      final borderColor = isProvider ? StyleRepo.green : StyleRepo.blue;
      final textColor = isProvider ? StyleRepo.green : StyleRepo.blue;
      final icon =
          isProvider
              ? SvgIcon(
                icon: Assets.icons.iconProvider,
                size: 38,
                color: StyleRepo.transparent,
              )
              : SvgIcon(
                icon: Assets.icons.iconUser,
                size: 38,
                color: StyleRepo.transparent,
              );

      return Container(
        width: 380,
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(27),
          border: Border.all(color: borderColor, width: 2),
        ),
        child: SlideAction(
          sliderButtonIconPadding: 0,
          outerColor: background,
          innerColor: sliderColor,
          borderRadius: 27,
          elevation: 0,
          text: label,
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
          sliderButtonIcon: icon,
          alignment: Alignment.centerRight,
          onSubmit: () {
            appBuilder.isProviderMode.value = !isProvider;
            myOrder.refreshAllPagers();

            return null;
          },
        ),
      );
    });
  }
}
