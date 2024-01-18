import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woodefender/models/Like.dart';
import 'package:woodefender/models/Post.dart';
import 'package:woodefender/models/User.dart';
import 'package:woodefender/screens/community/add_comm_screen.dart';
import 'package:woodefender/services/like_service.dart';
import 'package:woodefender/services/post_service.dart';
import 'package:woodefender/widgets/Community/post_container.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  String type = 'Report';
  late PostService _postProvider;
  late LikeService _likeProvider;

  @override
  Widget build(BuildContext context) {
    _postProvider = Provider.of<PostService>(context, listen: false);
    _likeProvider = Provider.of<LikeService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
              ),
              onPressed: () {
                setState(() {
                  type = 'Post';
                });
              }, child: Column(
                children: [
                  Text(
                    'For You',
                    style: TextStyle(
                      color: type != 'Report' ? Colors.black : Colors.grey
                    ),
                  ),
                  if (type != 'Report')
                    Container(
                      height: 3,
                      width: 72,
                      color: Colors.red,
                    )
                ],
              )
            ),
            TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
              ),
              onPressed: () {
                setState(() {
                  type = 'Report';
                });
              }, child: Column(
                children: [
                  Text(
                    'Report',
                    style: TextStyle(
                      color: type == 'Report' ? Colors.black : Colors.grey
                    ),
                  ),
                  if (type == 'Report')
                    Container(
                      height: 3,
                      width: 37,
                      color: Colors.red,
                    )
                ],
              )
            ),
          ],
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[200],
      body: FutureBuilder(
          future: fetchCombinedData(_postProvider , _likeProvider),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.red,),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              List<Post> filteredReports = _postProvider.posts.where((post) => post.type == type).toList();
              if (type == 'Report') {
                filteredReports.sort((a, b) => b.likeCount!.compareTo(a.likeCount!));
              }
              return ListView.builder(
                itemCount: filteredReports.length,
                itemBuilder: (context, index) {
                  Post post = filteredReports[index];
                  return PostContainer(
                    post: post,
                    type: type,
                    refresh: () { setState(() {}); },
                    isDetail: false,
                  );
                },
              );
            }
          },
        ),
      floatingActionButton: IconButton.filled(
        onPressed: () async {
          final result = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddPostScreen(text: '',)));

          if (result != null) {
            setState(() {
            });
          }
        },
        icon: const Icon(Icons.add),
      ),
    );
  }

  Future<void> fetchCombinedData(PostService postService, LikeService likeService) async {
    await postService.fetchPosts();
    await likeService.fetchLikes();
  }
}