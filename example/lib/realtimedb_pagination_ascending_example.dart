// Flutter Packages
import 'package:flutter/material.dart';

// Firebase Packages
import 'package:firebase_database/firebase_database.dart';

// Third Party Packages
import 'package:firebase_pagination/firebase_pagination.dart';

class RealtimeDBAscendingPaginationExample extends StatefulWidget {
  const RealtimeDBAscendingPaginationExample({super.key});

  @override
  State<RealtimeDBAscendingPaginationExample> createState() =>
      _RealtimeDBAscendingPaginationExampleState();
}

class _RealtimeDBAscendingPaginationExampleState
    extends State<RealtimeDBAscendingPaginationExample> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Realtime DB Ascending Pagination Example'),
      ),
      body: Column(
        children: [
          Expanded(
            child: RealtimeDBPagination(
              query: FirebaseDatabase.instance
                  .ref('TODO List')
                  .orderByChild('createdAt'),
              orderBy: 'createdAt',
              isLive: true,
              limit: 6,
              padding: const EdgeInsets.all(8.0),
              separatorBuilder: (context, index) => const Divider(),
              onEmpty: const Center(
                child: Text('No TODO tasks found!!!'),
              ),
              itemBuilder: (context, snapshot, index) {
                final msg = snapshot.child('text').value as String?;

                return ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  tileColor: Colors.blueAccent[700],
                  title: SelectableText(
                    '${index + 1}. $msg',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
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
                    focusNode: _focusNode..requestFocus(),
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: 'Enter a TODO task',
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8.0),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    FirebaseDatabase.instance.ref('TODO List').push().set({
      'text': text,
      'createdAt': ServerValue.timestamp,
    });
    _textController.clear();
    // Move focus back to the text field after sending the message
    _focusNode.requestFocus();
  }
}
