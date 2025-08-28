import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/core/routes/routes.dart';
import 'package:renvo_app/core/style/repo.dart';
import 'package:renvo_app/core/widgets/form_text_field.dart';
import 'package:renvo_app/core/widgets/svg_icon.dart';
import 'package:renvo_app/feature/add_offer/controller.dart';
import 'package:renvo_app/feature/add_offer/widgets/drop_down_field.dart';
import 'package:renvo_app/feature/add_offer/widgets/upload_photo_offer.dart';
import 'package:renvo_app/gen/assets.gen.dart';

class AddOffer extends StatelessWidget {
  const AddOffer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddOfferControoler());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: StyleRepo.transparent,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: StyleRepo.black, width: 2),
            ),
            child: Center(
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: StyleRepo.black,
                size: 20,
              ),
            ),
          ),
        ),
        title: Text(
          tr(LocaleKeys.add_offer),
          style: TextStyle(color: StyleRepo.black, fontSize: 20),
        ),
        titleSpacing: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              Text(
                tr(LocaleKeys.price),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 5),
              FormTextField(
                controller: controller.price,
                keyboardType: TextInputType.number,
                svgIcon: SvgIcon(
                  icon: Assets.icons.wallet,
                  size: 24,
                  color: StyleRepo.grey,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return tr(LocaleKeys.this_field_is_required);
                  }
                  return null;
                },
                hintText: "EX : 300 SEK",
              ),

              const SizedBox(height: 20),
               Text(
                tr(LocaleKeys.excution_time),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Time
                  Expanded(
                    child: TextFormField(
                      controller: controller.time,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: tr(LocaleKeys.count),
                        hintStyle: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return tr(LocaleKeys.please_enter_the_count);
                        }
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(width: 4),

                  /// Time Type Dropdown
                  Expanded(child: DropDownField(controller: controller)),

                  const SizedBox(width: 4),
                ],
              ),
              SizedBox(height: 10),

              Text(
                tr(LocaleKeys.add_photo),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 10),
              UploadPhotoOffer(),
              SizedBox(height: 10),
              Text(
                tr(LocaleKeys.description),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
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
              SizedBox(height: 20),

              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (!controller.formKey.currentState!.validate()) return;
                    Get.toNamed(Pages.review_offer.value);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 12,
                    ),
                    backgroundColor: StyleRepo.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    tr(LocaleKeys.send_offer),
                    style: TextStyle(color: StyleRepo.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
