import 'dart:io';
import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailView extends StatefulWidget {
  final Map? arguments;

  const NewsDetailView( {super.key, this.arguments} );

  @override
  State<NewsDetailView>  createState() =>
      _NewsDetailViewState();
}

class _NewsDetailViewState extends State<NewsDetailView> {
  _NewsDetailViewState();
  late String url;

  late final WebViewController wvCtrl;
  double height = 0;


  @override
  void initState() {
    super.initState();
    url = widget.arguments!=null  ? widget.arguments!['webUrl']: '';
    if(url!='') {
      wvCtrl = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: const Text('News'),
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
