import 'package:flutter/material.dart';
import 'package:lettersub_mobile_application/Services/bookmark_service.dart';
import 'package:lettersub_mobile_application/Services/global_variables.dart';
import 'package:lettersub_mobile_application/route.dart';
import '../user_state.dart';
import 'newsletter_model.dart';

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({super.key});

  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  final BookmarkService _bookmarkService = BookmarkService();
  late Future<List<Map<String, dynamic>>> _bookmarksFuture;

  @override
  void initState() {
    super.initState();
    _bookmarksFuture = _bookmarkService.getBookmarks();
  }

  void _onNewsDetail(BuildContext context, String webUrl){
    Navigator.pushNamed(context, RouterTable.newsDetailPage, arguments: {'webUrl': webUrl});
  }

  void _deleteBookmark(String postId) async {
    await _bookmarkService.deleteBookmark(postId);
    setState(() {
      _bookmarksFuture = _bookmarkService.getBookmarks();
    });
  }

  @override
  Widget build(BuildContext context){
    return Container(
      width: double.infinity,
      height: double.infinity ,
      padding: const EdgeInsets.all(4),
      child: Column(children: [
        Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _bookmarksFuture,
                builder:(context, snapshot){
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    List<Map<String, dynamic>> bookmarks = snapshot.data??[];
                    return ListView.separated(
                        itemBuilder:(context,index){
                          var bookmark = bookmarks[index];
                          return ListTile(
                            title: Text(bookmark['title'] ,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), ),
                            subtitle: Row(children: [
                              Text(bookmark['author']),
                              const Text(' | '),
                              Text(bookmark['date']),
                            ],),
                            trailing:  IconButton(
                              onPressed: () => _deleteBookmark(bookmark['docId']),
                              icon: const Icon(Icons.bookmark , color:Colors.black )
                            ),
                            onTap: ()=> _onNewsDetail(context, bookmark['url'])
                          );
                        },
                        separatorBuilder: (context,index)=> const Divider() ,
                        itemCount: bookmarks.length) ;
                  }
                }
            ),
        )
      ],),);
  }
}
