import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/feature/auth/verifiy/widget/pin_code.dart';
import 'package:renvo_app/feature/auth/verifiy/widget/resent_code.dart';
import '../../../../core/localization/strings.dart';
import '../../../../core/style/repo.dart';
import '../../../../core/widgets/svg_icon.dart';
import '../../../../gen/assets.gen.dart';
import '../controller.dart';

class VerifyForm extends StatelessWidget {
  const VerifyForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<VerifyPageController>();

    return Form(
      key: controller.formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            const SizedBox(height: 40),
            Row(
              children: [
                Text(
                  tr(LocaleKeys.verify_phone_number),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                ),
                const SizedBox(width: 5),
                SvgIcon(
                  icon: Assets.icons.verify,
                  color: StyleRepo.green,
                  size: 24,
                ),
              ],
            ),
            const SizedBox(width: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                tr(LocaleKeys.enter_the_code_send_to),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
            const SizedBox(height: 100),
            PinCode(controller: controller,),

            ResentCodeButton(),

            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Obx((){
                return controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator(
                  color: StyleRepo.blue,
                ),)
                    : ElevatedButton(
                  onPressed: controller.confirm,
                  child: Text(
                    tr(LocaleKeys.confirm),
                    style: TextStyle(color: StyleRepo.white, fontSize: 16),
                  ),
                );
              })

            ),
          ],
        ),
      ),
    );
  }
}

