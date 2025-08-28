import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/config/app_builder.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/core/routes/routes.dart';
import 'package:renvo_app/core/style/repo.dart';
import 'package:renvo_app/core/widgets/image.dart';
import 'package:renvo_app/core/widgets/svg_icon.dart';
import 'package:renvo_app/feature/MyOrder/Model/orderOfferCust.dart';
import 'package:renvo_app/feature/MyOrder/Model/orderOfferrProv.dart';
import 'package:renvo_app/feature/MyOrder/Rating/index.dart';
import 'package:renvo_app/feature/MyOrder/Rating/widgets/rating_stars.dart';
import 'package:renvo_app/feature/MyOrder/controller.dart';
import 'package:renvo_app/feature/MyOrder/widgets/PopUp.dart';
import 'package:renvo_app/feature/MyOrder/widgets/order_status.dart';
import 'package:renvo_app/gen/assets.gen.dart';

class OrderCard extends StatelessWidget {
  final StatusOrder cardtype;
  final OrderOfferCustModel orderOffer;
  OrderOfferProvModel? orderOfferProv;
  OrderCard({
    super.key,
    required this.cardtype,
    required this.orderOffer,
    this.orderOfferProv,
  });

  @override
  Widget build(BuildContext context) {

    final Controller = Get.find<MyOrderPageController>(tag: 'myOrderPage');
    final appBuilder = Get.find<AppBuilder>();
    return Obx(
      () => Card(
        color: StyleRepo.softGrey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Column(
          children: [
            SizedBox(
              height: 37,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${tr(LocaleKeys.id)} ${orderOffer.id}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    orderOffer.date != null
                        ? DateFormat('yyyy-MM-dd').format(orderOffer.date!)
                        : "No date",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  Text(
                    orderOffer.startAt ?? "No date",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  if (cardtype == StatusOrder.complete ||
                      cardtype == StatusOrder.cancelled)
                    Row(
                      children: [
                        
                        SizedBox(width: 2),
                        Popup(icon: Assets.icons.view.svg()),
                      ],
                    )
                  else if (((cardtype == StatusOrder.processing) &&
                          appBuilder.isProviderMode.value == false) ||
                      (cardtype == StatusOrder.processing &&
                          appBuilder.isProviderMode.value == true))
                    Popup(
                      icon: Assets.icons.a3pointMenu.svg(),
                      id: orderOffer.id,
                    ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 6, left: 6, bottom: 6),
              decoration: BoxDecoration(
                color: StyleRepo.white,
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      
                      Container(
                        width: 35,
                        height: 35,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: StyleRepo.blue,
                          shape: BoxShape.circle,
                        ),
                        child: SvgIcon(
                          icon: Assets.icons.myOrder,
                          color: StyleRepo.white,
                        ),
                      ),
                      SizedBox(width: 15),
                      Column(
                        children: [
                          Text(
                            Controller.appBuilder.isProviderMode.value == true
                                ? orderOffer.customer.firstName +
                                    " " +
                                    orderOffer.customer.lastName
                                : orderOffer.mainCategory.title,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            orderOffer.category.title,
                            style: Theme.of(context).textTheme.labelSmall!
                                .copyWith(color: StyleRepo.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(width: 12),
                  Text(
                    orderOffer.description ?? '',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const Divider(),
                  Row(
                    children: [
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_pin,
                                  color: StyleRepo.deepGrey,
                                ),
                                Expanded(
                                  child: Text(
                                    orderOffer.address?.title ?? "Damascus",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(color: StyleRepo.deepGrey),
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                            if (cardtype == StatusOrder.waiting)
                              IconButton(
                                onPressed: () {
                                  if (Controller
                                          .appBuilder
                                          .isProviderMode
                                          .value ==
                                      false) {
                                    Get.toNamed(
                                      Pages.viewOfferCust.value,
                                      arguments: orderOffer.id,
                                    );
                                  } else {
                                    Get.toNamed(
                                      Pages.viewOfferProv.value,
                                      arguments: {
                                        'orderId': orderOffer.id,
                                        'offer': orderOffer.prov_offer,
                                        'isDelete': false,
                                      },
                                    );
                                  }
                                },
                                icon: Text(
                                  Controller.appBuilder.isProviderMode.value ==
                                          true
                                      ? tr(LocaleKeys.view_my_offer)
                                      : tr(LocaleKeys.view),
                                  style: Theme.of(context).textTheme.labelSmall!
                                      .copyWith(color: StyleRepo.blue),
                                ),
                              )
                            else if (cardtype == StatusOrder.processing)
                              Controller.appBuilder.isProviderMode.value ==
                                      false
                                  ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        orderOffer.provider?.name ?? "",
                                        style: Theme.of(
                                          context,
                                        ).textTheme.labelSmall!.copyWith(
                                          color: StyleRepo.deepGrey,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      IconButton(
                                        onPressed: () {
                                          if (Controller
                                                  .appBuilder
                                                  .isProviderMode
                                                  .value ==
                                              false) {
                                            Get.toNamed(
                                              Pages.viewOfferCust.value,
                                              arguments: orderOffer.id,
                                            );
                                          } else {
                                            Get.toNamed(
                                              Pages.viewOfferProv.value,
                                              arguments: {
                                                'orderId': orderOffer.id,
                                                'offer': orderOffer.prov_offer,
                                                'isDelete': false,
                                              },
                                            );
                                          }
                                        },
                                        icon: Text(
                                          Controller
                                                      .appBuilder
                                                      .isProviderMode
                                                      .value ==
                                                  true
                                              ? tr(LocaleKeys.view_my_offer)
                                              : tr(LocaleKeys.view_offer),
                                          style: Theme.of(
                                            context,
                                          ).textTheme.labelMedium!.copyWith(
                                            color: StyleRepo.blue,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                  : Row(
                                    children: [
                                      Obx(() {
                                        bool isLoadingThisOrder =
                                            Controller.loadingOrderId.value ==
                                            orderOffer.id;

                                        return Expanded(
                                          child:
                                              isLoadingThisOrder
                                                  ? const Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                          color: StyleRepo.blue,
                                                        ),
                                                  )
                                                  : ElevatedButton(
                                                    onPressed:
                                                        () =>
                                                            Controller.EndOrder(
                                                              orderOffer.id,
                                                            ),
                                                    child: Text(
                                                      tr(LocaleKeys.complete),
                                                      style: TextStyle(
                                                        color: StyleRepo.white,
                                                      ),
                                                    ),
                                                  ),
                                        );
                                      }),
                                    ],
                                  )
                            else if (cardtype == StatusOrder.complete)
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        tr(LocaleKeys.rating_review),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(color: StyleRepo.black),
                                      ),
                                      SizedBox(width: 60),
                                      orderOffer
                                                  .provider
                                                  ?.avatar
                                                  .originalUrl
                                                  .isNotEmpty ==
                                              true
                                          ? AppImage(
                                            path:
                                                orderOffer
                                                    .provider!
                                                    .avatar
                                                    .originalUrl,
                                            type: ImageType.CachedNetwork,
                                            height: 24,
                                            width: 24,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                          )
                                          : AppImage(
                                            path: Assets.icons.user.path,
                                            type: ImageType.Asset,
                                            height: 24,
                                            width: 24,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                      SizedBox(width: 5),

                                      Expanded(
                                        child: Text(
                                          orderOffer.provider?.name ?? "",
                                          maxLines: 1,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.labelSmall!.copyWith(
                                            color: StyleRepo.deepGrey,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 17),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Controller
                                                  .appBuilder
                                                  .isProviderMode
                                                  .value ==
                                              false
                                          ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  if (orderOffer.provider !=
                                                      null) {
                                                    Get.bottomSheet(
                                                      RatingBottomSheet(
                                                        provider:
                                                            orderOffer
                                                                .provider!,
                                                        OrderId: orderOffer.id,
                                                      ),
                                                      isScrollControlled: true,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.vertical(
                                                              top:
                                                                  Radius.circular(
                                                                    20,
                                                                  ),
                                                            ),
                                                      ),
                                                      backgroundColor:
                                                          Colors.white,
                                                    );
                                                  } else {
                                                    Get.snackbar(
                                                      tr(LocaleKeys.error),
                                                      tr(LocaleKeys.provider_information_is_missing),
                                                    );
                                                  }
                                                },

                                                child: Text(
                                                  tr(LocaleKeys.top_to_rating),
                                                  maxLines: 1,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelLarge!
                                                      .copyWith(
                                                        color: StyleRepo.green,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                      ),
                                                ),
                                              ),
                                              SizedBox(width: 50),

                                              orderOffer.rate == null ||
                                                      orderOffer.rate == 0
                                                  ? Text(
                                                    "Not Rating Found",
                                                    style: TextStyle(
                                                      color: StyleRepo.grey,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  )
                                                  : RatingStars(
                                                    rating:
                                                        orderOffer.rate!
                                                            .toDouble(),
                                                  ),
                                            ],
                                          )
                                          : Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                SizedBox(width: 40),
                                                orderOffer.rate == null ||
                                                        orderOffer.rate == 0
                                                    ? Text(
                                                      tr(LocaleKeys.no_rating_found),
                                                      style: TextStyle(
                                                        color: StyleRepo.grey,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    )
                                                    : RatingStars(
                                                      rating:
                                                          orderOffer.rate!
                                                              .toDouble(),
                                                    ),
                                              ],
                                            ),
                                          ),
                                    ],
                                  ),
                                ],
                              )
                            else if (cardtype == StatusOrder.cancelled)
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        tr(LocaleKeys.Cancelesd_by),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .copyWith(color: StyleRepo.red),
                                      ),
                                      SizedBox(width: 40),
                                      orderOffer
                                                  .provider
                                                  ?.avatar
                                                  .originalUrl
                                                  .isNotEmpty ==
                                              true
                                          ? AppImage(
                                            path:
                                                orderOffer
                                                    .provider!
                                                    .avatar
                                                    .originalUrl,
                                            type: ImageType.CachedNetwork,
                                            height: 24,
                                            width: 24,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                          )
                                          : AppImage(
                                            path: Assets.icons.user.path,
                                            type: ImageType.Asset,
                                            height: 24,
                                            width: 24,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                      SizedBox(width: 5),
                                      Expanded(
                                        child: Text(
                                          orderOffer.provider?.name ?? "",
                                          maxLines: 1,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.labelSmall!.copyWith(
                                            color: StyleRepo.deepGrey,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 17),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        
                                        orderOffer.cancelReason?.reasonText ??
                                            "",
                                        maxLines: 1,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.labelSmall!.copyWith(
                                          color: StyleRepo.deepGrey,
                                        ),
                                      ),
                                      SizedBox(width: 30),
                                      Expanded(
                                        child: Text(
                                          orderOffer.date != null
                                              ? DateFormat(
                                                'yyyy-MM-dd',
                                              ).format(orderOffer.date!)
                                              : "no date",
                                          maxLines: 1,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .copyWith(color: StyleRepo.red),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
