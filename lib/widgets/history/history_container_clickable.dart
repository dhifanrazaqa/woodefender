import 'package:flutter/material.dart';
import 'package:woodefender/screens/watermarking/extract/extract_wm_screen.dart';

class HistoryContainerClickable extends StatefulWidget {
  const HistoryContainerClickable({
    super.key,
    required this.title,
    required this.createdAt,
    required this.type,
    required this.wm_size,
  });
  final title;
  final createdAt;
  final type;
  final wm_size;

  @override
  State<HistoryContainerClickable> createState() => _HistoryContainerClickableState();
}

class _HistoryContainerClickableState extends State<HistoryContainerClickable> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ExtractWmScreen(
              type: widget.type,
              wm_size: widget.wm_size,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Container(
          width: width,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8)
          ),
          child: Row(
            children: [
              Container(
                width: width * 0.78,
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
                    Text("${widget.type} Watermarking"),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
    );
  }
}