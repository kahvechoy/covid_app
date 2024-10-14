import 'package:api_challanges_skl/model/hoaxes.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HoaxesDetailScreen extends StatefulWidget {
  final Hoaxes hoaxesItem;

  const HoaxesDetailScreen({super.key, required this.hoaxesItem});

  @override
  State<HoaxesDetailScreen> createState() => _HoaxesDetailScreenState();
}

class _HoaxesDetailScreenState extends State<HoaxesDetailScreen> {
  WebViewController? _controller;
  @override
  Widget build(BuildContext context) {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            print(
              'WebView is $progress% done',
            );
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('${widget.hoaxesItem.url}'));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          '${widget.hoaxesItem.title} ?? Detail Screen',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Jost',
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: WebViewWidget(controller: _controller!),
      ),
    );
  }
}
