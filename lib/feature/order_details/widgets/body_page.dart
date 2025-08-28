
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/core/routes/routes.dart';
import 'package:renvo_app/core/style/repo.dart';
import 'package:renvo_app/core/widgets/image.dart';
import 'package:renvo_app/core/widgets/svg_icon.dart';
import 'package:renvo_app/feature/provider_pages/provider_home_page/models/all_order_list.dart';
import 'package:renvo_app/gen/assets.gen.dart';

class BodyOrderDetails extends StatelessWidget {
  final AllOrderList order;
  const BodyOrderDetails({super.key, required this.order});
  @override
  Widget build(BuildContext context) {
    return 
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppImage(
            path: order.customer.avatar.originalUrl,
            type: ImageType.CachedNetwork,
          ),
          const SizedBox(width: 12),
          
          Expanded(
            child: Wrap(
              spacing: 10,
              children: [
                Text(
                  order.customer.firstName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
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
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            tr(LocaleKeys.picture),
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
                order.gallery.isNotEmpty
              ? Container(
                  padding: EdgeInsets.all(5),
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: order.gallery.map((item) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 13),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: AppImage(
                              path: item.toString(),
                              type: ImageType.CachedNetwork,
                              fit: BoxFit.cover,
                              width: 80,
                              height: 80,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                )
              : SizedBox(),
          SizedBox(height: 20),
        
        Text(tr(LocaleKeys.no_photos_uploaded)),
    
        ],
      ),
          
      const SizedBox(height: 16),
          
       Text(
        tr(LocaleKeys.description),
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
      ),
      const SizedBox(height: 4),
      Text(
        order.description,
        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
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
                ? DateFormat(
                  'hh:mm a',
                ).format(DateFormat('HH:mm:ss').parse(order.startAt!))
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
      const SizedBox(height: 12),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _addressItem(
            title: 'City',
            value: order.address.title ?? '—',
          ),
        ],
      ),
      const SizedBox(height: 12),
          
      const SizedBox(height: 24),
          
      Center(
        child: ElevatedButton(
          onPressed: () => Get.toNamed(Pages.add_offer.value),
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
              )
      ;
  }
    Widget _imageItem(String path) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(path, height: 60, width: 60, fit: BoxFit.cover),
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

