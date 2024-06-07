// Flutter Packages
import 'package:flutter/widgets.dart';

/// The [ScrollView] to use for the loaded data.
///
/// Supports [list], [grid], and [wrap].
enum ViewType {
  /// Loads the data as a [ListView].
  list,

  /// Loads the data as a [GridView].
  grid,

  /// Loads the data as a scrollable [Wrap].
  wrap,

  /// Loads the data as a [PageView].
  page,
}
