import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/core/style/repo.dart';
import 'package:renvo_app/feature/add_offer/controller.dart';

class DropDownField extends StatelessWidget {
  final AddOfferControoler controller;

  const DropDownField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DropdownButtonFormField<String>(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return tr(LocaleKeys.please_enter_a_time_type);
          }
          return null;
        },
        value:
            controller.selectedMonth.value.isNotEmpty
                ? controller.selectedMonth.value
                : null,
        onChanged: (val) => controller.selectedMonth.value = val ?? '',
        items:
            ['Hours', 'Days', 'Months'].map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(color: StyleRepo.grey, fontSize: 12),
                ),
              );
            }).toList(),
        hint: Text(
          
          tr(LocaleKeys.time_type),
          style: TextStyle(color: StyleRepo.grey, fontSize: 12),
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
        ),
      ),
    );
  }
}
