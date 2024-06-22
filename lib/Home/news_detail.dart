import 'dart:io';
import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailView extends StatefulWidget {
  const NewsDetailView({super.key});


  @override
  State<NewsDetailView>  createState() =>
      _NewsDetailViewState();
}

class _NewsDetailViewState extends State<NewsDetailView> {
  _NewsDetailViewState();
  String url='';

  late final WebViewController wvCtrl;

  @override
  Widget build(BuildContext context) {
    // get arguments
    dynamic args = ModalRoute.of(context)!.settings.arguments;
    if (args !=null ) {
      url = args['webUrl'];
      if (url.isNotEmpty ) {
        wvCtrl = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse(url));
      }
    }

    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.red[300],
          title: const Text('LetterSub'),
        ),
        body: Column(children: [
          Expanded(
              child: url==''
                  ? Text('URL Error!')
                  : WebViewWidget(controller: wvCtrl)
          )
        ])
    );
  }
}
