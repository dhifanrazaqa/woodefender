import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentContainer extends StatefulWidget {
  const CommentContainer({
    super.key,
    required this.comment,
  });
  final comment;

  @override
  State<CommentContainer> createState() => _CommentContainerState();
}

class _CommentContainerState extends State<CommentContainer> {
  @override
  Widget build(BuildContext context) {
    final postedAt = DateTime.now().difference(widget.comment.createdAt);
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.comment.user!.imageUrl! != '' ?
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            radius: 23,
            backgroundImage: 
            NetworkImage(widget.comment.user!.imageUrl!),
          )
          :
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            radius: 23,
            backgroundImage: 
            AssetImage('assets/images/user.png'),
          ),
          const SizedBox(width: 8),
          Container(
            width: width * 0.75,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8)
            ),
            // width: ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('${widget.comment.user?.username}', style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),),
                    const SizedBox(width: 12,),
                    Text(
                      timeago.format(DateTime.now().subtract(postedAt), locale: 'en_short'),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5,),
                Text(
                  widget.comment.message,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}