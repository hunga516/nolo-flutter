import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebEngine {
  late final WebViewController controller;

  WebEngine() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://vi-frontend-orcin.vercel.app'));
  }

  Widget build(BuildContext context) {
    return WebViewWidget(controller: controller);
  }
}