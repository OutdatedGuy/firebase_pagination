// Flutter Packages
import 'package:flutter/material.dart';

/// A circular progress indicator that spins when the [Stream] is loading.
///
/// Used when the [Stream] is loading the first time.
class InitialLoader extends StatelessWidget {
  /// Creates a circular progress indicator that spins when the [Stream] is
  /// loading.
  ///
  /// Used when the [Stream] is loading the first time.
  const InitialLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}
