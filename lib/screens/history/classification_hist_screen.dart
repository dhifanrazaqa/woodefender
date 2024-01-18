import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:woodefender/services/history_service.dart';
import 'package:woodefender/widgets/history/history_container.dart';

class ClassificationHistScreen extends StatefulWidget {
  const ClassificationHistScreen({super.key});

  @override
  State<ClassificationHistScreen> createState() => _ClassificationHistScreenState();
}

class _ClassificationHistScreenState extends State<ClassificationHistScreen> {
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
            future: _historyService.fetchClassificationsByUserId(),
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
                List<Map<String, dynamic>> classificationHistory = _historyService.classifications;
                classificationHistory.sort((a, b) => (b['createdAt'] as DateTime).compareTo(a['createdAt'] as DateTime));
                return ListView.builder(
                  itemCount: classificationHistory.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> _history = classificationHistory[index];
                    
                    if(index == 0) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Classification',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 20,),
                          HistoryContainer(
                            title: _history['title'],
                            createdAt: DateFormat('dd MMMM yyyy, kk:mm a').format(_history['createdAt']),
                            original: _history['original'],
                            edited: _history['edited'],
                            type: 'Classification',
                          ),
                        ],
                      );
                    }
                    return HistoryContainer(
                      title: _history['title'],
                      createdAt: DateFormat('dd MMMM yyyy, kk:mm a').format(_history['createdAt']),
                      original: _history['original'],
                      edited: _history['edited'],
                      type: 'Classification',
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