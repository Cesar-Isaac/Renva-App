import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/localization/strings.dart';
import '../../../../core/style/repo.dart';
import '../../../../core/widgets/image.dart';
import '../../../../core/widgets/svg_icon.dart';
import '../../../../gen/assets.gen.dart';
import '../controller.dart';

class PickImageProviderPage extends StatelessWidget {
  const PickImageProviderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JoinUsProviderPageController>();

    return FormField<String>(
      initialValue: controller.image.value,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return tr(LocaleKeys.this_field_is_required);
        }
        return null;
      },
      builder: (state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Obx(() {
                  return controller.image.value.isEmpty
                      ? Container(
                    width: 140,
                    height: 140,
                    decoration:
                    const BoxDecoration(shape: BoxShape.circle),
                    child: Center(
                      child: SvgIcon(
                        icon: Assets.icons.pickProvider,
                        size: 140,
                        color: StyleRepo.transparent,
                      ),
                    ),
                  )
                      : AppImage(
                    path: controller.image.value,
                    type: ImageType.File,
                    height: 140,
                    width: 140,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle),
                  );
                }),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: TextButton(
                    onPressed: () async {
                      await controller.pickImageProvider();
                      
                      if (state.mounted) {
                        state.didChange(controller.image.value);
                      }
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: const CircleBorder(),
                    ),
                    child: Container(
                      width: 41,
                      height: 41,
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: StyleRepo.white,
                        shape: BoxShape.circle,
                      ),
                      child: SvgIcon(
                        icon: Assets.icons.photocamera,
                        color: StyleRepo.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  state.errorText!,
                  style: const TextStyle(color: StyleRepo.red),
                ),
              ),
          ],
        );
      },
    );
  }
}


