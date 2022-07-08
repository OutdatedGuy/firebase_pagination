// Flutter Packages
import 'package:flutter/widgets.dart';

// Data Models
import 'view_type.dart';

/// The properties of the [Wrap] widget in the [ViewType.wrap] view.
class WrapOptions {
  /// Creates a object that contains the properties of the [Wrap] widget.
  const WrapOptions({
    this.direction = Axis.horizontal,
    this.alignment = WrapAlignment.center,
    this.spacing = 5.0,
    this.runAlignment = WrapAlignment.start,
    this.runSpacing = 5.0,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.clipBehavior = Clip.none,
  });

  /// The direction to use as the main axis.
  ///
  /// Defaults to [Axis.horizontal].
  final Axis direction;

  /// How the children within a run should be placed in the main axis.
  ///
  /// Defaults to [WrapAlignment.center].
  final WrapAlignment alignment;

  /// How much space to place between children in a run in the main axis.
  ///
  /// Defaults to 5.0.
  final double spacing;

  /// How the runs themselves should be placed in the cross axis.
  ///
  /// Defaults to [WrapAlignment.start].
  final WrapAlignment runAlignment;

  /// How much space to place between the runs themselves in the cross axis.
  ///
  /// Defaults to 5.0.
  final double runSpacing;

  /// How the children within a run should be aligned relative to each other in
  /// the cross axis.
  ///
  /// Defaults to [WrapCrossAlignment.start].
  final WrapCrossAlignment crossAxisAlignment;

  /// Determines the order to lay children out horizontally and how to interpret
  /// `start` and `end` in the horizontal direction.
  final TextDirection? textDirection;

  /// Determines the order to lay children out vertically and how to interpret
  /// `start` and `end` in the vertical direction.
  ///
  /// Defaults to [VerticalDirection.down].
  final VerticalDirection verticalDirection;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.none].
  final Clip clipBehavior;
}
