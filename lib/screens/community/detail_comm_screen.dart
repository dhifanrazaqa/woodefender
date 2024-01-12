import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woodefender/models/Comment.dart';
import 'package:woodefender/models/Like.dart';
import 'package:woodefender/models/Post.dart';
import 'package:woodefender/services/comment_service.dart';
import 'package:woodefender/services/like_service.dart';
import 'package:woodefender/widgets/Community/comment_container.dart';
import 'package:woodefender/widgets/Community/post_container.dart';

class DetailCommScreen extends StatefulWidget {
  const DetailCommScreen({
    super.key,
    required this.post,
    required this.type,
    required this.likeCount,
    required this.isLiked,
  });
  final Post post;
  final String type;
  final int likeCount;
  final bool isLiked;

  @override
  State<DetailCommScreen> createState() => _DetailCommScreenState();
}

class _DetailCommScreenState extends State<DetailCommScreen> {
  late CommentService _commentProvider;
  
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _commentProvider = Provider.of<CommentService>(context, listen: false);
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Postingan',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20
          )
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, widget.likeCount);
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: 70),
        child: Column(
          children: [
            PostContainer(
              post: widget.post,
              type: widget.type,
              refresh: () {},
              isDetail: true,
            ),
            FutureBuilder(
              future: _commentProvider.fetchCommentsByPostId(widget.post.id!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _commentProvider.comments.length,
                    itemBuilder: (context, index) {
                      Comment _comment = _commentProvider.comments[index];
                      return CommentContainer(comment: _comment,);
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(15),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: commentController,
                decoration: InputDecoration(
                  hintText: 'Tambahkan komentar...',
                ),
              ),
            ),
            SizedBox(width: 8.0),
            IconButton(
              color: Colors.white,
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.red)
              ),
              onPressed: () {
                _addComment();
              },
              icon: Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }

  // Method untuk menambahkan komentar
  _addComment() {
    String newComment = commentController.text.trim();
    if (newComment.isNotEmpty) {
      setState(() {
        _commentProvider.addComment(newComment, widget.post.id!);
        commentController.clear();
      });
    }
  }
}