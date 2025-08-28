import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/core/routes/routes.dart';
import 'package:renvo_app/core/style/repo.dart';
import 'package:renvo_app/feature/add/add_order_details/controller.dart';
import 'package:renvo_app/feature/add/add_order_details/widgets/sub_category_selection_page%20.dart';
import 'package:renvo_app/gen/assets.gen.dart';

class CategoryDetails extends StatelessWidget {
  const CategoryDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddOrderDetailsController());
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [StyleRepo.softBlue, StyleRepo.blue],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 54,
              left: 0,
              right: 0,
              child: Assets.icons.renvaAddHome.svg(),
            ),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 169.48794555664062,
                    height: 172.8550567626953,
                    child: Assets.icons.logoAddHome.svg(),
                  ),
                  Text(
                    tr(LocaleKeys.add_order),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontSize: 26,
                      color: StyleRepo.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    tr(LocaleKeys.select_services_type_to_completed_order),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: StyleRepo.softGrey,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),

                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        color: StyleRepo.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(36),
                          topRight: Radius.circular(36),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                controller.category.title,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            tr(LocaleKeys.choose_subcategory),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: StyleRepo.blue,
                            ),
                          ),
                          SizedBox(height: 10),
                          Expanded(child: SubCategorySelectionPage()),
                          SizedBox(height: 10),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                    StyleRepo.blue,
                                  ),
                                ),
                                onPressed: () {
                                  final selected =
                                      controller.selectedSubCategories;

                                  if (selected.length == 1) {
                                    Get.toNamed(
                                      Pages.add_order_step.value,
                                      arguments: {
                                        'category':
                                            controller.category.toJson(),
                                        'subCategoryId':
                                            selected
                                                .first.toJson(), 
                                      },
                                    );
                                  } else {
                                    Get.snackbar(
                                      tr(LocaleKeys.selection_required),
                                      tr(LocaleKeys.you_must_select_exactly_one_item_to_proceed),
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                      snackPosition: SnackPosition.TOP,
                                    );
                                  }
                                },

                                child: Text(
                                  tr(LocaleKeys.next),
                                  style: TextStyle(
                                    color: StyleRepo.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
