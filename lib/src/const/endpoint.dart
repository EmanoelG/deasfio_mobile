const String _urlBase = 'https://parseapi.back4app.com/functions';

abstract class EndPoints {
  static const String signin = '$_urlBase/login';
  static const String signUpW = '$_urlBase/singup';
  static const String validateToken = '$_urlBase/validate-token';
  static const String resetPassword = '$_urlBase/reset-password';
  static const String getAllCategoria = '$_urlBase/get-category-list';
  static const String getAllProducts = 'https://forkify-api.herokuapp.com/api/search?q=pizza';
  static const String getCartItems = '$_urlBase/get-cart-items';
  static const String addItemToCart = '$_urlBase/add-item-to-cart';
  static const String changeItemQuantity = '$_urlBase/modify-item-quantity';
  static const String checkout = '$_urlBase/checkout';
  static const String getOrders = '$_urlBase/get-orders';
  static const String getOrdersItems = '$_urlBase/get-order-items';
  static const String changePassword = '$_urlBase/change-password';
}
