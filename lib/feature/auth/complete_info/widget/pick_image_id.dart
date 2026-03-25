import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/localization/strings.dart';
import '../../../../core/style/repo.dart';
import '../../../../core/widgets/image.dart';
import '../../../../core/widgets/svg_icon.dart';
import '../../../../gen/assets.gen.dart';
import '../controller.dart';

class PickImageId extends StatelessWidget {
  const PickImageId({
    super.key,
    required this.controller,
  });

  final CompleteInfoPageController controller;

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: controller.imageId.value,
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
                      () => controller.imageId.isEmpty
                      ? Container(
                        padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: StyleRepo.grey,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: state.hasError
                            ? Theme.of(context).colorScheme.error
                            : StyleRepo.grey,
                      ),
                    ),
                    child: SvgIcon(
                      icon: Assets.icons.camera,
                      size: 60,
                      color: StyleRepo.white,
                    ),
                  )
                      : AppImage(
                    path: controller.imageId.value,
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
                    await controller.pickImageID();
                    state.didChange(controller.imageId.value);
                  },
                  child: Text(
                    tr(LocaleKeys.add_photo),
                    style: TextStyle(color: StyleRepo.grey,


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