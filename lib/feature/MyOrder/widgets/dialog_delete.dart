import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/localization/strings.dart';

import '../../../core/style/repo.dart';
import '../../../core/widgets/svg_icon.dart';
import '../../../gen/assets.gen.dart';

class DialogDeleteCard extends StatelessWidget {
  const DialogDeleteCard({
    super.key,
    required this.onDelete,
  });

  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgIcon(
          icon: Assets.icons.delete3,
          color: StyleRepo.red.withOpacity(0.1),
          size: 80,
        ),
        const SizedBox(height: 12),
        Text(
          tr(LocaleKeys.are_you_sure_you_want_to_delete_the_request),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Get.back(),
                style: OutlinedButton.styleFrom(
                  foregroundColor: StyleRepo.deepPurple, 
                  backgroundColor: StyleRepo.purpleSoft,
                  side: BorderSide(color: StyleRepo.purpleSoft), 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child:  Text(tr(LocaleKeys.cancel)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Get.back(); 
                  onDelete(); 
                
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: StyleRepo.red, 
                  backgroundColor: StyleRepo.red.withOpacity(0.3),
                  side: BorderSide(color: StyleRepo.red), 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child:  Text(tr(LocaleKeys.delete)),
              ),
            ),

          ],
        ),
      ],
    );
  }
}

