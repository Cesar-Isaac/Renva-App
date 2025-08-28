import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/routes/routes.dart';
import 'package:renvo_app/core/services/state_management/widgets/obs_widget.dart';
import '../../../core/localization/strings.dart';
import '../../../core/style/repo.dart';
import '../../../gen/assets.gen.dart';
import 'controller.dart';

class JoinUsProviderPage extends StatelessWidget {
  const JoinUsProviderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(JoinUsProviderPageController());
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [StyleRepo.softBlue, StyleRepo.blue],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.offAllNamed(Pages.home.value);
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

                const SizedBox(height: 15),

                Text(
                  tr(LocaleKeys.select_services_type),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontSize: 26,
                    color: StyleRepo.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  tr(LocaleKeys.welcome_to_renva_join_us_service_provider),
                  maxLines: 4,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: StyleRepo.softGrey,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 10),

                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => controller.fetch(),
                    child: ObsListBuilder(
                      obs: controller.categories,
                      builder: (context, categories) {
                        return ListView.builder(
                          padding: const EdgeInsets.only(bottom: 52),
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            return Obx(() {
                              final isSelected = controller.selectedCategoryIds
                                  .contains(category.id);

                              return GestureDetector(
                                onTap:
                                    () => controller.toggleSelection(
                                      category.id!,
                                    ),
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 250),
                                  margin: EdgeInsets.only(bottom: 16),
                                  decoration: BoxDecoration(
                                    color: StyleRepo.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(17),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 12,
                                        height: 105,
                                        decoration: BoxDecoration(
                                          color:
                                              isSelected
                                                  ? StyleRepo.white
                                                  : null,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(9.5),
                                            bottomLeft: Radius.circular(9.5),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      SizedBox(
                                        width: 46.67,
                                        height: 42,
                                        child: Assets.icons.shop.svg(
                                          width: 56,
                                          height: 56,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              category.title,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: StyleRepo.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: StyleRepo.white,
                                        ),
                                      ),
                                      SizedBox(width: 25),
                                    ],
                                  ),
                                ),
                              );
                            });
                          },
                        );
                      },
                    ),
                  ),
                ),

                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          StyleRepo.white,
                        ),
                      ),

                      onPressed: () {
                        final selected =
                            controller.selectedCategoryIds.toList();
                        if (selected.isEmpty) {
                          Get.snackbar(
                            tr(LocaleKeys.error),
                            tr(LocaleKeys.please_select_at_least_one_category),
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                          return;
                        }

                        Get.toNamed(Pages.join_us_provider_form.value);
                      },

                      child: Text(
                        tr(LocaleKeys.next),
                        style: TextStyle(color: StyleRepo.blue, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
