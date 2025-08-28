import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/core/style/repo.dart';
import 'package:renvo_app/core/widgets/svg_icon.dart';
import 'package:renvo_app/feature/provider_pages/provider_home_page/controller.dart';
import 'package:renvo_app/feature/provider_pages/provider_home_page/widgets/order_card.dart';
import 'package:renvo_app/gen/assets.gen.dart';

class Bodypage extends StatelessWidget {
  const Bodypage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProviderHomePageController>();

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: StyleRepo.white,
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tr(LocaleKeys.latest_order),
                      style: TextStyle(
                        color: StyleRepo.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SvgIcon(
                      icon: Assets.icons.searchList,
                      size: 24,
                      color: StyleRepo.grey,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  tr(LocaleKeys.requests_sent_from_newest_to_oldest),
                  style: TextStyle(
                    color: StyleRepo.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              Expanded(child: OrderCards(controller: controller)),
            ],
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.sizeOf(context).height * 0.2,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [StyleRepo.transparent, StyleRepo.white],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
