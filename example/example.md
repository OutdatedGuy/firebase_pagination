## Examples / Usages

> **Note**: This file only contains examples for Firestore Database.  
> But all of this can be implemented for Firebase Realtime Database using the
> RealtimeDBPagination widget with only the `query` and `itemBuilder` params
> differing from FirestorePagination.

#### For a simple list view pagination (with a custom bottom loader)

```dart
FirestorePagination(
  limit: 420, // Defaults to 10.
  viewType: ViewType.list,
  bottomLoader: const Center(
    child: CircularProgressIndicator(
      strokeWidth: 3,
      color: Colors.blue,
    ),
  ),
  query: FirebaseFirestore.instance
      .collection('scores')
      .orderBy('score', descending: true),
  itemBuilder: (context, documentSnapshot, index) {
    final data = documentSnapshot.data() as Map<String, dynamic>?;
    if (data == null) return Container();

    return Container(
      child: RecordTile(
        name: data['name'],
        score: data['score'],
      ),
    );
  },
),
```

<hr />

#### For live chat-like application with pagination (with separator between messages)

```dart
FirestorePagination(
  limit: 69, // Defaults to 10.
  isLive: true, // Defaults to false.
  viewType: ViewType.list,
  reverse: true,
  query: FirebaseFirestore.instance
      .collection('chats')
      .orderBy('createdAt', descending: true),
  itemBuilder: (context, documentSnapshot, index) {
    final data = documentSnapshot.data() as Map<String, dynamic>?;
    if (data == null) return Container();

    return MessageTile(
      senderName: data['senderName'],
      senderImageUrl: data['senderImageUrl'],
      message: data['message'],
      createdAt: data['createdAt'],
    );
  },
  separatorBuilder: (context, index) {
    return const Divider(
      height: 5,
      thickness: 1,
    );
  },
),
```

<hr />

#### For grid view with pagination (with custom no data view)

```dart
FirestorePagination(
  limit: 14, // Defaults to 10.
  viewType: ViewType.grid,
  onEmpty: const Center(
    child: Text('Cart is empty'),
  ),
  query: FirebaseFirestore.instance
      .collection('cart')
      .orderBy('price'),
  itemBuilder: (context, documentSnapshot, index) {
    final data = documentSnapshot.data() as Map<String, dynamic>?;
    if (data == null) return Container();

    return GridTile(
      itemName: data['itemName'],
      itemImageUrl: data['itemImageUrl'],
      price: data['price'],
    );
  },
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    mainAxisSpacing: 8.0,
    crossAxisSpacing: 8.0,
  ),
),
```

<hr />

#### For Scrollable Wrap with pagination (with custom scrollDirection)

```dart
FirestorePagination(
  limit: 12, // Defaults to 10.
  viewType: ViewType.wrap,
  scrollDirection: Axis.horizontal, // Defaults to Axis.vertical.
  query: FirebaseFirestore.instance
      .collection('categories')
      .orderBy('popularity', descending: true),
  itemBuilder: (context, documentSnapshot, index) {
    final data = documentSnapshot.data() as Map<String, dynamic>?;
    if (data == null) return Container();

    return Container(
      constraints: const BoxConstraints(maxWidth: 169),
      child: CategoryTile(
        categoryName: data['categoryName'],
        categoryImageUrl: data['categoryImageUrl'],
      ),
    );
  },
  wrapOptions: const WrapOptions(
    alignment: WrapAlignment.start,
    direction: Axis.vertical,
    runSpacing: 10.0,
  ),
),
```
