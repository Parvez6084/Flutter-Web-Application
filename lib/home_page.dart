import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late WebViewController _controller;
  final Completer<WebViewController> _webController = Completer<WebViewController>();

  int _stackToView = 1;
  double progress = 0;

  void _handleLoad(String value) {
    setState(() {
      _stackToView = 0;
    });
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    if (Platform.isIOS) WebView.platform = CupertinoWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _goBack(context),
      child: Scaffold(
          body: SafeArea(
        child: IndexedStack(
          index: _stackToView,
          children: [
            Column(
              children: [
                LinearProgressIndicator(
                  value: progress,
                  color: Colors.orange,
                  backgroundColor: Colors.transparent,
                ),
                Expanded(
                    child: WebView(
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: "https://bivinnorokom.com.bd/",
                  onPageFinished: _handleLoad,
                  onWebViewCreated: (webViewController) {
                    _webController.complete(webViewController);
                    _controller = webViewController;
                  },
                  gestureRecognizers: Set()
                    ..add(Factory<VerticalDragGestureRecognizer>(
                        () => VerticalDragGestureRecognizer())),
                  onProgress: (progress) => setState(() {
                    this.progress = progress / 100;
                  }),
                )),
              ],
            ),
            const Center(
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            ),
          ],
        ),
      )),
    );
  }

  Future<bool> _goBack(BuildContext context) async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return Future.value(false);
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Do you want to exit'),
                actions: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('No'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child: const Text('Yes'),
                  ),
                ],
              ));
      return Future.value(true);
    }
  }
}
