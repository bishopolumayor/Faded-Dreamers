import 'package:faded_dreamers/models/product_model.dart';
import 'package:faded_dreamers/screens/auth/contact_info_screen.dart';
import 'package:faded_dreamers/screens/auth/login_screen.dart';
import 'package:faded_dreamers/screens/auth/otp_verification_screen.dart';
import 'package:faded_dreamers/screens/auth/reset_link_sent_screen.dart';
import 'package:faded_dreamers/screens/auth/reset_password_screen.dart';
import 'package:faded_dreamers/screens/auth/sign_up_screen.dart';
import 'package:faded_dreamers/screens/home/faq_screen.dart';
import 'package:faded_dreamers/screens/home/home_screen.dart';
import 'package:faded_dreamers/screens/home/notifications_screen.dart';
import 'package:faded_dreamers/screens/product/favorite_products_screen.dart';
import 'package:faded_dreamers/screens/product/order_details_screen.dart';
import 'package:faded_dreamers/screens/product/payment_complete_screen.dart';
import 'package:faded_dreamers/screens/product/payment_webview.dart';
import 'package:faded_dreamers/screens/product/product_detail_screen.dart';
import 'package:faded_dreamers/screens/product/product_order_screen.dart';
import 'package:faded_dreamers/screens/product/search_products_screen.dart';
import 'package:faded_dreamers/screens/product/tutorials_screen.dart';
import 'package:faded_dreamers/screens/splash/error_screen.dart';
import 'package:faded_dreamers/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String splashScreen = '/splash-screen';
  static const String errorScreen = '/error-screen';
  static const String signInScreen = '/sign-in-screen';
  static const String signUpScreen = '/sign-up-screen';
  static const String otpVerificationScreen = '/otp-verification-screen';
  static const String contactInfoScreen = '/contact-info-screen';
  static const String homeScreen = '/home-screen';
  static const String productDetailScreen = '/product-detail-screen';
  static const String paymentScreen = '/payment-screen';
  static const String paymentCompleteScreen = '/payment-complete-screen';
  static const String favoriteProductsScreen = '/favorite-products-screen';
  static const String orderDetailsScreen = '/orders-details-screen';
  static const String searchProductsScreen = '/search-products-screen';
  static const String productOrderScreen = '/product-order-screen';
  static const String tutorialsScreen = '/tutorials-screen';
  static const String resetPasswordScreen = '/reset-password-screen';
  static const String resetEmailSentScreen = '/reset-email-sent-screen';
  static const String faqScreen = '/faq-screen';
  static const String notificationsScreen = '/notifications-screen';

  static String getSplashScreen() => '$splashScreen';

  static String getErrorScreen() => '$errorScreen';

  static String getSignInScreen() => '$signInScreen';

  static String getSignUpScreen() => '$signUpScreen';

  static String getOTPVerificationScreen() => '$otpVerificationScreen';

  static String getContactInfoScreen() => '$contactInfoScreen';

  static String getHomeScreen() => '$homeScreen';

  static String getProductDetailScreen() => '$productDetailScreen';

  static String getPaymentScreen() => '$paymentScreen';

  static String getPaymentCompleteScreen() => '$paymentCompleteScreen';

  static String getFavoriteProducts() => '$favoriteProductsScreen';

  static String getOrderDetails() => '$orderDetailsScreen';

  static String getSearchProductsScreen() => '$searchProductsScreen';

  static String getProductOrderScreen() => '$productOrderScreen';

  static String getTutorialScreen() => '$tutorialsScreen';

  static String getResetPasswordScreen() => '$resetPasswordScreen';

  static String getResetEmailSentScreen() => '$resetEmailSentScreen';

  static String getFAQScreen() => '$faqScreen';

  static String getNotificationsScreen() => '$notificationsScreen';

  static final routes = [
    GetPage(
      name: splashScreen,
      page: () {
        return const SplashScreen();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: errorScreen,
      page: () {
        return const ErrorScreen();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: signInScreen,
      page: () {
        return const LoginScreen();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: signUpScreen,
      page: () {
        return const SignUpScreen();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: otpVerificationScreen,
      page: () {
        return const OTPVerificationScreen();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: contactInfoScreen,
      page: () {
        return const ContactInfoScreen();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: homeScreen,
      page: () {
        return const HomeScreen();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: productDetailScreen,
      page: () {
        ProductModel product = Get.arguments as ProductModel;
        return ProductDetailScreen(
          product: product,
        );
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: paymentScreen,
      page: () {
        final String paymentLink = Get.arguments as String;
        return PaymentWebView(
          paymentLink: paymentLink,
        );
      },
      transition: Transition.fade,
    ),
    GetPage(
      name: paymentCompleteScreen,
      page: () {
        return const PaymentCompleteScreen();
      },
      transition: Transition.fade,
    ),
    GetPage(
      name: favoriteProductsScreen,
      page: () {
        return const FavoriteProductsScreen();
      },
      transition: Transition.fade,
    ),
    GetPage(
      name: orderDetailsScreen,
      page: () {
        final Map<String, dynamic> order =
            Get.arguments as Map<String, dynamic>;
        return OrderDetailsScreen(order: order);
      },
      transition: Transition.fade,
    ),
    GetPage(
      name: searchProductsScreen,
      page: () {
        return const SearchProductsScreen();
      },
      transition: Transition.fade,
    ),
    GetPage(
      name: productOrderScreen,
      page: () {
        ProductModel product = Get.arguments as ProductModel;
        return ProductOrderScreen(
          product: product,
        );
      },
      transition: Transition.fade,
    ),
    GetPage(
      name: tutorialsScreen,
      page: () {
        return const TutorialsScreen();
      },
      transition: Transition.fade,
    ),
    GetPage(
      name: resetPasswordScreen,
      page: () {
        return const ResetPasswordScreen();
      },
      transition: Transition.fade,
    ),
    GetPage(
      name: resetEmailSentScreen,
      page: () {
        return const ResetLinkSentScreen();
      },
      transition: Transition.fade,
    ),
    GetPage(
      name: faqScreen,
      page: () {
        return const FAQScreen();
      },
      transition: Transition.fade,
    ),
    GetPage(
      name: notificationsScreen,
      page: () {
        return const NotificationsScreen();
      },
      transition: Transition.fade,
    ),
  ];
}
