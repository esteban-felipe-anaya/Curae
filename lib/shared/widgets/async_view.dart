import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/api_exception.dart';
import 'states.dart';

/// Renders an [AsyncValue] with consistent loading / error / data handling.
/// Keeps every screen's three states uniform without copy-pasting `.when`.
class AsyncView<T> extends StatelessWidget {
  const AsyncView({
    super.key,
    required this.value,
    required this.data,
    this.loading,
    this.onRetry,
  });

  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final Widget Function()? loading;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return value.when(
      skipLoadingOnReload: true,
      skipLoadingOnRefresh: false,
      data: data,
      loading: () =>
          loading?.call() ?? const Center(child: CircularProgressIndicator()),
      error: (e, _) => ErrorView(
        message: ApiException.from(e).message,
        onRetry: onRetry,
      ),
    );
  }
}
