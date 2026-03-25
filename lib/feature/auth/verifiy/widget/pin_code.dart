import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../core/localization/strings.dart';
import '../../../../core/style/repo.dart';
import '../controller.dart';

class PinCode extends StatelessWidget {
  const PinCode({
    super.key,
    required this.controller,
  });

  final VerifyPageController controller;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      validator: (value) {
        if (value!.isEmpty) return tr(LocaleKeys.this_field_is_required);
        if (value.length < 4) return tr(LocaleKeys.code_must_be_4_digits);
        if (!RegExp(r'^[0-9]+$').hasMatch(value)) return tr(LocaleKeys.only_numbers_allowed);
        return null;
      },
      appContext: context,
      controller: controller.otp,
      length: 4,
      obscureText: false,
      animationType: AnimationType.none,
      textStyle: TextStyle(fontSize: 20, color: StyleRepo.green),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(8),
        fieldHeight: 60,
        fieldWidth: 70,
        activeColor: StyleRepo.green,
        selectedColor: StyleRepo.green,
        inactiveColor: StyleRepo.softGrey,
        activeFillColor: StyleRepo.softGreen,
        selectedFillColor: StyleRepo.softGreen,
        inactiveFillColor: StyleRepo.softGrey,
        fieldOuterPadding: EdgeInsets.zero,
      ),
      cursorHeight: 19,
      animationDuration: const Duration(milliseconds: 0),
      enableActiveFill: true,
      pastedTextStyle: TextStyle(color: StyleRepo.green),
      beforeTextPaste: (text) => true,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      autoFocus: true,
    );
  }
}