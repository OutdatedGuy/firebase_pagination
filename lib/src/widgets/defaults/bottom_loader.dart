// Flutter Packages
import 'package:flutter/material.dart';

/// A circular progress indicator that spins when the [Stream] is loading.
///
/// Used at the bottom of a [ScrollView] to indicate that more data is loading.
class BottomLoader extends StatelessWidget {
  /// Creates a circular progress indicator that spins when the [Stream] is
  /// loading.
  ///
  /// Used at the bottom of a [ScrollView] to indicate that more data is
  /// loading.
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 25,
        height: 25,
        margin: const EdgeInsets.all(10),
        child: const CircularProgressIndicator.adaptive(
          strokeWidth: 2.5,
        ),
      ),
    );
  }
}
