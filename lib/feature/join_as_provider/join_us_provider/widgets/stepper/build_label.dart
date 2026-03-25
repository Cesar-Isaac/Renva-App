import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Widget buildLabel(String key) {
  return Text(
    tr(key),
    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
  );
}
