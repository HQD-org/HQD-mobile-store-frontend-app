class ApiGateway {
  // Authentication
  static const String login = 'auth/login';
  static const String profile = "auth/get-auth";
  static const String changePassword = "auth/change-password";
  static const String forgotPassword = "auth/forgot-password";
  static const String sendNewPassword = "auth/forgot-password/verify";
  static const String updateProfile = "user/update";

  // Brand
  static const String getAllBrand = "mobile-brand/get-all";

  // Product
  static const String getAllProduct = "product/get-all";
  static const String filterProduct = "product/filter";

  // Cart
  static const String addToCart = "cart/add-to-cart";
  static const String updateCart = "cart/update-cart";
  static const String getDataCart = "cart/get-cart";
  static const String removeItem = "cart/delete-cart";

  //Order
  static const String crateOrderCOD = "order/create";
  static const String getDataOrder = "order/get-by-status-and-user";
  static const String cancelOrder = "order/cancel";
  static const String createOrderOnline = "payment/order";
  static const String paymentOrderSuccess = "payment/success";

  // coupon
  static const String getDataCoupon = "coupon/get-all";
  static const String getDataCouponByName = "coupon/find-by-name";
  static const String applyCoupon = "coupon/apply";

  // Branch
  static const String getDataBranch = "branch/get-all";
}
