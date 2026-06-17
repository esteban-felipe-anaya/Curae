import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/providers.dart';
import '../../core/router/routes.dart';
import '../../core/theme/app_tokens.dart';
import '../../shared/widgets/curae_image.dart';

// ---------------------------------------------------------------------------
// Slide data
// ---------------------------------------------------------------------------

class _Slide {
  const _Slide({
    required this.imageId,
    required this.title,
    required this.subtitle,
  });
  final String imageId;
  final String title;
  final String subtitle;
}

const _slides = [
  _Slide(
    imageId: '1559757148-5c350d0d3c56',
    title: 'Care that comes to you',
    subtitle: 'Book trusted doctors in minutes, from wherever you are.',
  ),
  _Slide(
    imageId: '1571772996211-2f02c9727629',
    title: 'Your health, organised',
    subtitle:
        'Records, prescriptions, and lab results — all in one secure place.',
  ),
  _Slide(
    imageId: '1505751172876-fa1923c5c528',
    title: 'Help is one tap away',
    subtitle:
        'Video consultations, in-person visits, or family appointments — your choice.',
  ),
];

String _imageUrl(String id) =>
    'https://images.unsplash.com/photo-$id?w=1000&q=80&auto=format&fit=crop';

// ---------------------------------------------------------------------------
// Screen
// ---------------------------------------------------------------------------

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _controller = PageController();
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    await ref
        .read(sharedPreferencesProvider)
        .setBool('curae_onboarding_done', true);
    if (mounted) context.go(Routes.login);
  }

  void _next() {
    if (_page < _slides.length - 1) {
      _controller.nextPage(
        duration: AppTokens.motionMed,
        curve: Curves.easeInOut,
      );
    } else {
      _finish();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLast = _page == _slides.length - 1;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // ---- Full-screen PageView ----------------------------------------
          PageView.builder(
            controller: _controller,
            itemCount: _slides.length,
            onPageChanged: (i) => setState(() => _page = i),
            itemBuilder: (_, index) => _SlidePage(slide: _slides[index]),
          ),

          // ---- Skip button ------------------------------------------------
          Positioned(
            top: MediaQuery.paddingOf(context).top + AppTokens.space8,
            right: AppTokens.space16,
            child: AnimatedOpacity(
              opacity: isLast ? 0.0 : 1.0,
              duration: AppTokens.motionFast,
              child: TextButton(
                onPressed: isLast ? null : _finish,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black26,
                  shape: const StadiumBorder(),
                ),
                child: const Text('Skip'),
              ),
            ),
          ),

          // ---- Bottom overlay: dots + button ------------------------------
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _BottomPanel(
              page: _page,
              total: _slides.length,
              isLast: isLast,
              onNext: _next,
              theme: theme,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Slide page
// ---------------------------------------------------------------------------

class _SlidePage extends StatelessWidget {
  const _SlidePage({required this.slide});
  final _Slide slide;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background image
        CuraeImage(url: _imageUrl(slide.imageId), fit: BoxFit.cover),

        // Gradient scrim
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.35, 1.0],
              colors: [
                Colors.transparent,
                Colors.black.withValues(alpha: 0.82),
              ],
            ),
          ),
        ),

        // Text content
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppTokens.space24,
              0,
              AppTokens.space24,
              // Leave room for the bottom panel (dots + button)
              160,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  slide.title,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v12,
                Text(
                  slide.subtitle,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.white.withValues(alpha: 0.85),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Bottom panel — dots + CTA button
// ---------------------------------------------------------------------------

class _BottomPanel extends StatelessWidget {
  const _BottomPanel({
    required this.page,
    required this.total,
    required this.isLast,
    required this.onNext,
    required this.theme,
  });

  final int page;
  final int total;
  final bool isLast;
  final VoidCallback onNext;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppTokens.space24,
        AppTokens.space20,
        AppTokens.space24,
        bottomPadding + AppTokens.space24,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withValues(alpha: 0.7),
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Dot indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              total,
              (i) => AnimatedContainer(
                duration: AppTokens.motionMed,
                margin: const EdgeInsets.symmetric(horizontal: AppTokens.space4),
                width: i == page ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: i == page
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.4),
                  borderRadius: AppTokens.brSm,
                ),
              ),
            ),
          ),
          Gaps.v24,
          // CTA button
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onNext,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: AppTokens.space16),
                shape: const StadiumBorder(),
              ),
              child: Text(
                isLast ? 'Get started' : 'Next',
                style: theme.textTheme.labelLarge?.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
