import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/widgets/svg_icon.dart';
import 'package:renvo_app/feature/auth/complete_info/controller.dart';
import 'package:renvo_app/gen/assets.gen.dart';

import '../../../../core/localization/strings.dart';
import '../../../../core/style/repo.dart';
import '../../../../core/widgets/image.dart';

class PickImageProfile extends StatelessWidget {
  const PickImageProfile({
    super.key,
    required this.controller,
  });

  final CompleteInfoPageController controller;

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: controller.image.value,
      validator: (value) {
        if (value!.isEmpty) {
          return tr(LocaleKeys.this_field_is_required);
        }
        return null;
      },
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Obx(
                      () => controller.image.isEmpty
                      ? Container(

                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: state.hasError
                            ? Theme.of(context).colorScheme.error
                            : StyleRepo.grey,
                      ),
                    ),
                    child: SvgIcon(
                      icon: Assets.icons.user,
                      size: 80,
                      color: StyleRepo.grey,
                    ),
                  )
                      : AppImage(
                    path: controller.image.value,
                    type: ImageType.File,
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                TextButton(
                  onPressed: () async {
                    await controller.pickImage();
                    state.didChange(controller.image.value);
                  },
                  child: Text(
                    tr(LocaleKeys.add_profile_photo),
                    style: TextStyle(color: StyleRepo.black,
                    decoration: TextDecoration.underline

                    ),
                  ),
                ),
              ],
            ),
            if (state.hasError) SizedBox(height: 8),
            if (state.hasError)
              Text(
                state.errorText!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontSize: 12,
                ),
              ),
          ],
        );
      },
    );
  }
}
