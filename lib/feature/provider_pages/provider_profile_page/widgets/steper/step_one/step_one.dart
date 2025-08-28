import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/core/services/state_management/widgets/obs_widget.dart';
import 'package:renvo_app/core/style/repo.dart';
import 'package:renvo_app/core/widgets/form_text_field.dart';
import 'package:renvo_app/core/widgets/image.dart';
import 'package:renvo_app/core/widgets/svg_icon.dart';
import 'package:renvo_app/feature/provider_pages/provider_profile_page/widgets/steper/step_one/controller_step_one.dart';
import 'package:renvo_app/feature/provider_pages/provider_profile_page/widgets/steper/widgets/uploaded_photo.dart';
import 'package:renvo_app/gen/assets.gen.dart';

class UpdateStepOne extends StatelessWidget {
  const UpdateStepOne({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ControllerStepOne>();

    return ObsVariableBuilder(
      obs: controller.profile,
      builder: (context, profile) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKeyStep1,

            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(height: 12),
                //#####  Name #####
                Text(
                  tr(LocaleKeys.name),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                SizedBox(height: 12),
                FormTextField(
                  controller: controller.name,
                  svgIcon: SvgIcon(
                    icon: Assets.icons.user,
                    size: 25,
                    color: StyleRepo.grey,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return tr(LocaleKeys.this_field_is_required);
                    }
                    return null;
                  },
                  hintText: tr(LocaleKeys.user_name),
                ),
                SizedBox(height: 12),

                //##### Phone Number #####
                SizedBox(height: 16),
                Text(
                  tr(LocaleKeys.phone_number),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                SizedBox(height: 12),

                FormTextField(
                  controller: controller.phoneNumber,
                  keyboardType: TextInputType.number,
                  svgIcon: SvgIcon(
                    icon: Assets.icons.phone,
                    size: 25,
                    color: StyleRepo.grey,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return tr(LocaleKeys.this_field_is_required);
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value))
                      return tr(LocaleKeys.only_numbers_allowed);

                    return null;
                  },
                  hintText: '+999 123 456 78',
                ),

                SizedBox(height: 12),

                Text(
                  tr(LocaleKeys.description),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 5),
                DottedBorder(
                  color: Colors.grey.withOpacity(0.4),
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(12),
                  dashPattern: [6, 4],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TextFormField(
                      controller: controller.description,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: tr(LocaleKeys.add_description),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        errorStyle: TextStyle(
                          color: StyleRepo.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      validator:
                          (value) =>
                              value == null || value.trim().isEmpty
                                  ? tr(LocaleKeys.this_field_is_required)
                                  : null,
                    ),
                  ),
                ),
                SizedBox(height: 12),

                Text(
                  tr(LocaleKeys.old_gallery),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.all(5),
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          controller.profile.value?.provider?.gallery
                              .asMap()
                              .entries
                              .map((entry) {
                                int index = entry.key;
                                var item = entry.value;

                                return Padding(
                                  padding: const EdgeInsets.only(right: 13),
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder:
                                            (_) => Dialog(
                                              backgroundColor: Colors.black,
                                              insetPadding: EdgeInsets.zero,
                                              child: PhotoViewGallery.builder(
                                                itemCount:
                                                    controller
                                                        .profile
                                                        .value
                                                        ?.provider
                                                        ?.gallery
                                                        .length ??
                                                    0,
                                                pageController: PageController(
                                                  initialPage: index,
                                                ),
                                                builder: (context, i) {
                                                  return PhotoViewGalleryPageOptions(
                                                    imageProvider: NetworkImage(
                                                      controller
                                                          .profile
                                                          .value!
                                                          .provider!
                                                          .gallery[i]
                                                          .originalUrl,
                                                    ),
                                                    heroAttributes:
                                                        PhotoViewHeroAttributes(
                                                          tag:
                                                              '${controller.profile.value!.provider!.gallery[i].originalUrl}$i',
                                                        ),
                                                  );
                                                },
                                                backgroundDecoration:
                                                    const BoxDecoration(
                                                      color: Colors.black,
                                                    ),
                                              ),
                                            ),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: AppImage(
                                        path: item.originalUrl,
                                        type: ImageType.CachedNetwork,
                                        fit: BoxFit.cover,
                                        width: 80,
                                        height: 80,
                                      ),
                                    ),
                                  ),
                                );
                              })
                              .toList() ??
                          [],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(tr(LocaleKeys.upload_photo)),
                const SizedBox(height: 5),
                FormField<bool>(
                  validator: (value) {
                    return controller.uploadedPhotos.length < 2
                        ? tr(LocaleKeys.at_least_two_images_must_be_uploaded)
                        : null;
                  },
                  builder: (field) => UpdatedPhotoField(field: field),
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
