import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woodefender/models/Like.dart';
import 'package:woodefender/models/Post.dart';
import 'package:woodefender/screens/community/detail_comm_screen.dart';
import 'package:woodefender/services/like_service.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class PostContainer extends StatefulWidget {
  const PostContainer({
    super.key,
    required this.post,
    required this.type,
    required this.refresh,
    required this.isDetail,
  });
  final Post post;
  final String type;
  final Function refresh;
  final bool isDetail;

  @override
  State<PostContainer> createState() => _PostContainerState();
}

class _PostContainerState extends State<PostContainer> {
  late bool _isLiked;
  late int _likeCount;

  Future<void> _launchUrl(String url) async {
    final Uri _url = Uri.parse(url);

    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final postedAt = DateTime.now().difference(widget.post.createdAt!);
    LikeService _likeProvider = Provider.of<LikeService>(context);

    List<Like> likes = _likeProvider.likes.where((like) => like.postId?.id == widget.post.id).toList();
    _isLiked = likes.where((like) => like.userId?.id == FirebaseAuth.instance.currentUser?.uid).isNotEmpty;
    _likeCount = likes.length;

    return GestureDetector(
      onTap: () async {
        if (!widget.isDetail) {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailCommScreen(
                post: widget.post,
                type: widget.type,
                isLiked: _isLiked,
                likeCount: _likeCount,
              ),
            )
          );
          // widget.refresh();
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 9),
        padding: EdgeInsets.all(12),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                widget.post.user!.imageUrl != '' ?
                CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  radius: 23,
                  backgroundImage: 
                  NetworkImage(widget.post.user!.imageUrl!),
                )
                :
                CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  radius: 23,
                  backgroundImage: 
                  AssetImage('assets/images/user.png'),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${widget.post.user?.username}', style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),),
                    const SizedBox(height: 5,),
                    Text(
                      timeago.format(DateTime.now().subtract(postedAt), locale: 'id'),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 14,),
            widget.isDetail ? 
            Text(
              widget.post.message!,
              maxLines: 150,
              overflow: TextOverflow.ellipsis,
            )
            :
            Text(
              widget.post.message!,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            if(widget.post.imageUrl != '')
              Column(
                children: [
                  const SizedBox(height: 8,),
                  Image.network(
                    widget.post.imageUrl!,
                    width: width,
                    fit: BoxFit.cover,
                  )
                ],
              ),
            const SizedBox(height: 8,),
            if(widget.type == 'Report')
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(Color(0xFF2484FF)),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.grey[200]!)
                    ),
                  ),
                  overlayColor: MaterialStatePropertyAll(Colors.grey[300]),
                  fixedSize: MaterialStatePropertyAll(Size(width, 40)),
                  backgroundColor: const MaterialStatePropertyAll(Colors.white),
                ),
                onPressed: () async {
                  await _launchUrl(widget.post.link!);
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.post.link!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400
                    ),
                  ),
                )
              ),
            const SizedBox(height: 8,),
            const Divider(thickness: 2,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  onPressed: () async {
                    if (_isLiked) {
                      await _likeProvider.deleteLike(widget.post.id!);
                      _likeCount -= 1;
                    } else {
                      await _likeProvider.addLike(widget.post.id!);
                      _likeCount += 1;
                    }
                    setState(() {
                      _isLiked = !_isLiked;
                    });
                  },
                  style: ButtonStyle(
                    overlayColor: MaterialStatePropertyAll(Colors.grey[200]),
                    foregroundColor: MaterialStatePropertyAll(Colors.red)
                  ),
                  icon: _isLiked ? Icon(Icons.thumb_up) : Icon(Icons.thumb_up_alt_outlined),
                  label: Text(
                    _likeCount.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  )
                ),
                TextButton.icon(
                  onPressed: () async {
                    if (!widget.isDetail) {
                      await Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => DetailCommScreen(
                          post: widget.post,
                          type: widget.type,
                          likeCount: _likeCount,
                          isLiked: _isLiked,
                        )
                      ));
                      // widget.refresh();
                    }
                  },
                  style: ButtonStyle(
                    overlayColor: MaterialStatePropertyAll(Colors.grey[200]),
                    foregroundColor: MaterialStatePropertyAll(Colors.black)
                  ),
                  icon: Image.asset(
                    'assets/images/comment_ic.png',
                  ),
                  label: const Text(
                    'Komen',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  )
                ),
                TextButton.icon(
                  onPressed: () {},
                  style: ButtonStyle(
                    overlayColor: MaterialStatePropertyAll(Colors.grey[200]),
                    foregroundColor: MaterialStatePropertyAll(Colors.black)
                  ),
                  icon: const Icon(Icons.share),
                  label: const Text(
                    'Bagikan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  )
                ),
              ],
            ),
            const Divider(thickness: 2,),
          ],
        ),
      ),
    );
  }
}