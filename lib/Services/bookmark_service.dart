import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookmarkService{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addBookmark(String docId, String title, String author, String date, String url) async{
    User? user = _auth.currentUser;
    if (user != null){
      DocumentReference userDoc = _firestore.collection('users').doc(user.uid);
      await userDoc.update({
        'bookmarks': FieldValue.arrayUnion([{
          'docId': docId,
          'title': title,
          'author': author,
          'date': date,
          'url': url,
          'createAt': Timestamp.now(),
        }])
      });
    }else{
      throw Exception('No user is signed in');
    }
  }

  Future<List<Map<String, dynamic>>> getBookmarks() async {
    User? user = _auth.currentUser;
    if (user != null){
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get() ;

      try {
        List<dynamic> bookmarks = userDoc['bookmarks']??[];
        return bookmarks.map((bookmark) =>{
          'docId': bookmark['docId'],
          'title': bookmark['title'],
          'author': bookmark['author'],
          'date': bookmark['date'],
          'url': bookmark['url'],
          'createAt': bookmark['createAt'],
        }).toList();
      } on StateError catch (e, s) {
        await _initBookmarks();
        return [];
      }
  }else{
      throw Exception('No user is signed in');
    }
  }

  Future<void> deleteBookmark(String docId) async {
    User? user = _auth.currentUser;
    if (user != null){
      DocumentReference userDoc = _firestore.collection('users').doc(user.uid);
      DocumentSnapshot userSnapshot = await userDoc.get();
      List<dynamic> bookmarks = userSnapshot['bookmarks']??[];
      bookmarks.removeWhere((bookmark)=> bookmark['docId'] == docId );
      await userDoc.update({'bookmarks': bookmarks});
    }else{
      throw Exception('No user is signed in');
    }
  }

  Future<void> _initBookmarks() async{
    await addBookmark("Doc000000", 'doc_initialization', 'system', 'now', 'https://firebase.google.com/');
    await deleteBookmark('Doc000000');
  }
  
}