import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lettersub_mobile_application/Services/global_variables.dart';
import 'package:lettersub_mobile_application/Services/show_goto_login_dialog.dart';
import '../user_state.dart';
import 'bookmarks_page.dart';
import 'news_list.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  int _selectedIndex = 0;
  final List<BottomNavigationBarItem> _bottomNavItems = const [
          BottomNavigationBarItem(icon: Icon(Icons.home,), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Subscript'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmarks), label: 'Bookmarks'),
          BottomNavigationBarItem(icon: Icon(Icons.person ), label: 'About me'),];

  final List<Widget> _bottomNavPages = const  [NewsList(),NewsList(),NewsList(),BookmarksPage(),BookmarksPage(),];

  @override
  void initState() {
    super.initState();
  }

  void _onLogoutClick(BuildContext context){
    _auth.signOut();
    Navigator.canPop(context) ? Navigator.pop(context) : null;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => UserState()));
  }

  void _onLoginClick(BuildContext context){
    _auth.signOut();
    Navigator.canPop(context) ? Navigator.pop(context) : null;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => UserState()));
  }

  void _onItemTapped(BuildContext context,int index) {
    if(index > 2 ){
      if(!isLogin) {
       showGotoLoginDialog(context).then((val) {
          if (val) {
            _onLoginClick(context);
          }
        });
       return;
      }
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        //backgroundColor: Colors.red[300],
        title: const Center(child: Text('LetterSub')),
        actions: [ isLogin
          ? IconButton(onPressed:()=> _onLogoutClick(context), icon: Icon(Icons.logout))
          : IconButton(onPressed:()=> _onLoginClick(context), icon: Icon(Icons.person) )
        ]),
      bottomNavigationBar: BottomNavigationBar(
        items:_bottomNavItems,
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.red[300],
        onTap: (index) => _onItemTapped(context,index),
      ),
      body:_bottomNavPages[_selectedIndex],
    );
  }

}

