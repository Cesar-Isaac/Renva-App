import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:renvo_app/core/localization/strings.dart';

// class AppErrorWidget extends StatelessWidget {
//   final String error;
//   final bool withScrolling;
//
//   const AppErrorWidget({
//     super.key,
//     required this.error,
//     this.withScrolling = true,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     Widget errorWidget = Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12.0),
//             child: Text(
//               error,
//               maxLines: 3,
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ],
//       ),
//     );
//
//     if (withScrolling) {
//       errorWidget = Stack(
//         children: [
//           errorWidget,
//           SingleChildScrollView(
//             physics: const AlwaysScrollableScrollPhysics(),
//             child: SizedBox.expand(),
//           ),
//         ],
//       );
//     }
//
//     return errorWidget;
//   }
// }

// class AppErrorWidget extends StatelessWidget {
//   final String error;
//   final VoidCallback? onRetry;

//   const AppErrorWidget({
//     super.key,
//     required this.error,
//     this.onRetry,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: SingleChildScrollView(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Icon(Icons.error_outline, color: Colors.red, size: 60),
//             const SizedBox(height: 16),
//             Text(
//               error,
//               textAlign: TextAlign.center,
//               style: const TextStyle(fontSize: 16, color: Colors.black),
//             ),
//             const SizedBox(height: 32),
//             if (onRetry != null)
//               InkWell(
//                 onTap: onRetry,
//                 borderRadius: BorderRadius.circular(12),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Icon(Icons.refresh, size: 32, color: Colors.red),
//                     const SizedBox(height: 8),
//                     Text(
//                       tr(LocaleKeys.retry), // تأكد من أن المفتاح موجود
//                       style: const TextStyle(
//                         fontSize: 14,
//                         color: Colors.red,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             else
//               const Text(""),
//           ],
//         ),
//       ),
//     );
//   }
// }

class AppErrorWidget extends StatelessWidget {
  final String error;
  final VoidCallback? onRetry;

  const AppErrorWidget({super.key, required this.error, this.onRetry});

  @override
  Widget build(BuildContext context) {
    Widget content = SingleChildScrollView(
      physics:
          AlwaysScrollableScrollPhysics(), // ضروري للسحب حتى لو المحتوى صغير
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // const Icon(Icons.error_outline, color: Colors.red, size: 60),
          const SizedBox(height: 16),
          Text(
            error,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          const SizedBox(height: 5),
          if (onRetry != null)
            InkWell(
              onTap: onRetry,
              borderRadius: BorderRadius.circular(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.refresh, size: 32, color: Colors.red),
                  const SizedBox(height: 8),
                  Text(
                    tr(LocaleKeys.retry),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            )
          else
            const SizedBox.shrink(),
        ],
      ),
    );

    if (onRetry == null) {
      // إذا لم يكن هناك زر إعادة المحاولة، نلف المحتوى بـ RefreshIndicator
      return RefreshIndicator(
        onRefresh: () async {
          // نفترض أن إعادة المحاولة هنا يمكن تنفيذها عبر استدعاء دالة ما
          // يمكنك تعديل هذه الدالة لتناسب حالتك
          // إذا كنت تريد تمرير دالة إعادة المحاولة من الخارج، يمكنك تعديل التابع
          // هنا نرجع Future.delayed فقط كمثال:
          await Future.delayed(const Duration(milliseconds: 500));
          // يمكنك هنا استدعاء دالة لإعادة تحميل البيانات إذا متوفرة
        },
        child: content,
      );
    } else {
      // إذا زر إعادة المحاولة موجود فقط نظهر المحتوى كما هو
      return Center(child: content);
    }
  }
}




// class AppErrorWidget extends StatelessWidget {
//   final String error;
//   final VoidCallback? onRetry;
//   final IconData icon;
//   final String? retryLabel;

//   const AppErrorWidget({
//     super.key,
//     required this.error,
//     this.onRetry,
//     this.icon = Icons.error_outline,
//     this.retryLabel,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final Widget content = SingleChildScrollView(
//       physics: const AlwaysScrollableScrollPhysics(),
//       padding: const EdgeInsets.all(24.0),
//       child: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(icon, color: Colors.red, size: 60),
//             const SizedBox(height: 16),
//             Text(
//               error,
//               textAlign: TextAlign.center,
//               style: const TextStyle(fontSize: 16, color: Colors.black),
//             ),
//             const SizedBox(height: 32),
//             if (onRetry != null)
//               ElevatedButton.icon(
//                 onPressed: onRetry,
//                 icon: const Icon(Icons.refresh, size: 20),
//                 label: Text(
//                   retryLabel ?? tr(LocaleKeys.retry),
//                   style: const TextStyle(fontWeight: FontWeight.w600),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.red,
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );

//     return onRetry == null
//         ? RefreshIndicator(
//             onRefresh: () async {
//               await Future.delayed(const Duration(milliseconds: 500));
//             },
//             child: content,
//           )
//         : Center(child: content);
//   }
// }

