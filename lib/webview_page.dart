import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatefulWidget {
  const WebviewPage({Key? key}) : super(key: key);

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  late WebViewController _controller;
  bool isDone = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await _controller.canGoBack()) {
          _controller.goBack();
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              !isDone ? const CircularProgressIndicator() : Container(),
              Expanded(
                child: WebView(
                  onPageFinished: (done) {
                    setState(() {
                      isDone = true;
                    });
                  },
                  onProgress: (progress) {},
                  onWebViewCreated: (controller) {
                    _controller = controller;
                  },
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: 'https://sandbox.vorkinsta.com/',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
