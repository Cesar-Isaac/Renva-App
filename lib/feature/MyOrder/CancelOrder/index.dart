import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/core/services/state_management/widgets/obs_widget.dart';
import 'package:renvo_app/core/style/repo.dart';
import 'package:renvo_app/feature/MyOrder/CancelOrder/controller.dart';

class CancelBottomSheet extends StatelessWidget {
  final int OrderId;

  const CancelBottomSheet({super.key, required this.OrderId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CancelController());

    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              tr(LocaleKeys.reason_of_canceled),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: StyleRepo.blue,
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            tr(LocaleKeys.please_specify_the_reason_for_canceling_the_order),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: StyleRepo.darkgrey,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 16),

          ObsListBuilder(
            obs: controller.resson,
            builder: (context, resson) {
              return Form(
                key: controller.formKey,
                child: FormField<int>(
                  validator: (value) {
                    if (controller.selectedReasonId.value == null) {
                      return tr(LocaleKeys.please_select_a_cancellation_reason);
                    }
                    return null;
                  },
                  builder: (field) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: resson.length,
                          itemBuilder: (context, index) {
                            final reason = controller.resson[index];
                            return Obx(() {
                              return Row(
                                children: [
                                  Radio<int>(
                                    activeColor: StyleRepo.blue,
                                    value: reason.id,
                                    groupValue:
                                        controller.selectedReasonId.value,
                                    onChanged: (val) {
                                      controller.selectedReasonId.value = val;
                                      field.didChange(
                                        val,
                                      ); 
                                    },
                                  ),
                                  Expanded(
                                    child: Text(
                                      reason.reasonText,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            });
                          },
                        ),

                        
                        if (field.hasError)
                          Padding(
                            padding: const EdgeInsets.only(left: 12, top: 8),
                            child: Text(
                              field.errorText ?? "",
                              style: TextStyle(
                                color: StyleRepo.red,
                                fontSize: 13,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              );
            },
          ),

          SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Obx(() {
                  return controller.isLoading.value
                      ? const Center(
                        child: CircularProgressIndicator(color: StyleRepo.blue),
                      )
                      : ElevatedButton(
                        onPressed:() {
                                controller.appBuilder.isProviderMode.value ==
                                        true
                                    ? controller.CancelOrderProv(OrderId)
                                    : controller.CancelOrderCust(OrderId);
                                    Get.back();
                                    },
                        child:  Text(
                          tr(LocaleKeys.send),
                          style: TextStyle(color: StyleRepo.white),
                        ),
                      );
                }),
              ),
            ],
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
