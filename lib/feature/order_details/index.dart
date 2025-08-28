import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/core/routes/routes.dart';
import 'package:renvo_app/core/style/repo.dart';
import 'package:renvo_app/core/widgets/image.dart';
import 'package:renvo_app/core/widgets/svg_icon.dart';
import 'package:renvo_app/feature/order_details/controller.dart';
import 'package:renvo_app/feature/provider_pages/provider_home_page/models/all_order_list.dart';
import 'package:renvo_app/gen/assets.gen.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final orderArg = Get.arguments;
    if (orderArg == null || orderArg is! AllOrderList) {
      return Scaffold(
        appBar: AppBar(title:  Text(tr(LocaleKeys.order_details))),
        body:  Center(child: Text(tr(LocaleKeys.no_order_data_found))),
      );
    }

    final AllOrderList order = orderArg;
    Get.put(OrderDetailsController());

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
          tr(LocaleKeys.order_details),
          style: TextStyle(color: StyleRepo.black, fontSize: 20),
        ),
        titleSpacing: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    child: AppImage(
                      path: order.customer.avatar.originalUrl,
                      type: ImageType.CachedNetwork,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          order.customer.firstName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          order.customer.lastName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          order.id.toString(),
                          style: TextStyle(
                            color: StyleRepo.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          tr(LocaleKeys.order),
                          style: TextStyle(
                            color: StyleRepo.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

               Text(
                tr(LocaleKeys.picture),
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
              ),
              const SizedBox(height: 8),
              order.gallery.isNotEmpty
                  ? Container(
                    padding: const EdgeInsets.all(5),
                    width: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            order.gallery.asMap().entries.map((entry) {
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
                                              itemCount: order.gallery.length,
                                              pageController: PageController(
                                                initialPage: index,
                                              ),
                                              builder: (context, i) {
                                                return PhotoViewGalleryPageOptions(
                                                  imageProvider: NetworkImage(
                                                    order
                                                        .gallery[i]
                                                        .originalUrl,
                                                  ),
                                                  heroAttributes:
                                                      PhotoViewHeroAttributes(
                                                        tag:
                                                            order
                                                                .gallery[i]
                                                                .uuid ??
                                                            '$i',
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
                            }).toList(),
                      ),
                    ),
                  )
                  :  Text(tr(LocaleKeys.no_photos_uploaded)),

              const SizedBox(height: 20),

               Text(
                tr(LocaleKeys.description),
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                order.description,
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),

               Text(
                tr(LocaleKeys.date_time),
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  SvgIcon(
                    icon: Assets.icons.calendar,
                    size: 18,
                    color: StyleRepo.grey,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    order.date != null && order.date!.isNotEmpty
                        ? DateFormat(
                          'yyyy-MM-dd',
                          'en_US',
                        ).format(DateTime.parse(order.date!))
                        : '—',
                    style: const TextStyle(
                      color: StyleRepo.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  SvgIcon(
                    icon: Assets.icons.timer,
                    color: StyleRepo.grey,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    order.startAt != null && order.startAt!.isNotEmpty
                        ? DateFormat('hh:mm a', 'en_US').format(
                          DateFormat('HH:mm:ss', 'en_US').parse(order.startAt!),
                        )
                        : '—',
                    style: const TextStyle(
                      color: StyleRepo.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),

                ],
              ),

              const SizedBox(height: 16),
               Text(
                tr(LocaleKeys.address),
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _addressItem(
                    title: 'City',
                    value: order.address.title.toString(),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              Center(
                child: ElevatedButton(
                  onPressed:
                      () => Get.toNamed(
                        Pages.add_offer.value,
                        arguments: order.id,
                      ),
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
                    tr(LocaleKeys.add_offer),
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

  Widget _addressItem({required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
