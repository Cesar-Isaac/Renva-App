import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/constants/controllers_tags.dart';
import 'package:renvo_app/core/routes/routes.dart';
import 'package:renvo_app/core/services/pagination/options/list_view.dart';
import 'package:renvo_app/core/style/repo.dart';
import 'package:renvo_app/core/widgets/error_widget.dart';
import 'package:renvo_app/core/widgets/svg_icon.dart';
import 'package:renvo_app/feature/provider_pages/provider_home_page/controller.dart';
import 'package:renvo_app/feature/provider_pages/provider_home_page/models/all_order_list.dart';
import 'package:renvo_app/gen/assets.gen.dart';

class OrderCards extends StatelessWidget {
  const OrderCards({super.key, required this.controller});

  final ProviderHomePageController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListViewPagination.separated(
        padding: const EdgeInsets.only(bottom: 80, left: 16, right: 16),
        physics: const AlwaysScrollableScrollPhysics(),
        errorWidget:
            (error) =>
                AppErrorWidget(error: error, onRetry: controller.refreshData),
        // Text(error),
        onControllerInit:
            (pagerController) => controller.pagerController = pagerController,
        itemBuilder: (context, index, getAllOrders) {
          final order = getAllOrders;
          return InkWell(
            onTap:
                () => Get.toNamed(Pages.order_details.value, arguments: order),
            child: Container(
              width: 387,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(21),
                border: Border.all(color: StyleRepo.softGrey),
                color: StyleRepo.white,
              ),
              child: Row(
                children: [
                  Container(
                    height: 160,
                    width: 19,
                    decoration: BoxDecoration(
                      color: StyleRepo.blue,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(23),
                        bottomLeft: Radius.circular(21),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgIcon(
                                icon: Assets.icons.user,
                                color: StyleRepo.grey,
                                size: 25,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "${order.customer.firstName} ${order.customer.lastName}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              SvgIcon(
                                icon: Assets.icons.location,
                                color: StyleRepo.grey,
                                size: 25,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                order.address.title.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: StyleRepo.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              SvgIcon(
                                icon: Assets.icons.calendar,
                                color: StyleRepo.grey,
                                size: 25,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                order.date != null && order.date!.isNotEmpty
                                    ? DateFormat(
                                      'yyyy-MM-dd',
                                      'en_US',
                                    ).format(DateTime.parse(order.date!))
                                    : '—',
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              SvgIcon(
                                icon: Assets.icons.timer,
                                color: StyleRepo.grey,
                                size: 25,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                order.startAt != null
                                    ? controller.formatTime(order.startAt!)
                                    : '—',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => SizedBox(height: 10),
        tag: ControllersTags.order_pager,
        fetchApi: controller.fetchData,
        fromJson: AllOrderList.fromJson,
      ),
    );
  }
}
