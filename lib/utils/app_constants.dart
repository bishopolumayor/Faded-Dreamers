class AppConstants {

  // basic
  static const String APP_NAME = "Faded Dreamers";

  static const String BASE_URL = "https://fadeddreamers.com";

  // auth
  static const String TOKEN = "token";

  static const String REMEMBER_KEY = 'remember-me';
  static const String USER_KEY = "user-key";
  static const String CART_KEY = "cart-key";
  static const String CONSENT_KEY = "consent-key";

  static const String CONSUMER_KEY = 'ck_75311474556968a915141b995f1e8f0b55f1fd20';
  static const String CONSUMER_SECRET = 'cs_add5b971b07a9b7ab0111358e63c9d3d9dd3a790';

  //URI
  // auth
  static const String SIGN_UP_URI = '/wp-json/custom/v1/register';
  static const String SIGN_IN_URI = '/wp-json/custom/v1/login';
  static const String UPDATE_USER_DETAILS = '/wp-json/custom/v1/user-details';
  static const String UPLOAD_AVATAR = '/wp-json/custom/v1/set-avatar';
  static const String RESET_PASSWORD = '/wp-json/custom/v1/reset-password';


  static const String CREATE_ORDER_URI = '/wp-json/custom/v1/create-order';
  static const String ORDER_URI = '/wp-json/custom/v1/orders';


  // products
  static const String PRODUCTS_URI = '/wp-json/wc/v3/products';
  static const String WCORDER_URI = '/wp-json/wc/v3/orders';
  static const String PAYMENT_GATEWAYS = '/wp-json/wc/v3/payment_gateways';

  static const String FAVORITE_PRODUCTS_URI= '/wp-json/custom/v1/favorites';
  static const String TOGGLE_FAVORITE_URI= '/wp-json/custom/v1/favorites/toggle';

}