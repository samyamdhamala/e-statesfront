import 'package:flutter/material.dart';
import 'package:login/models/property_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewTest extends StatefulWidget {
  final PropertyModel propertyModel;
  const WebViewTest({Key? key, required this.propertyModel}) : super(key: key);

  @override
  State<WebViewTest> createState() => _WebViewTestState();
}

class _WebViewTestState extends State<WebViewTest> {
  WebViewController? controller;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Maps'),
        ),
        body: WebView(
          initialUrl:
              'https://www.google.com/maps/search/?api=1&query=${widget.propertyModel.latitude},${widget.propertyModel.longitude}',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) {
            this.controller = controller;
          },
        ),
      ),
    );
  }
}
