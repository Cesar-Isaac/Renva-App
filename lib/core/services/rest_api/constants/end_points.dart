// ignore_for_file: constant_identifier_names, non_constant_identifier_names

abstract class EndPoints {
  //##########  Base Url  ##########
  static const String baseUrl = 'http://94.72.98.154/renva/public/api/';

  //Auth
  static const login = "v1/login";
  static const register = "v1/register";
  static const Verify = "v1/verify-otp";
  static const resent_otp = "v1/resend-otp";
  static const update = "v1/update";
  static const forget_password = "v1/forget_password";
  static const reset_password = "v1/reset_password";
  static const delete = "v1/delete/10";
  // Content
  static const profile = "v1/profile";
  static const categories = "v1/provider_categories";
  static const join_as_provider = "v1/join_as_provider";
  static const update_provider = "v1/provider/update";
  static sub_categories(int id) => "v1/sub_categories/$id";
  static const show_orders = "v1/orders_by_status";
  static const orders = "v1/orders";
  // static const order_state = "v1/provider_orders?status=waiting";
  static const provOrders = "v1/orders_by_status";
  static const add_offer = "v1/offers";
  // static const view_offer_provider = "v1/offers";
  static view_offer_provider(int id) => "v1/offers/$id";
  static const orderOffer = "v1/provider_orders";

  // static String orderCust(int flaggedOrder) =>
  //     "v1/customer/orders?flagged_order=$flaggedOrder";
  static const orderCust = "v1/customer/orders?flagged_order=1";
  static const orderCustProccing = "v1/customer/orders?flagged_order=2";

  static orderOffers(int id) => "v1/order/offers/$id";
  static ShowOffer(int id) => "v1/offers/$id";
  static const offersAccept = "v1/offers/accept";
  static const offersDelete = "v1/offers/decline";
  static delete_order_cust(int id) => "v1/orders/$id";
  static delete_order_prov(int id) => "v1/offers/$id";
  static const cancelOrderCust = "v1/orders/cancel";
  static const cancelOrderProv = "v1/orders/provider/cancel";
  static const ReviewOrderCustomer = "v1/orders/customer/review";
  static const EndOrder = "v1/orders/provider/end";
  static const CancelReason = "v1/order_cancel_reasons";
}
