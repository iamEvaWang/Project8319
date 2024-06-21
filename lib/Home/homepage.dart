import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lettersub_mobile_application/Services/global_variables.dart';
import '../user_state.dart';
import 'news_detail.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _ScreenState();
}

class _ScreenState extends State<HomePage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String _strNews1 = 'https://links.fandango.com/view/5e5c5eee60c3207f0826f2cfishbp.9jhby/d9511315';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

  void _onDetailClick(BuildContext context, String url){
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => NewsDetailView(url, "Detail")));
  }

  Widget _buildBody(BuildContext context){
    return Center(child: Column(children: [
      SizedBox(height:24),
      ElevatedButton(
        onPressed:() => _onSignoutClick(context),
        child: const Text('Logout'),
      ),
      Divider(color: Colors.blue, height: 2,),
      SizedBox(height:24),
      ElevatedButton(
        onPressed:() => _onDetailClick(context, _strNews1),
        child: const Text('view news-1'),
      ) ,
      Divider(color: Colors.blue, height: 2,),
    ],),);
  }

}
