import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/constants/controllers_tags.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/core/services/pagination/options/list_view.dart';
import 'package:renvo_app/core/style/repo.dart';
import 'package:renvo_app/core/widgets/error_widget.dart';
import 'package:renvo_app/feature/MyOrder/Model/orderOfferCust.dart';
import 'package:renvo_app/feature/MyOrder/controller.dart';
import 'package:renvo_app/feature/MyOrder/widgets/CardOrder.dart';
import 'package:renvo_app/feature/MyOrder/widgets/SwipeableCard.dart';
import 'package:renvo_app/feature/MyOrder/widgets/order_status.dart';

class MyOrderPage extends StatelessWidget {
  const MyOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyOrderPageController(), tag: 'myOrderPage');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: StyleRepo.transparent,
        title: Text(
          tr(LocaleKeys.my_order),
          style: TextStyle(
            color: StyleRepo.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          TabBar(
            labelColor: StyleRepo.blue,
            indicatorColor: StyleRepo.blue,
            controller: controller.tabController,
            isScrollable: true,
            tabs:
                StatusOrder.values
                    .map((status) => Tab(text: status.trValue))
                    .toList(),
          ),
          SizedBox(height: 10),

          controller.appBuilder.isProviderMode.value == true
              ? Expanded(
                child: TabBarView(
                  controller: controller.tabController,
                  children: [
                    ListViewPagination.separated(
                      tag: ControllersTags.Order_pager_waiting_Prov,
                      fetchApi: controller.fetchDataWaiting,
                      physics: const AlwaysScrollableScrollPhysics(),
                      fromJson: OrderOfferCustModel.fromJson,
                      errorWidget:
                          (error) => AppErrorWidget(
                            error: error,
                            onRetry: controller.pagerControllerwaitingProv.refreshData,
                          ),
                      emptyWidget: Center(
                        child: Icon(
                          Icons.warning,
                          size: 80,
                          color: Colors.grey,
                        ),
                      ),

                      onControllerInit:
                          (pagerControllerProvWating) =>
                              controller.pagerControllerwaitingProv =
                                  pagerControllerProvWating,
                      separatorBuilder: (_, __) => SizedBox(height: 10),
                      itemBuilder: (context, index, customerOrders) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          child: SwipeableCard(
                            id:
                                controller.appBuilder.isProviderMode.value ==
                                        false
                                    ? customerOrders.id
                                    : customerOrders.prov_offer?.id ?? 0,
                            onDelete: () {

                            },
                            child: OrderCard(
                              cardtype: StatusOrder.waiting,
                              orderOffer: customerOrders,
                            ),
                          ),
                        );
                      },
                    ),
                    ListViewPagination.separated(
                      tag: ControllersTags.Order_pager_processing_Prov,
                      fetchApi: controller.fetchDataProcessing,
                      fromJson: OrderOfferCustModel.fromJson,
                      errorWidget:
                          (error) => AppErrorWidget(
                            error: error,
                            onRetry: controller.pagerControllerProccesingProv.refreshData,
                          ),
                      emptyWidget: Center(
                        child: Icon(
                          Icons.warning,
                          size: 80,
                          color: Colors.grey,
                        ),
                      ),

                      onControllerInit:
                          (pagerControllerProvProccesing) =>
                              controller.pagerControllerProccesingProv =
                                  pagerControllerProvProccesing,
                      separatorBuilder: (_, __) => SizedBox(height: 10),
                      itemBuilder: (context, index, orderProvProcessing) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          child: OrderCard(
                            cardtype: StatusOrder.processing,
                            orderOffer: orderProvProcessing,
                          ),
                        );
                      },
                    ),
                    ListViewPagination.separated(
                      tag: ControllersTags.Order_pager_completed_Prov,
                      fetchApi: controller.fetchDataCompleted,
                      fromJson: OrderOfferCustModel.fromJson,
                      errorWidget:
                          (error) => AppErrorWidget(
                            error: error,
                            onRetry: controller.pagerControllerCompletedProv.refreshData,
                          ),
                      emptyWidget: Center(
                        child: Icon(
                          Icons.warning,
                          size: 80,
                          color: Colors.grey,
                        ),
                      ),

                      onControllerInit:
                          (pagerControllerProvComplete) =>
                              controller.pagerControllerCompletedProv =
                                  pagerControllerProvComplete,
                      separatorBuilder: (_, __) => SizedBox(height: 10),
                      itemBuilder: (context, index, orderProvComp) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          child: OrderCard(
                            cardtype: StatusOrder.complete,
                            orderOffer: orderProvComp,
                          ),
                        );
                      },
                    ),
                    ListViewPagination.separated(
                      tag: ControllersTags.Order_pager_cancelled_Prov,
                      fetchApi: controller.fetchDataCancelled,
                      fromJson: OrderOfferCustModel.fromJson,
                      errorWidget:
                          (error) => AppErrorWidget(
                            error: error,
                            onRetry: controller.pagerControllerCanceldProv.refreshData,
                          ),
                      emptyWidget: Center(
                        child: Icon(
                          Icons.warning,
                          size: 80,
                          color: Colors.grey,
                        ),
                      ),

                      onControllerInit:
                          (pagerControllerProvCancele) =>
                              controller.pagerControllerCanceldProv =
                                  pagerControllerProvCancele,
                      separatorBuilder: (_, __) => SizedBox(height: 10),
                      itemBuilder: (context, index, orderProvCancel) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 8,
                          ),
                          child: OrderCard(
                            cardtype: StatusOrder.cancelled,
                            orderOffer: orderProvCancel,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
              : Expanded(
                child: TabBarView(
                  controller: controller.tabController,
                  children: [
                    ListViewPagination.separated(
                      tag: ControllersTags.Order_pager_waiting,
                      fetchApi: controller.fetchDataCustWaiting,

                      fromJson: OrderOfferCustModel.fromJson,
                      errorWidget:
                          (error) => AppErrorWidget(
                            error: error,
                            onRetry: controller.pagerControllerwaiting.refreshData,
                          ),
                      emptyWidget: Center(
                        child: Icon(
                          Icons.warning,
                          size: 80,
                          color: Colors.grey,
                        ),
                      ),

                      onControllerInit:
                          (pagerControllerCustWating) =>
                              controller.pagerControllerwaiting =
                                  pagerControllerCustWating,
                      separatorBuilder: (_, __) => SizedBox(height: 10),
                      itemBuilder: (context, index, orderProvWait) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          child: SwipeableCard(
                            id:
                                controller.appBuilder.isProviderMode.value ==
                                        false
                                    ? orderProvWait.id
                                    : (orderProvWait.provider?.id ?? 0),
                            onDelete: () {},
                            child: OrderCard(
                              cardtype: StatusOrder.waiting,
                              orderOffer: orderProvWait,
                            ),
                          ),
                        );
                      },
                    ),
                    ListViewPagination.separated(
                      tag: ControllersTags.Order_pager_processing,
                      fetchApi: controller.fetchDataCustProcessing,
                      fromJson: OrderOfferCustModel.fromJson,
                      errorWidget:
                          (error) => AppErrorWidget(
                            error: error,
                            onRetry: controller.pagerControllerProccesing.refreshData,
                          ),
                      emptyWidget: Center(
                        child: Icon(
                          Icons.warning,
                          size: 80,
                          color: Colors.grey,
                        ),
                      ),

                      onControllerInit:
                          (pagerControllerCustProccesing) =>
                              controller.pagerControllerProccesing =
                                  pagerControllerCustProccesing,
                      separatorBuilder: (_, __) => SizedBox(height: 10),
                      itemBuilder: (context, index, orderProvProcessing) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          child: OrderCard(
                            cardtype: StatusOrder.processing,
                            orderOffer: orderProvProcessing,
                          ),
                        );
                      },
                    ),
                    ListViewPagination.separated(
                      tag: ControllersTags.Order_pager_completed,
                      fetchApi: controller.fetchDataCustCompleted,
                      fromJson: OrderOfferCustModel.fromJson,
                      errorWidget:
                          (error) => AppErrorWidget(
                            error: error,
                            onRetry: controller.pagerControllerCompleted.refreshData,
                          ),
                      emptyWidget: Center(
                        child: Icon(
                          Icons.warning,
                          size: 80,
                          color: Colors.grey,
                        ),
                      ),

                      onControllerInit:
                          (pagerControllerCustComplete) =>
                              controller.pagerControllerCompleted =
                                  pagerControllerCustComplete,
                      separatorBuilder: (_, __) => SizedBox(height: 10),
                      itemBuilder: (context, index, orderProvComp) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          child: OrderCard(
                            cardtype: StatusOrder.complete,
                            orderOffer: orderProvComp,
                          ),
                        );
                      },
                    ),
                    ListViewPagination.separated(
                      tag: ControllersTags.Order_pager_cancelled,
                      fetchApi: controller.fetchDataCustCancelled,
                      fromJson: OrderOfferCustModel.fromJson,
                      errorWidget:
                          (error) => AppErrorWidget(
                            error: error,
                            onRetry: controller.pagerControllerCanceld.refreshData,
                          ),
                      emptyWidget: Center(
                        child: Icon(
                          Icons.warning,
                          size: 80,
                          color: Colors.grey,
                        ),
                      ),

                      onControllerInit:
                          (pagerControllerCustCancele) =>
                              controller.pagerControllerCanceld =
                                  pagerControllerCustCancele,
                      separatorBuilder: (_, __) => SizedBox(height: 10),
                      itemBuilder: (context, index, orderProvCancel) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 8,
                          ),
                          child: OrderCard(
                            cardtype: StatusOrder.cancelled,
                            orderOffer: orderProvCancel,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

          SizedBox(height: 80),
        ],
      ),
    );
  }
}
