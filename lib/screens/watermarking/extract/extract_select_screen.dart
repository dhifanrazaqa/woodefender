import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:woodefender/services/history_service.dart';
import 'package:woodefender/widgets/history/history_container_clickable.dart';

class ExtractSelectScreen extends StatefulWidget {
  const ExtractSelectScreen({super.key});

  @override
  State<ExtractSelectScreen> createState() => _ExtractSelectScreenState();
}

class _ExtractSelectScreenState extends State<ExtractSelectScreen> {
  final HistoryService _historyService = HistoryService();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Text(
                    'Select Watermark',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    '(Configuration)',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[600]
                    ),
                  ),
                  const SizedBox(height: 12,),
                  Container(
                    color: Colors.red,
                    width: width * 0.29,
                    height: 5,
                  )
                ],
              ),
              Column(
                children: [
                  const Text(
                    'Select the image',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    '(Original + Watermark)',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[600]
                    ),
                  ),
                  const SizedBox(height: 12,),
                  Container(
                    color: Colors.grey[300],
                    width: width * 0.29,
                    height: 5,
                  )
                ],
              ),
              Column(
                children: [
                  const Text(
                    'Extracting',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    '(Watermark)',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[600]
                    ),
                  ),
                  const SizedBox(height: 12,),
                  Container(
                    color: Colors.grey[300],
                    width: width * 0.29,
                    height: 5,
                  )
                ],
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(12.0),
          child: FutureBuilder(
            future: _historyService.fetchWatermarksByUserId(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.black,),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                List<Map<String, dynamic>> watermarkHistory = _historyService.watermarks;
                return ListView.builder(
                  itemCount: watermarkHistory.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> _history = watermarkHistory[index];
                    
                    if(index == 0) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Select Watermark',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 20,),
                          HistoryContainerClickable(
                            title: _history['title'],
                            createdAt: DateFormat('dd MMMM yyyy, kk:mm a').format(_history['createdAt']),
                            type: _history['type'],
                            wm_size: _history['wm_size'],
                          ),
                        ],
                      );
                    }
                    return HistoryContainerClickable(
                      title: _history['title'],
                      createdAt: DateFormat('dd MMMM yyyy, kk:mm a').format(_history['createdAt']),
                      type: _history['type'],
                      wm_size: _history['wm_size'],
                    );
                  },
                );
              }
            },
          ),
        )
      ),
    );
  }
}