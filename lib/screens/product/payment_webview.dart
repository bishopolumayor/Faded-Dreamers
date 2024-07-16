import 'package:faded_dreamers/routes/routes.dart';
import 'package:faded_dreamers/utils/colors.dart';
import 'package:faded_dreamers/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentWebView extends StatelessWidget {
  final String paymentLink;
  final GlobalKey webViewKey = GlobalKey();

  PaymentWebView({
    super.key,
    required this.paymentLink,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var webView = webViewKey.currentState as InAppWebViewController?;
        if (webView != null) {
          if (await webView.canGoBack()) {
            webView.goBack();
            return false;
          }
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.close,
            ),
          ),
          title: Text(
            'CHECKOUT',
            style: TextStyle(
              color: AppColors.whiteColor,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: Dimensions.font18,
            ),
          ),
        ),
        body: SafeArea(
          child: InAppWebView(
            initialUrlRequest: URLRequest(
              url: WebUri(paymentLink),
            ),
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                useShouldOverrideUrlLoading: true,
                javaScriptEnabled: true,
                javaScriptCanOpenWindowsAutomatically: true,
                supportZoom: false,
              ),
              android: AndroidInAppWebViewOptions(
                useHybridComposition: true,
              ),
            ),
            onWebViewCreated: (controller) {},
            onLoadResource: (controller, resource) {},
            onLoadStop: (controller, url) async {
              if (url != null) {
                String urlString = url.toString();
                if (urlString.contains('https://fadeddreamers.com/custom/v1/square-webhook?')) {
                  Get.offNamed(AppRoutes.getPaymentCompleteScreen());
                } else if (urlString.contains('payment-cancelled')) {
                  // Get.offNamed(AppRoutes.getPaymentCancelledScreen());
                } else if (urlString.contains('payment-pending')) {
                  // Get.offNamed(AppRoutes.getPaymentPendingScreen());
                }
              }
            },
            shouldOverrideUrlLoading: (controller, navigationAction) async {
              var uri = navigationAction.request.url!;
              if (uri.scheme != "http" && uri.scheme != "https") {
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                  return NavigationActionPolicy.CANCEL;
                }
              }
              return NavigationActionPolicy.ALLOW;
            },
          ),
        ),
      ),
    );
  }
}
