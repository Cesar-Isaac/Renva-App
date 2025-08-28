import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/core/style/repo.dart';
import 'package:renvo_app/feature/MyOrder/controller.dart';
import 'package:renvo_app/gen/assets.gen.dart';

class Dialogdelete extends StatelessWidget {
  final int id;

  Dialogdelete({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MyOrderPageController>(tag: 'myOrderPage');

    return AlertDialog(
      backgroundColor: StyleRepo.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: const EdgeInsets.all(24),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.icons.delete2.svg(height: 107, width: 107),
          Text(
            tr(LocaleKeys.are_you_sure_you_want_to_delete_the_request),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          SizedBox(height: 45),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(120, 40),
                    backgroundColor: Color(0xFFEFEFFB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    tr(LocaleKeys.cancel),
                    style: Theme.of(
                      context,
                    ).textTheme.labelSmall!.copyWith(color: StyleRepo.blue),
                  ),
                ),
              ),
              SizedBox(width: 5),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    controller.appBuilder.isProviderMode.value == true
                        ? controller.DeleteOffer(id)
                        : controller.deleteOrderCust(id);
                    
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: StyleRepo.midumRed,
                    fixedSize: Size(120, 40),
                    side: BorderSide(color: StyleRepo.red, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    tr(LocaleKeys.delete),
                    style: Theme.of(
                      context,
                    ).textTheme.labelSmall!.copyWith(color: StyleRepo.red),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
