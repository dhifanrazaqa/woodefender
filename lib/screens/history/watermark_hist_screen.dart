import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:woodefender/services/history_service.dart';
import 'package:woodefender/widgets/history/history_container.dart';

class WatermarkHistScreen extends StatefulWidget {
  const WatermarkHistScreen({super.key});

  @override
  State<WatermarkHistScreen> createState() => _WatermarkHistScreenState();
}

class _WatermarkHistScreenState extends State<WatermarkHistScreen> {
  final HistoryService _historyService = HistoryService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'History',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700
            ),
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
                watermarkHistory.sort((a, b) => (b['createdAt'] as DateTime).compareTo(a['createdAt'] as DateTime));
                return ListView.builder(
                  itemCount: watermarkHistory.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> _history = watermarkHistory[index];
                    
                    if(index == 0) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Watermark',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 20,),
                          HistoryContainer(
                            title: _history['title'],
                            createdAt: DateFormat('dd MMMM yyyy, kk:mm a').format(_history['createdAt']),
                            original: _history['type'],
                            edited: _history['edited'],
                            type: 'Watermark',
                          ),
                        ],
                      );
                    }
                    return HistoryContainer(
                      title: _history['title'],
                      createdAt: DateFormat('dd MMMM yyyy, kk:mm a').format(_history['createdAt']),
                      original: _history['type'],
                      edited: _history['edited'],
                      type: 'Watermark',
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}