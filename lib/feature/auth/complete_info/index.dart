import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/feature/auth/complete_info/controller.dart';
import 'package:renvo_app/feature/auth/complete_info/widget/form.dart';

import '../../../core/style/repo.dart';
import '../../../core/widgets/svg_icon.dart';
import '../../../gen/assets.gen.dart';

class CompleteInfoPage extends StatelessWidget {
  const CompleteInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CompleteInfoPageController());
    return Scaffold(
      backgroundColor: StyleRepo.blue,
      appBar: AppBar(
        titleSpacing: 0,
        leading: AppBar(backgroundColor: StyleRepo.transparent),

        backgroundColor: StyleRepo.blue,
      ),

      body: Container(
        decoration: BoxDecoration(
          color: StyleRepo.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(35),
            topLeft: Radius.circular(35),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: SvgIcon(
                icon: Assets.icons.biglogo,
                size: 400,
                color: StyleRepo.blue,
              ),
            ),
            CompleteInfoForm(),
          ],
        ),
      ),
    );
  }
}
