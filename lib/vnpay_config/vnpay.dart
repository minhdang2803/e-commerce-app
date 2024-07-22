import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';
import 'payment_service.dart';
import 'return_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage(this.amount, {Key? key, required this.title})
      : super(key: key);
  final String title;
  final String amount;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    setupController();
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  void setupController() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onHttpError: (HttpResponseError error) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('vnpaysample://vnpaytesting.com')) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ReturnScreen('Successfully purchase')));
            print('blocking navigation to $request}');
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ))
      ..loadRequest(Uri.parse(getPaymentUrl(widget.amount)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
