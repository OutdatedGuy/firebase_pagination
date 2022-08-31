// Flutter Packages
import 'package:flutter/material.dart';

// Dart Packages
import 'dart:async';

// Firebase Packages
import 'package:firebase_database/firebase_database.dart';

// Data Models
import 'models/view_type.dart';
import 'models/wrap_options.dart';

// Widgets
import 'widgets/defaults/bottom_loader.dart';
import 'widgets/defaults/empty_screen.dart';
import 'widgets/defaults/initial_loader.dart';
import 'widgets/views/build_pagination.dart';

// Functions
import 'functions/separator_builder.dart';

/// A [StreamBuilder] that automatically loads more data when the user scrolls
/// to the bottom.
///
/// Optimized for [FirebaseDatabase] with fields like `createdAt` and
/// `timestamp` to sort the data.
///
/// Supports live updates and realtime updates to loaded data.
///
/// Data can be represented in a [ListView], [GridView] or scollable [Wrap].
class RealtimeDBPagination extends StatefulWidget {
  /// Creates a [StreamBuilder] widget that automatically loads more data when
  /// the user scrolls to the bottom.
  ///
  /// Optimized for [FirebaseDatabase] with fields like `createdAt` and
  /// `timestamp` to sort the data.
  ///
  /// Supports live updates and realtime updates to loaded data.
  ///
  /// Data can be represented in a [ListView], [GridView] or scollable [Wrap].
  const RealtimeDBPagination({
    super.key,
    required this.query,
    required this.itemBuilder,
    this.separatorBuilder,
    this.limit = 10,
    this.viewType = ViewType.list,
    this.isLive = false,
    this.gridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
    ),
    this.wrapOptions = const WrapOptions(),
    this.onEmpty = const EmptyScreen(),
    this.bottomLoader = const BottomLoader(),
    this.initialLoader = const InitialLoader(),
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.shrinkWrap = false,
    this.physics,
    this.padding,
    this.controller,
  });

  /// The query to use to fetch data from Firebase Realtime Database.
  ///
  /// ### Note:
  /// - The query must **NOT** contain a `limitToFirst` or `limitToLast` itself.
  /// - The `limit` must be set using the [limit] property of this widget.
  final Query query;

  /// The builder to use to build the items in the list.
  ///
  /// The builder is passed the build context, snapshot of data and index of
  /// the item in the list.
  final Widget Function(BuildContext, DataSnapshot, int) itemBuilder;

  /// The builder to use to render the separator.
  ///
  /// Only used if [viewType] is [ViewType.list].
  ///
  /// Default [Widget] is [SizedBox.shrink].
  final Widget Function(BuildContext, int)? separatorBuilder;

  /// The number of items to fetch from Firebase Realtime Database at once.
  ///
  /// Defaults to `10`.
  final int limit;

  /// The type of view to use for the list.
  ///
  /// Defaults to [ViewType.list].
  final ViewType viewType;

  /// Whether to fetch newly added items as they are added to
  /// Firebase Realtime Database.
  ///
  /// Defaults to `false`.
  final bool isLive;

  /// The delegate to use for the [GridView].
  ///
  /// Defaults to [SliverGridDelegateWithFixedCrossAxisCount].
  final SliverGridDelegate gridDelegate;

  /// The [Wrap] widget properties to use.
  ///
  /// Defaults to [WrapOptions].
  final WrapOptions wrapOptions;

  /// The widget to use when data is empty.
  ///
  /// Defaults to [EmptyScreen].
  final Widget onEmpty;

  /// The widget to use when more data is loading.
  ///
  /// Defaults to [BottomLoader].
  final Widget bottomLoader;

  /// The widget to use when data is loading initially.
  ///
  /// Defaults to [InitialLoader].
  final Widget initialLoader;

  /// The scrolling direction of the [ScrollView].
  final Axis scrollDirection;

  /// Whether the [ScrollView] scrolls in the reading direction.
  final bool reverse;

  /// Should the [ScrollView] be shrink-wrapped.
  final bool shrinkWrap;

  /// The scroll behavior to use for the [ScrollView].
  final ScrollPhysics? physics;

  /// The padding to use for the [ScrollView].
  final EdgeInsetsGeometry? padding;

  /// The scroll controller to use for the [ScrollView].
  ///
  /// Defaults to [ScrollController].
  final ScrollController? controller;

  @override
  State<RealtimeDBPagination> createState() => _RealtimeDBPaginationState();
}

/// The state of the [RealtimeDBPagination] widget.
class _RealtimeDBPaginationState extends State<RealtimeDBPagination> {
  /// All the data that has been loaded from Firebase Realtime Database.
  final List<DataSnapshot> _data = [];

  /// Snapshot subscription for the query.
  ///
  /// Also handles updates to loaded data.
  StreamSubscription<DatabaseEvent>? _streamSub;

  /// Snapshot subscription for the query to handle newly added data.
  StreamSubscription<DatabaseEvent>? _liveStreamSub;

  /// [ScrollController] to listen to scroll end and load more data.
  late final ScrollController _controller =
      widget.controller ?? ScrollController();

  /// Whether initial data is loading.
  bool _isInitialLoading = true;

  /// Whether more data is loading.
  bool _isFetching = false;

  /// Whether the end for given query has been reached.
  ///
  /// This is used to determine if more data should be loaded when the user
  /// scrolls to the bottom.
  bool _isEnded = false;

  /// Loads more data from Firebase Realtime Database and handles
  /// updates to loaded data.
  ///
  /// Setting [getMore] to `false` will only set listener for the
  /// currently loaded data.
  Future<void> _loadData({bool getMore = true}) async {
    // To cancel previous updates listener when new one is set.
    final tempSub = _streamSub;

    if (getMore) setState(() => _isFetching = true);

    final docsLimit = _data.length + (getMore ? widget.limit : 0);
    var docsQuery = widget.query.limitToFirst(docsLimit);
    if (_data.isNotEmpty) {
      docsQuery = docsQuery.startAt(null, key: _data.first.key);
    }

    _streamSub = docsQuery.onValue.listen((DatabaseEvent snapshot) async {
      await tempSub?.cancel();

      _data
        ..clear()
        ..addAll(snapshot.snapshot.children);

      // To set new updates listener for the existing data
      // or to set new live listener if the first data node is removed.
      final isDataRemoved = snapshot.type == DatabaseEventType.childRemoved;

      _isFetching = false;
      if (!_isEnded && !isDataRemoved) {
        _isEnded = snapshot.snapshot.children.length < docsLimit;
      }

      if (isDataRemoved || _isInitialLoading) {
        _isInitialLoading = false;
        if (snapshot.snapshot.children.isNotEmpty) {
          // Set updates listener for the existing data starting from the
          // first data node only.
          await _loadData(getMore: false);
        } else {
          _streamSub?.cancel();
        }
        if (widget.isLive) _setLiveListener();
      }

      if (mounted) setState(() {});
    });
  }

  /// Sets the live listener for the query.
  ///
  /// Fires when new data is added to the query.
  Future<void> _setLiveListener() async {
    // To cancel previous live listener when new one is set.
    final tempSub = _liveStreamSub;

    var latestDocQuery = widget.query.limitToFirst(1);
    if (_data.isNotEmpty) {
      latestDocQuery = latestDocQuery.endBefore(null, key: _data.first.key);
    }

    _liveStreamSub = latestDocQuery.onValue.listen(
      (DatabaseEvent snapshot) async {
        await tempSub?.cancel();
        if (snapshot.snapshot.children.isEmpty) return;

        _data.insert(0, snapshot.snapshot.children.first);

        // To handle newly added data after this curently loaded data.
        await _setLiveListener();

        // Set updates listener for the newly added data.
        _loadData(getMore: false);
      },
    );
  }

  /// To handle scroll end event and load more data.
  void _scrollListener() {
    final position = _controller.position;
    if (position.pixels >= (position.maxScrollExtent - 50) &&
        !_isInitialLoading &&
        !_isFetching &&
        !_isEnded) {
      _loadData();
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
    _controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _streamSub?.cancel();
    _liveStreamSub?.cancel();
    _controller
      ..removeListener(_scrollListener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isInitialLoading
        ? widget.initialLoader
        : _data.isEmpty
            ? widget.onEmpty
            : BuildPagination(
                items: _data,
                itemBuilder: widget.itemBuilder,
                separatorBuilder: widget.separatorBuilder ?? separatorBuilder,
                isLoading: _isFetching,
                viewType: widget.viewType,
                bottomLoader: widget.bottomLoader,
                gridDelegate: widget.gridDelegate,
                wrapOptions: widget.wrapOptions,
                scrollDirection: widget.scrollDirection,
                reverse: widget.reverse,
                controller: _controller,
                shrinkWrap: widget.shrinkWrap,
                physics: widget.physics,
                padding: widget.padding,
              );
  }
}
