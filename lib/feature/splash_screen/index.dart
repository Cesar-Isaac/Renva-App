import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/style/repo.dart';
import 'package:renvo_app/core/widgets/svg_icon.dart';
import 'package:renvo_app/gen/assets.gen.dart';

import 'controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SplashScreenController());
    return Container(
      decoration: BoxDecoration(
          color: StyleRepo.blue
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: StyleRepo.white,
                  shape: BoxShape.circle,
                ),
                child: AnimatedBuilder(
                  animation: controller.rotationController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: controller.rotationController.value * 2 * 3.1415926,
                      child: child,
                    );
                  },
                  child: SvgIcon(
                    icon: Assets.icons.logoSVG,
                    color: StyleRepo.blue,
                  ),
                ),
              ),

              SizedBox(
                width: 166,
                height: 34,
                child: SvgIcon(
                  icon: Assets.icons.renvoSVG,
                  color: StyleRepo.white,
                ),
              ),
            ],),
          SizedBox(height: 15,),
          Text('Recruitment,assistance and cooperation',
            textAlign: TextAlign.center,
            style: TextStyle(color: StyleRepo.white,fontSize: 12,
                decoration: TextDecoration.none


            ),
          ),

        ],),
    );
  }
}
