import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lettersub_mobile_application/Services/global_variables.dart';
import 'package:lettersub_mobile_application/route.dart';
import '../user_state.dart';
import 'news_detail.dart';
import 'newsletter_model.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _ScreenState();
}

class _ScreenState extends State<HomePage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late List<NewsletterModel> _news=[];

  @override
  void initState() {
    super.initState();
    final newsletters = _db.collection('newsletters');
    newsletters.get().then((querySnapshot){
      for(var doc in querySnapshot.docs){
        _news.add(NewsletterModel.fromFirestore(doc));
        //_news.add('News id: ${doc.id}');
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
        title: const Text('Homepage'),
        actions: [ isLogin
                      ? IconButton(onPressed:()=> _onSignoutClick(context), icon: Icon(Icons.logout))
                      : IconButton(onPressed:()=> _onLoginClick(context), icon: Icon(Icons.person) )]),
      body:_buildBody(context),
    );
  }

  void _onSignoutClick(BuildContext context){
    _auth.signOut();
    Navigator.canPop(context) ? Navigator.pop(context) : null;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => UserState()));
  }

  void _onLoginClick(BuildContext context){
    _auth.signOut();
    Navigator.canPop(context) ? Navigator.pop(context) : null;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => UserState()));
  }

  Widget _buildBody(BuildContext context){
    return Container(
      width: double.infinity,
      height: double.infinity ,
      padding: const EdgeInsets.all(4),
      child: Column(children: [
        Expanded(child:    ListView.builder(itemBuilder:(context,index){
          NewsletterModel newsletter = _news.elementAt(index);
          return GestureDetector(
              onTap:(){
                Navigator.pushNamed(context, RouterTable.newsDetailPage, arguments: {'webUrl': newsletter.webUrl!}  );
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
                  Text(newsletter.date! , style: TextStyle(color: Colors.grey ),),
                ],
              )
            ),
          ) );
        },
        itemCount: _news.length,))
    ],),);
  }

}
