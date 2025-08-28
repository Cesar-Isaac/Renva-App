
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:renvo_app/core/localization/strings.dart';

Widget buildAddressField(String label, TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label),
      const SizedBox(height: 8),
      TextFormField(
        controller: controller,
        validator: (value) => value!.isEmpty ? tr(LocaleKeys.this_field_is_required) : null,
      ),
      const SizedBox(height: 12),
    ],
  );
}
