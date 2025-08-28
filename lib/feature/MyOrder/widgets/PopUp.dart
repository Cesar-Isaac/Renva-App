import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/core/style/repo.dart';
import 'package:renvo_app/feature/MyOrder/CancelOrder/index.dart';
import 'package:renvo_app/feature/MyOrder/controller.dart';
import 'package:renvo_app/gen/assets.gen.dart';

class Popup extends StatelessWidget {
  final Widget icon;
  final int? id;
  const Popup({super.key, required this.icon, this.id});

  @override
  Widget build(BuildContext context) {
    Get.find<MyOrderPageController>(tag: 'myOrderPage');

    return IconButton(
      icon: icon,
      onPressed: () async {
        final RenderBox button = context.findRenderObject() as RenderBox;
        final RenderBox overlay =
            Overlay.of(context).context.findRenderObject() as RenderBox;
        final Offset offset = button.localToGlobal(
          Offset.zero,
          ancestor: overlay,
        );

        // اجعل القائمة تظهر أسفل الأيقونة
        final RelativeRect position = RelativeRect.fromLTRB(
          offset.dx,
          offset.dy + 40,
          0,
          0,
        );

        showMenu(
          color: StyleRepo.white,
          context: context,
          position: position,
          items: [
            PopupMenuItem(
              child: Row(
                children: [
                  Assets.icons.view.svg(),
                  const SizedBox(width: 4),
                  Text(
                    tr(LocaleKeys.view_details),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
            if (id != null)
              PopupMenuItem(
                child: IconButton(
                  onPressed: () {
                    Get.bottomSheet(
                      CancelBottomSheet(OrderId: id!),
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      backgroundColor: Colors.white,
                    );
                  },
                  icon: Row(
                    children: [
                      Assets.icons.cancel.svg(),
                      const SizedBox(width: 4),
                      Text(
                        tr(LocaleKeys.cancel_service),
                        style: Theme.of(
                          context,
                        ).textTheme.labelMedium!.copyWith(color: StyleRepo.red),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
