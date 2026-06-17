import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/providers.dart';
import '../../core/router/routes.dart';
import '../../core/theme/app_tokens.dart';
import '../auth/auth_controller.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _boot();
  }

  Future<void> _boot() async {
    try {
      await ref.read(authControllerProvider.future);
    } catch (_) {
      // Ignore auth restore errors — still proceed to routing.
    }

    if (!mounted) return;

    try {
      final done =
          ref.read(sharedPreferencesProvider).getBool('curae_onboarding_done') ??
              false;
      context.go(done ? Routes.home : Routes.onboarding);
    } catch (_) {
      if (mounted) context.go(Routes.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.health_and_safety,
              size: 72,
              color: theme.colorScheme.primary,
            ),
            Gaps.v16,
            Text(
              'Curae',
              style: theme.textTheme.headlineMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            Gaps.v32,
            CircularProgressIndicator(
              color: theme.colorScheme.primary,
              strokeWidth: 2.5,
            ),
          ],
        ),
      ),
    );
  }
}
