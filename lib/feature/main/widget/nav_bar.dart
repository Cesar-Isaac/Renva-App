import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/config/app_builder.dart' show AppBuilder;
import 'package:renvo_app/core/style/repo.dart';
import 'package:renvo_app/core/widgets/svg_icon.dart';
import '../../../core/localization/strings.dart';
import '../../../gen/assets.gen.dart';
import '../controller.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainPageController>();
    final appBuilder = Get.find<AppBuilder>(); 

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: Obx(() {
          final isProvider = appBuilder.isProviderMode.value;

          final navItems =
              isProvider
                  ? [
                    {
                      'icon': Assets.icons.logoSVG,
                      'label': tr(LocaleKeys.home),
                    },

                    
                    {
                      'icon': Assets.icons.myOrder,
                      'label': tr(LocaleKeys.my_order),
                    },
                    {
                      'icon': Assets.icons.user,
                      'label': tr(LocaleKeys.profile),
                    },
                  ]
                  : [
                    {
                      'icon': Assets.icons.logoSVG,
                      'label': tr(LocaleKeys.home),
                    },

                    {'icon': Assets.icons.add, 'label': tr(LocaleKeys.add)},
                    
                    {
                      'icon': Assets.icons.myOrder,
                      'label': tr(LocaleKeys.my_order),
                    },
                    {
                      'icon': Assets.icons.user,
                      'label': tr(LocaleKeys.profile),
                    },
                  ];

          return Container(
            height: 70,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: StyleRepo.white1,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(navItems.length, (index) {
                final isSelected = controller.currentPage.value == index;

                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      
                      if (!isProvider &&
                          navItems[index]['label'] == tr(LocaleKeys.add)) {
                        controller.showNavBar.value = false;
                        Get.toNamed('/add_order')!.then((_) {
                          controller.showNavBar.value = true;
                        });
                      } else {
                        controller.currentPage.value = index;
                      }
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 12),
                        SvgIcon(
                          icon: navItems[index]['icon'] as SvgGenImage,
                          color: isSelected ? StyleRepo.blue : StyleRepo.grey,
                        ),
                        const SizedBox(height: 4),
                        Expanded(
                          child: Text(
                            navItems[index]['label'] as String,
                            style: TextStyle(
                              color:
                                  isSelected ? StyleRepo.blue : StyleRepo.grey,
                              fontWeight:
                                  isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          );
        }),
      ),
    );
  }
}
