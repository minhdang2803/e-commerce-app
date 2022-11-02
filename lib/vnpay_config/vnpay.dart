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
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WebView(
        initialUrl: getPaymentUrl(widget.amount),
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith('vnpaysample://vnpaytesting.com')) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ReturnScreen('Successfully purchase')));
            print('blocking navigation to $request}');
            return NavigationDecision.prevent;
          }

          print('allowing navigation to $request');
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}
