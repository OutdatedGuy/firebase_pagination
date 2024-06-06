// Flutter Packages
import 'package:flutter/material.dart';

// Data Models
import 'package:firebase_pagination/src/models/page_options.dart';
import 'package:firebase_pagination/src/models/view_type.dart';
import 'package:firebase_pagination/src/models/wrap_options.dart';

/// A [ScrollView] to use for the provided [items].
///
/// The [items] are loaded into the [ScrollView] based on the [viewType].
class BuildPagination<T> extends StatelessWidget {
  /// Creates a [ScrollView] to use for the provided [items].
  ///
  /// The [items] are rendered in the [ScrollView] using the [itemBuilder].
  ///
  /// The [viewType] determines the type of [ScrollView] to use.
  const BuildPagination({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.separatorBuilder,
    required this.isLoading,
    required this.viewType,
    required this.bottomLoader,
    required this.gridDelegate,
    required this.wrapOptions,
    required this.pageOptions,
    required this.scrollDirection,
    required this.reverse,
    required this.controller,
    required this.pageController,
    required this.shrinkWrap,
    this.physics,
    this.padding,
    this.onPageChanged,
  });

  /// The items to display in the [ScrollView].
  final List<T> items;

  /// The builder to use to render the items.
  final Widget Function(BuildContext, List<T>, int) itemBuilder;

  /// The builder to use to render the separator.
  ///
  /// Only used if [viewType] is [ViewType.list].
  final Widget Function(BuildContext, int) separatorBuilder;

  /// Whether more [items] are being loaded.
  final bool isLoading;

  /// The type of [ScrollView] to use.
  final ViewType viewType;

  /// A [Widget] to show when more [items] are being loaded.
  final Widget bottomLoader;

  /// The delegate to use for the [GridView].
  final SliverGridDelegate gridDelegate;

  /// The options to use for the [Wrap].
  final WrapOptions wrapOptions;

  /// The options to use for the [PageView].
  final PageOptions pageOptions;

  /// The scrolling direction of the [ScrollView].
  final Axis scrollDirection;

  /// Whether the [ScrollView] scrolls in the reading direction.
  final bool reverse;

  /// The scroll controller to handle the scroll events.
  final ScrollController controller;

  /// The page controller to handle page view events.
  final PageController pageController;

  /// Should the [ScrollView] be shrink-wrapped.
  final bool shrinkWrap;

  /// The scroll behavior to use for the [ScrollView].
  final ScrollPhysics? physics;

  /// The padding to use for the [ScrollView].
  final EdgeInsetsGeometry? padding;

  /// Specifies what to do when page changes in the [PageView].
  final void Function(int)? onPageChanged;

  @override
  Widget build(BuildContext context) {
    switch (viewType) {
      case ViewType.list:
        return ListView.separated(
          scrollDirection: scrollDirection,
          reverse: reverse,
          controller: controller,
          physics: physics,
          shrinkWrap: shrinkWrap,
          padding: padding,
          itemCount: items.length + (isLoading ? 1 : 0),
          itemBuilder: (BuildContext context, int index) {
            if (index >= items.length) return bottomLoader;

            return itemBuilder(context, items, index);
          },
          separatorBuilder: separatorBuilder,
        );

      case ViewType.grid:
        return GridView.builder(
          scrollDirection: scrollDirection,
          reverse: reverse,
          controller: controller,
          physics: physics,
          shrinkWrap: shrinkWrap,
          padding: padding,
          itemCount: items.length + (isLoading ? 1 : 0),
          itemBuilder: (BuildContext context, int index) {
            if (index >= items.length) return bottomLoader;

            return itemBuilder(context, items, index);
          },
          gridDelegate: gridDelegate,
        );

      case ViewType.wrap:
        return SingleChildScrollView(
          scrollDirection: scrollDirection,
          reverse: reverse,
          padding: padding,
          physics: physics,
          controller: controller,
          child: Wrap(
            direction: wrapOptions.direction,
            alignment: wrapOptions.alignment,
            spacing: wrapOptions.spacing,
            runAlignment: wrapOptions.runAlignment,
            runSpacing: wrapOptions.runSpacing,
            crossAxisAlignment: wrapOptions.crossAxisAlignment,
            textDirection: wrapOptions.textDirection,
            verticalDirection: wrapOptions.verticalDirection,
            clipBehavior: wrapOptions.clipBehavior,
            children: List.generate(
              items.length + (isLoading ? 1 : 0),
              (int index) {
                if (index >= items.length) return bottomLoader;

                return itemBuilder(context, items, index);
              },
            ),
          ),
        );

      case ViewType.page:
        return PageView.builder(
          scrollDirection: scrollDirection,
          reverse: reverse,
          controller: pageController,
          physics: physics,
          clipBehavior: pageOptions.clipBehavior,
          pageSnapping: pageOptions.pageSnapping,
          onPageChanged: onPageChanged,
          padEnds: pageOptions.padEnds,
          scrollBehavior: pageOptions.scrollBehavior,
          allowImplicitScrolling: pageOptions.allowImplicitScrolling,
          dragStartBehavior: pageOptions.dragStartBehavior,
          itemCount: items.length + (isLoading ? 1 : 0),
          itemBuilder: (BuildContext context, int index) {
            if (index >= items.length) return bottomLoader;

            return itemBuilder(context, items, index);
          },
        );
    }
  }
}
