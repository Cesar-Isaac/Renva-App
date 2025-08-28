import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:renvo_app/core/config/role.dart';

import 'core/config/app_builder.dart';
import 'core/localization/localization.dart';
import 'core/routes/routes.dart';
import 'core/services/rest_api/api_service.dart';
import 'core/style/style.dart';

Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Get.put(AppBuilder());
  // appBuilder.loadData();
  // Get.put(APIService(token: appBuilder.token));

  runApp(
    EasyLocalization(
      supportedLocales: AppLocalization.values.map((e) => e.locale).toList(),
      path: "assets/translations",
      // assetLoader: const CodegenLoader(),
      fallbackLocale: AppLocalization.en.locale,
      startLocale: AppLocalization.en.locale,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(AppBuilder());

    Get.put(APIService());

    // Get.put(APIService());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppStyle.theme,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      //
      initialRoute: '/',
      unknownRoute: AppRouting.unknownRoute,
      getPages: AppRouting.routes,
    );
  }
}
