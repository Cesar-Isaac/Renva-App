import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/core/style/repo.dart';
import 'package:renvo_app/feature/MyOrder/widgets/DialogDelete.dart';
import 'package:renvo_app/gen/assets.gen.dart';


class DeleteGesture extends StatelessWidget {
  final int id;

  DeleteGesture({
    super.key,
    required this.deleteButtonOffset,
    required this.dragCardOffset,
    required this.id,
  });

  final RxDouble deleteButtonOffset;
  final RxDouble dragCardOffset;

  @override
  Widget build(BuildContext context) {
    final double maxDeleteDrag = MediaQuery.of(context).size.width;

    return Obx(
      () => Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onHorizontalDragUpdate: (details) {
            deleteButtonOffset.value += -details.delta.dx;
            if (deleteButtonOffset.value < 0) deleteButtonOffset.value = 0;
            if (deleteButtonOffset.value > maxDeleteDrag)
              deleteButtonOffset.value = maxDeleteDrag;
          },
          onHorizontalDragEnd: (_) {
            if (deleteButtonOffset.value > maxDeleteDrag * 0.5) {
              showDialog(
                context: context,
                builder: (_) {
                  return Dialogdelete(id: id);
                },
              );
              dragCardOffset.value = 0;
            }
            deleteButtonOffset.value = 0;
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 150),
            width: 170 + deleteButtonOffset.value,
            height: 250,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child:
                deleteButtonOffset.value > 0
                    ? Center(
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.red[100],
                          borderRadius: BorderRadius.circular(38),
                          border: Border.all(color: StyleRepo.red, width: 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Assets.icons.delete.svg(),
                            SizedBox(width: 8),
                            Text(
                              tr(LocaleKeys.delete_order),
                              style: Theme.of(context).textTheme.labelSmall!
                                  .copyWith(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    )
                    : Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Assets.icons.delete.svg(),
                          SizedBox(height: 8),
                          Text(
                            tr(LocaleKeys.delete_order),
                            style: Theme.of(
                              context,
                            ).textTheme.labelSmall!.copyWith(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
          ),
        ),
      ),
    );
  }
}
