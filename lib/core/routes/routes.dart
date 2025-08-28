// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/feature/MyOrder/customer/viewOfferCust/OfferDetails/index.dart';
import 'package:renvo_app/feature/MyOrder/customer/viewOfferCust/index.dart';
import 'package:renvo_app/feature/MyOrder/index.dart';
import 'package:renvo_app/feature/MyOrder/provider/index.dart';
import 'package:renvo_app/feature/add/add_order_details/index.dart';
import 'package:renvo_app/feature/add/add_order_details/widgets/steper/index.dart';
import 'package:renvo_app/feature/add_offer/index.dart';
import 'package:renvo_app/feature/add_offer/widgets/review_offer.dart';
import 'package:renvo_app/feature/order_details/index.dart';
import 'package:renvo_app/feature/join_as_provider/join_us_provider/index.dart';
import 'package:renvo_app/feature/provider_pages/provider_profile_page/index.dart';
import '../../feature/add/index.dart';
import '../../feature/auth/complete_info/index.dart';
import '../../feature/auth/forget_password/index.dart';
import '../../feature/auth/login/index.dart';
import '../../feature/auth/reset_password/index.dart';
import '../../feature/auth/signup/index.dart';
import '../../feature/auth/verifiy/index.dart';
import '../../feature/main/index.dart';
import '../../feature/splash_screen/index.dart';
import '../../feature/profile/edit_profile/index.dart';
import '../../feature/join_as_provider/join_us_provider/widgets/join_us_provider_form.dart';

class AppRouting {
  static GetPage unknownRoute = GetPage(
    name: "/unknown",
    page: () => SizedBox(),
  );

  static GetPage initialRoute = GetPage(name: "/", page: () => SplashScreen());

  static List<GetPage> routes = [
    initialRoute,
    ...Pages.values.map((e) => e.page),
  ];
}

enum Pages {
  //Auth
  login,
  signup,
  forget_password,
  reset_password,
  verifiy,
  complete_info,
  //
  home,
  my_order,
  edit_profile,
  edit_profile_prov,
  add_order,
  join_us_provider,
  join_us_provider_form,
  category_datails,
  add_order_step,
  order_details,
  add_offer,
  offerDetails,
  viewOfferCust,
  viewOfferProv,
  review_offer,
  ;
  // rating_page,

  String get value => '/$name';

  GetPage get page => switch (this) {
    login => GetPage(name: value, page: () => LoginPage()),
    signup => GetPage(name: value, page: () => SignUpPage()),
    verifiy => GetPage(name: value, page: () => VerifyPage()),
    complete_info => GetPage(name: value, page: () => CompleteInfoPage()),

    home => GetPage(name: value, page: () => MainPage()),
    my_order => GetPage(name: value, page: () => MyOrderPage()),

    edit_profile => GetPage(name: value, page: () => EditProfile()),
    add_order => GetPage(name: value, page: () => AddOrderPage()),
    forget_password => GetPage(name: value, page: () => ForgetPasswordPage()),
    reset_password => GetPage(name: value, page: () => ResetPasswordPage()),
    join_us_provider => GetPage(name: value, page: () => JoinUsProviderPage()),
    join_us_provider_form => GetPage(
      name: value,
      page: () => JoinUsProviderForm(),
    ),
    category_datails => GetPage(name: value, page: () => CategoryDetails()),
    add_order_step => GetPage(name: value, page: () => AddOrderStep()),
    order_details => GetPage(name: value, page: () => OrderDetails()),
    add_offer => GetPage(name: value, page: () => AddOffer()),
    offerDetails => GetPage(name: value, page: () => OfferDetailsPage()),
    viewOfferCust => GetPage(name: value, page: () => OrderOffersPage()),
    review_offer => GetPage(name: value, page: () => ReviewOffer()),
    viewOfferProv => GetPage(name: value, page: () => MyOffersPage()),
    // rating_page => GetPage(name: value, page: () => RatingPage()),
    edit_profile_prov => GetPage(name: value, page: () => UpdateProfileProv()),
    
  };
}
