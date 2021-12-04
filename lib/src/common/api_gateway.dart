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

  // Cart
  static const String addToCart = "cart/add-to-cart";
  static const String updateCart = "cart/update-cart";
  static const String getDataCart = "cart/get-cart";
  static const String removeItem = "cart/delete-cart";
}
