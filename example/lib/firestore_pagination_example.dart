// Flutter Packages
import 'package:flutter/material.dart';

// Firebase Packages
import 'package:cloud_firestore/cloud_firestore.dart';

// Third Party Packages
import 'package:firebase_pagination/firebase_pagination.dart';

class FirestorePaginationExample extends StatefulWidget {
  const FirestorePaginationExample({super.key});

  @override
  State<FirestorePaginationExample> createState() =>
      _FirestorePaginationExampleState();
}

class _FirestorePaginationExampleState
    extends State<FirestorePaginationExample> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore Pagination Example'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FirestorePagination(
                query: FirebaseFirestore.instance
                    .collection('messages')
                    .orderBy('createdAt', descending: true),
                isLive: true,
                limit: 6,
                reverse: true,
                padding: const EdgeInsets.all(8.0),
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, snapshot, index) {
                  final msg = snapshot[index].get('text');

                  return ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    tileColor: Colors.green,
                    title: SelectableText('$msg'),
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
                      focusNode: _focusNode,
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
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        height: MediaQuery.of(context).padding.bottom,
      ),
    );
  }

  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    FirebaseFirestore.instance.collection('messages').add({
      'text': text,
      'createdAt': FieldValue.serverTimestamp(),
    });
    _textController.clear();
    // Move focus back to the text field after sending the message
    _focusNode.requestFocus();
  }
}
