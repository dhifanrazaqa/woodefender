import 'package:flutter/material.dart';

class HistoryContainer extends StatefulWidget {
  const HistoryContainer({
    super.key,
    required this.title,
    required this.createdAt,
    required this.original,
    required this.edited,
    required this.type,
  });
  final title;
  final createdAt;
  final original;
  final edited;
  final type;

  @override
  State<HistoryContainer> createState() => _HistoryContainerState();
}

class _HistoryContainerState extends State<HistoryContainer> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        width: width,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.createdAt,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey
              ),
            ),
            if(widget.type == 'Classification')
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12,),
                Text("Original: ${widget.original.toStringAsFixed(1)}%"),
                Text("Edited: ${widget.edited.toStringAsFixed(1)}%"),
              ],
            ),
            if(widget.type == 'Watermark')
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${widget.original} Watermarking"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}