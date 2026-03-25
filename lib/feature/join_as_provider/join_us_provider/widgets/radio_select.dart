import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/localization/strings.dart';
import '../../../../core/style/repo.dart';
import '../controller.dart';

class RadioSelect extends StatelessWidget {
  const RadioSelect({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JoinUsProviderPageController>();

    return FormField<String>(
      initialValue: controller.selectedOption.value,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return tr(LocaleKeys.this_field_is_required);
        }
        return null;
      },
      builder: (FormFieldState<String> state) {
        return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RadioListTile<String>(
              title: Text(
                tr(LocaleKeys.i_provide_a_service_in_a_sSpecific_place),
                style: TextStyle(fontSize: 16, color: StyleRepo.grey, fontWeight: FontWeight.w700),
              ),
              value: "specific",
              groupValue: controller.selectedOption.value,
              onChanged: (value) {
                controller.selectOption(value!);
                state.didChange(value); 
              },
              activeColor: StyleRepo.deepBlue,
            ),
            RadioListTile<String>(
              title: Text(
                tr(LocaleKeys.i_provide_services_in_all_regions),
                style: TextStyle(fontSize: 16, color: StyleRepo.grey, fontWeight: FontWeight.w700),
              ),
              value: "all",
              groupValue: controller.selectedOption.value,
              onChanged: (value) {
                controller.selectOption(value!);
                state.didChange(value);
              },
              activeColor: StyleRepo.deepBlue,
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  state.errorText!,
                  style: TextStyle(color: StyleRepo.red),
                ),
              ),
          ],
        ));
      },
    );
  }
}

