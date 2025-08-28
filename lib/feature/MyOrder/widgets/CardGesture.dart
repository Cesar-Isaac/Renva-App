import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class CardGesture extends StatelessWidget {
  const CardGesture({
    super.key,
    required this.dragCardOffset,
    required this.child,
  });

  final RxDouble dragCardOffset;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final double maxCardDrag = MediaQuery.of(context).size.width / 4;
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        dragCardOffset.value += -details.delta.dx;
        if (dragCardOffset.value < 0) dragCardOffset.value = 0;
        if (dragCardOffset.value > maxCardDrag)
          dragCardOffset.value = maxCardDrag;
      },
      onHorizontalDragEnd: (_) {
        if (dragCardOffset.value < maxCardDrag * 0.3) {
          dragCardOffset.value = 0;
        }
      },
      child: Transform.translate(
        offset: Offset(-dragCardOffset.value, 0),
        child: child,
      ),
    );
  }
}
