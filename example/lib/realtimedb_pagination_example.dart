// Flutter Packages
import 'package:flutter/material.dart';

// Firebase Packages
import 'package:firebase_database/firebase_database.dart';

// Third Party Packages
import 'package:firebase_pagination/firebase_pagination.dart';

class RealtimeDBPaginationExample extends StatefulWidget {
  const RealtimeDBPaginationExample({super.key});

  @override
  State<RealtimeDBPaginationExample> createState() =>
      _RealtimeDBPaginationExampleState();
}

class _RealtimeDBPaginationExampleState
    extends State<RealtimeDBPaginationExample> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Realtime DB Pagination Example'),
      ),
      body: Column(
        children: [
          Expanded(
            child: RealtimeDBPagination(
              query: FirebaseDatabase.instance
                  .ref('messages')
                  .orderByChild('createdAt'),
              orderBy: 'createdAt',
              isLive: true,
              limit: 6,
              reverse: true,
              padding: const EdgeInsets.all(8.0),
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, snapshot, index) {
                String? msg = Map<String, dynamic>.from(
                  snapshot.value! as Map<Object?, Object?>,
                )['text'];

                return ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  tileColor: msg == null ? Colors.red : Colors.green,
                  title: Text(
                    msg ?? 'No Message',
                    style: TextStyle(color: msg == null ? Colors.white : null),
                  ),
                );
              },
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'Enter a message',
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    FirebaseDatabase.instance.ref('messages').push().set({
                      'text': _textController.text,
                      'createdAt': -DateTime.now().millisecondsSinceEpoch,
                    });
                    _textController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
