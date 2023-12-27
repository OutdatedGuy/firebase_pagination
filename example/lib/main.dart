// Flutter Packages
import 'package:flutter/material.dart';

// Firebase Packages
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Views
import 'firestore_pagination_example.dart';
import 'realtimedb_pagination_ascending_example.dart';
import 'realtimedb_pagination_descending_example.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Pagination Example',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Pagination Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FirestorePaginationExample(),
                  ),
                );
              },
              child: const Text('Firestore Pagination Example'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const RealtimeDBAscendingPaginationExample();
                    },
                  ),
                );
              },
              child: const Text('Realtime DB Ascending Pagination Example'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const RealtimeDBDescendingPaginationExample();
                    },
                  ),
                );
              },
              child: const Text('Realtime DB Descending Pagination Example'),
            ),
          ],
        ),
      ),
    );
  }
}
