# Firebase Pagination

A simple and effective way to **Paginate** Firebase related data.

[![pub package](https://img.shields.io/pub/v/firebase_pagination.svg?color=blueviolet)](https://pub.dev/packages/firebase_pagination)
[![GitHub](https://img.shields.io/github/license/OutdatedGuy/firebase_pagination.svg?color=purple)](https://pub.dev/packages/firebase_pagination/license)
[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)

[![GitHub issues](https://img.shields.io/github/issues/OutdatedGuy/firebase_pagination.svg)](https://github.com/OutdatedGuy/firebase_pagination/issues)
[![GitHub issues](https://img.shields.io/github/issues-pr/OutdatedGuy/firebase_pagination.svg)](https://github.com/OutdatedGuy/firebase_pagination/pulls)

<hr />

![Video Demo](https://user-images.githubusercontent.com/74326345/185149833-ccb22cc3-5cc5-4c33-9109-3b9156b53363.gif)

## Features

- `FirestorePagination` to simplify paginating firestore collections.
- `RealtimeDBPagination` to simplify paginating realtime database nodes.
- Get live updates when new data is added using `isLive` property.
- Get realtime changes on already loaded data.

## Getting started

#### Add to Dependencies

```yaml
firebase_pagination: ^1.0.0
```

#### Import the package

```dart
import 'package:firebase_pagination/firebase_pagination.dart';
```

## Usage

#### Simplest Firestore Pagination

```dart
FirestorePagination(
  query: FirebaseFirestore.instance.collection('scores').orderBy('score'),
  itemBuilder: (context, documentSnapshot, index) {
    final data = documentSnapshot.data() as Map<String, dynamic>;

    // Do something cool with the data
  },
),
```

#### Simplest Firebase Realtime Database Pagination

```dart
RealtimeDBPagination(
  query: FirebaseDatabase.instance.ref().child('scores').orderByChild('score'),
  itemBuilder: (context, dataSnapshot, index) {
    final data = dataSnapshot.value as Map<String, dynamic>;

    // Do something cool with the data
  },
),
```

> For more examples, see the [examples](https://pub.dev/packages/firebase_pagination/example) section.

## How it Works

- A _data listener_ is added to the query with the given limit.
- Every time the user scrolls to the bottom of the list, the limit is increased.
- If there are any changes for the loaded data, it will be automatically updated.
- If `isLive` is true, a _live listener_ is added to fetch data before the first load. (i.e. Newly added data will be automatically loaded)
- When new data is added, the _data listener_ will be removed and a new _data listener_ will be added with the new limit.
- Also the _live listener_ will be removed and a new _live listener_ will be added.

## Efficiency & Performance

- Both `FirestorePagination` and `RealtimeDBPagination` uses maximum of two `stream listeners` to fetch data.
- Hence it is **performant** and uses **minimum amount of resources**.
- The listeners are automatically removed when the widget is removed from the widget tree.
- For fetching data, the widgets uses [this hack](https://stackoverflow.com/a/70645473) to minimize the number of reads from the database.

## Description

|      Property      |                              Description                               |         Type         |             Default             |
| :----------------: | :--------------------------------------------------------------------: | :------------------: | :-----------------------------: |
|      `query`       | **The query to use to fetch data from Firestore / Realtime Database.** |       _Query_        |                -                |
|   `itemBuilder`    |         **The builder to use to build the items in the list.**         |      _Function_      |                -                |
| `separatorBuilder` |            **The builder to use to render the separator.**             |      _Function_      | `separatorBuilder (package fn)` |
|      `limit`       |        **The number of items to fetch from Database at once.**         |        _int_         |              `10`               |
|     `viewType`     |               **The type of view to use for the list.**                |      _ViewType_      |         `ViewType.list`         |
|      `isLive`      | **Whether to fetch newly added items as they are added to Database.**  |        _bool_        |             `false`             |
|   `gridDelegate`   |               **The delegate to use for the GridView.**                | _SliverGridDelegate_ |       `crossAxisCount: 2`       |
|   `wrapOptions`    |                 **The Wrap widget properties to use.**                 |    _WrapOptions_     |         `WrapOptions()`         |
|     `onEmpty`      |               **The widget to use when data is empty.**                |       _Widget_       |         `EmptyScreen()`         |
|   `bottomLoader`   |            **The widget to use when more data is loading.**            |       _Widget_       |        `BottomLoader()`         |
|  `initialLoader`   |         **The widget to use when data is loading initially.**          |       _Widget_       |        `InitialLoader()`        |
| `scrollDirection`  |             **The scrolling direction of the ScrollView.**             |        _Axis_        |             `false`             |
|     `reverse`      |      **Whether the ScrollView scrolls in the reading direction.**      |        _bool_        |             `false`             |
|    `shrinkWrap`    |              **Should the ScrollView be shrink-wrapped.**              |        _bool_        |             `false`             |
|     `physics`      |           **The scroll behavior to use for the ScrollView.**           |   _ScrollPhysics_    |                -                |
|     `padding`      |               **The padding to use for the ScrollView.**               | _EdgeInsetsGeometry_ |                -                |
|    `controller`    |             **The controller to use for the ScrollView.**              |  _ScrollController_  |                -                |
