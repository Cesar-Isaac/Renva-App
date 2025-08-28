import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/feature/MyOrder/widgets/CardGesture.dart';
import 'package:renvo_app/feature/MyOrder/widgets/DeleteGesture.dart';



class SwipeableCard extends StatelessWidget {
  final Widget child;
  final VoidCallback onDelete;
  final int id;

  SwipeableCard({
    required this.child,
    required this.onDelete,
    required this.id,
  });
  final RxDouble dragCardOffset = 0.0.obs;
  final RxDouble deleteButtonOffset = 0.0.obs;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Stack(
        children: [
          CardGesture(dragCardOffset: dragCardOffset, child: child),
          if (dragCardOffset.value > 0)
            DeleteGesture(
              deleteButtonOffset: deleteButtonOffset,
              id: id,
              dragCardOffset: dragCardOffset,
            ),
        ],
      );
    });
  }
}
