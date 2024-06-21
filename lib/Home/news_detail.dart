import 'dart:io';
import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailView extends StatefulWidget {
  final String url;
  final String title;

  NewsDetailView(this.url, this.title);

  @override
  State<NewsDetailView>  createState() =>
      _NewsDetailViewState(this.url, this.title);
}

class _NewsDetailViewState extends State<NewsDetailView> {
  _NewsDetailViewState(this.url, this.title);
  final String url;
  final String title;

  late final WebViewController wvCtrl;
  double height = 0;


  @override
  void initState() {
    super.initState();
    wvCtrl = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(this.title),
        ),
        body: Column(children: [
          Expanded(
              child: WebViewWidget(
                controller: wvCtrl,
              )
          )
        ])
    );
  }
}
