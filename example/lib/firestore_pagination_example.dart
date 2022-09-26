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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore Pagination Example'),
      ),
      body: Column(
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
                String? msg =
                    (snapshot.data() as Map<String, dynamic>?)?['text'];

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
                  onPressed: () {
                    FirebaseFirestore.instance.collection('messages').add({
                      'text': _textController.text,
                      'createdAt': FieldValue.serverTimestamp(),
                    });
                    _textController.clear();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
