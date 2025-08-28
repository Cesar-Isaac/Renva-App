
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/core/style/repo.dart';

import 'package:renvo_app/feature/add/add_order_details/widgets/steper/step_3/controller.dart';

class RangeSliderWidget extends StatelessWidget {
  const RangeSliderWidget({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ControllerStep3>();
    return Obx(() {
      final values = controller.priceRange.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(
                tr(LocaleKeys.price_range),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: StyleRepo.grey,
                ),
              ),
              Text(
                ' ${values.start.round()} - ${values.end.round()} SEK',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: StyleRepo.grey,
                ),
              ),
            ],
          ),
      
          RangeSlider(
            values: values,
            min: 0,
            max: 400,
            divisions: 4,
            activeColor: StyleRepo.blue,
            labels: RangeLabels(
              '${values.start.round()} SEK',
              '${values.end.round()} SEK',
            ),
            onChanged: controller.updateRange,
          ),
          const SizedBox(height: 3),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '0 SEK',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: StyleRepo.grey,
                ),
              ),
              Text(
                '100 SEK',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: StyleRepo.grey,
                ),
              ),
              Text(
                '200 SEK',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: StyleRepo.grey,
                ),
              ),
              Text(
                '300 SEK',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: StyleRepo.grey,
                ),
              ),
              Text(
                '400 SEK',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: StyleRepo.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      );
    });
  }
}
