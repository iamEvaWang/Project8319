import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lettersub_mobile_application/Services/bookmark_service.dart';
import 'package:lettersub_mobile_application/Services/global_variables.dart';
import 'package:lettersub_mobile_application/route.dart';
import '../user_state.dart';
import 'news_detail.dart';
import 'newsletter_model.dart';

class NewsList extends StatefulWidget {
  const NewsList({super.key});

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late final List<NewsletterModel> _news=[];

  final BookmarkService _bookmarkService = BookmarkService();
  late List<Map<String, dynamic>> _bookmarks;

  @override
  void initState() {
    super.initState();
    final newsletters = _db.collection('newsletters');
    newsletters.get().then((querySnapshot) async {
      if (isLogin){
        _bookmarks = await _bookmarkService.getBookmarks();
        for (var doc in querySnapshot.docs) {
          NewsletterModel newsletter = NewsletterModel.fromFirestore(doc);
          newsletter.isBookmark = _bookmarks.any((item)=>item['docId'] == newsletter.id );
          _news.add(newsletter);
        }
      }else {
        for (var doc in querySnapshot.docs) {
          _news.add(NewsletterModel.fromFirestore(doc));
        }
      }
      setState(() {});
    });
  }

  void _onTapBookmark(NewsletterModel post) async{
    if (post.isBookmark) {
      await _bookmarkService.deleteBookmark( post.id!);
    }else{
      await _bookmarkService.addBookmark( post.id!, post.name!, post.author!, post.date!, post.webUrl!);
    }
    post.isBookmark = !post.isBookmark;
    setState(() { });
  }

  void _onLoginClick(BuildContext context){
    _auth.signOut();
    Navigator.canPop(context) ? Navigator.pop(context) : null;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => UserState()));
  }

  void _onNewsDetail(BuildContext context, String webUrl){
    Navigator.pushNamed(context, RouterTable.newsDetailPage, arguments: {'webUrl': webUrl});
  }

  @override
  Widget build(BuildContext context){
    return Container(
      width: double.infinity,
      height: double.infinity ,
      padding: const EdgeInsets.all(4),
      child: Column(children: [
        Expanded(child: ListView.builder(itemBuilder:(context,index){
          NewsletterModel newsletter = _news.elementAt(index);
          return GestureDetector(
              onTap:(){
                if(isLogin ){
                  _onNewsDetail(context,  newsletter.webUrl!);
                }else{
                  _showConfirmDialog(context).then((val) {
                    if (val) {
                      //_onNewsDetail(context,  newsletter.webUrl!);  // Rerouting inside.
                      _onLoginClick(context);
                    }
                  });}
              },
              child: Card(
                color: Colors.white,
                child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 256,
                          child:  Image.network(newsletter.image!),
                        ),
                        Text(newsletter.name! ,style:TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                        Text(newsletter.description!),
                        Row(
                            children: [
                              Text(newsletter.date! , style: TextStyle(color: Colors.grey )),
                              const Spacer(),
                              IconButton(
                                  onPressed: (){
                                    if(isLogin ){
                                      _onTapBookmark(newsletter);
                                    }else{
                                      _showConfirmDialog(context).then((val) {
                                        if (val) {
                                          //_onNewsDetail(context,  newsletter.webUrl!);  // Rerouting inside.
                                          _onLoginClick(context);
                                        }
                                      });
                                    }
                                  },
                                  icon:   newsletter.isBookmark? Icon(Icons.bookmark , color:Colors.red, ): Icon(Icons.bookmark_border ))
                            ]),
                      ],
                    )
                ),
              ) );
        },
          itemCount: _news.length,))
      ],),);
  }

  Future<bool> _showConfirmDialog(BuildContext context) async {
    bool result = await showDialog(
        context: context,
        builder:(ctx) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text('Confirm'),
            content: Text('Login required for continue.'),
            titlePadding: EdgeInsets.all(24),
            contentPadding: EdgeInsets.all(16),
            actionsPadding: EdgeInsets.all(24),
            actionsAlignment: MainAxisAlignment.end,
            buttonPadding: EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            alignment: Alignment.center,
            actions: [
              TextButton(
                child: Text("Cancel", style: TextStyle(fontSize: 15)),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: Text("Go to Login", style: TextStyle(fontSize: 15)),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
    return result;
  }
}
