// Flutter Packages
import 'package:flutter/material.dart';

// Firebase Packages
import 'package:firebase_database/firebase_database.dart';

// Third Party Packages
import 'package:firebase_pagination/firebase_pagination.dart';

class RealtimeDBDescendingPaginationExample extends StatefulWidget {
  const RealtimeDBDescendingPaginationExample({super.key});

  @override
  State<RealtimeDBDescendingPaginationExample> createState() =>
      _RealtimeDBDescendingPaginationExampleState();
}

class _RealtimeDBDescendingPaginationExampleState
    extends State<RealtimeDBDescendingPaginationExample> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Realtime DB Descending Pagination Example'),
      ),
      body: Column(
        children: [
          Expanded(
            child: RealtimeDBPagination(
              query: FirebaseDatabase.instance
                  .ref('Chat Messages')
                  .orderByChild('createdAt'),
              orderBy: 'createdAt',
              descending: true,
              isLive: true,
              limit: 6,
              reverse: true,
              padding: const EdgeInsets.all(8.0),
              separatorBuilder: (context, index) => const Divider(),
              onEmpty: const Center(
                child: Text('No messages found!!!'),
              ),
              itemBuilder: (context, snapshot, index) {
                final msg = snapshot.child('text').value as String?;

                return ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  tileColor: msg == null ? Colors.red : Colors.green,
                  title: SelectableText(
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
                    focusNode: _focusNode..requestFocus(),
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: 'Enter a message',
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

    FirebaseDatabase.instance.ref('Chat Messages').push().set({
      'text': text,
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    });
    _textController.clear();
    // Move focus back to the text field after sending the message
    _focusNode.requestFocus();
  }
}
