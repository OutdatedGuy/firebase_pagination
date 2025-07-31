# Firebase Pagination

A simple and effective way to **Paginate** Firebase related data.

[![pub package][package_svg]][package]
[![GitHub][license_svg]](LICENSE)

[![GitHub issues open][issues_svg]][issues]
[![GitHub issues closed][issues_closed_svg]][issues_closed]

<hr />

|            Realtime Database             |          Firestore           |
| :--------------------------------------: | :--------------------------: |
| ![RealtimeDB Ascending Pagination Demo]  | ![Firestore Pagination Demo] |
| ![RealtimeDB Descending Pagination Demo] |                              |

## Features

- `FirestorePagination` to simplify paginating firestore collections.
- `RealtimeDBPagination` to simplify paginating realtime database nodes.
- Get live updates when new data is added using `isLive` property.
- Get realtime changes on already loaded data.
- Descending pagination for `RealtimeDBPagination`.

## Getting started

#### Add to Dependencies

```yaml
firebase_pagination: ^4.2.0
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
  itemBuilder: (context, docs, index) {
    final data = docs[index].data() as Map<String, dynamic>;

    // Do something cool with the data
  },
),
```

#### Simplest Firebase Realtime Database Pagination

```dart
RealtimeDBPagination(
  query: FirebaseDatabase.instance.ref().child('scores').orderByChild('score'),
  orderBy: 'score',
  itemBuilder: (context, dataNodes, index) {
    final data = dataNodes[index].value as Map<String, dynamic>;

    // Do something cool with the data
  },
),
```

#### For more examples, see the [examples](example/example.md) section.

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

|      Property      |                                              Description                                               |         Type         |             Default             |
| :----------------: | :----------------------------------------------------------------------------------------------------: | :------------------: | :-----------------------------: |
|      `query`       |                 **The query to use to fetch data from Firestore / Realtime Database.**                 |       _Query_        |                -                |
|   `itemBuilder`    |                         **The builder to use to build the items in the list.**                         |      _Function_      |                -                |
| `separatorBuilder` |                            **The builder to use to render the separator.**                             |      _Function_      | `separatorBuilder (package fn)` |
|      `limit`       |                        **The number of items to fetch from Database at once.**                         |        _int_         |              `10`               |
|     `viewType`     |                               **The type of view to use for the list.**                                |      _ViewType_      |         `ViewType.list`         |
|      `isLive`      |                 **Whether to fetch newly added items as they are added to Database.**                  |        _bool_        |             `false`             |
|   `gridDelegate`   |                               **The delegate to use for the GridView.**                                | _SliverGridDelegate_ |       `crossAxisCount: 2`       |
|   `wrapOptions`    |                                 **The Wrap widget properties to use.**                                 |    _WrapOptions_     |         `WrapOptions()`         |
|   `pageOptions`    |                               **The PageView widget properties to use.**                               |    _PageOptions_     |         `PageOptions()`         |
|     `onEmpty`      |                               **The widget to use when data is empty.**                                |       _Widget_       |         `EmptyScreen()`         |
|   `bottomLoader`   |                            **The widget to use when more data is loading.**                            |       _Widget_       |        `BottomLoader()`         |
|  `initialLoader`   |                         **The widget to use when data is loading initially.**                          |       _Widget_       |        `InitialLoader()`        |
| `scrollDirection`  |                             **The scrolling direction of the ScrollView.**                             |        _Axis_        |             `false`             |
|     `reverse`      |                      **Whether the ScrollView scrolls in the reading direction.**                      |        _bool_        |             `false`             |
|    `shrinkWrap`    |                              **Should the ScrollView be shrink-wrapped.**                              |        _bool_        |             `false`             |
|     `physics`      |                           **The scroll behavior to use for the ScrollView.**                           |   _ScrollPhysics_    |                -                |
|     `padding`      |                               **The padding to use for the ScrollView.**                               | _EdgeInsetsGeometry_ |                -                |
|    `controller`    |                             **The controller to use for the ScrollView.**                              |  _ScrollController_  |       ScrollController()        |
|  `pageController`  |                              **The controller to use for the PageView.**                               |   _PageController_   |        PageController()         |
|    `descending`    | **Whether the data should be fetched in descending order or not. Only works for RealtimeDBPagination** |        _bool_        |             `false`             |

### If you liked the package, then please give it a [Like 👍🏼][package] and [Star ⭐][repository]

<!-- Badges URLs -->

[package_svg]: https://img.shields.io/pub/v/firebase_pagination.svg?color=blueviolet
[license_svg]: https://img.shields.io/github/license/OutdatedGuy/firebase_pagination.svg?color=purple
[issues_svg]: https://img.shields.io/github/issues/OutdatedGuy/firebase_pagination.svg
[issues_closed_svg]: https://img.shields.io/github/issues-closed/OutdatedGuy/firebase_pagination.svg?color=green

<!-- Links -->

[package]: https://pub.dev/packages/firebase_pagination
[repository]: https://github.com/OutdatedGuy/firebase_pagination
[issues]: https://github.com/OutdatedGuy/firebase_pagination/issues
[issues_closed]: https://github.com/OutdatedGuy/firebase_pagination/issues?q=is%3Aissue+is%3Aclosed
[RealtimeDB Ascending Pagination Demo]: https://github.com/OutdatedGuy/firebase_pagination/assets/74326345/6f888eac-13c4-422d-a662-0f7bf7f626f8
[RealtimeDB Descending Pagination Demo]: https://github.com/OutdatedGuy/firebase_pagination/assets/74326345/df101fa2-8a51-4fdf-a900-828abb6dbaee
[Firestore Pagination Demo]: https://github.com/OutdatedGuy/firebase_pagination/assets/74326345/7c300ae2-49fb-439e-86fc-10be387c56f8
