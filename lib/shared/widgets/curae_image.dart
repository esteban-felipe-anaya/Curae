import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_tokens.dart';

/// Real network image with a tinted placeholder while loading and a graceful
/// fallback on error. Used everywhere so imagery handling is consistent.
class CuraeImage extends StatelessWidget {
  const CuraeImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    Widget image = CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      fadeInDuration: AppTokens.motionMed,
      placeholder: (_, _) => Container(
        width: width,
        height: height,
        color: scheme.surfaceContainerHighest,
        child: Center(
          child: Icon(Icons.image_outlined,
              color: scheme.onSurfaceVariant.withValues(alpha: 0.4)),
        ),
      ),
      errorWidget: (_, _, _) => Container(
        width: width,
        height: height,
        color: scheme.surfaceContainerHighest,
        child: Icon(Icons.broken_image_outlined, color: scheme.onSurfaceVariant),
      ),
    );
    if (borderRadius != null) {
      image = ClipRRect(borderRadius: borderRadius!, child: image);
    }
    return image;
  }
}

/// Circular avatar backed by a real network portrait.
class CuraeAvatar extends StatelessWidget {
  const CuraeAvatar({super.key, required this.url, this.radius = 24, this.fallback});

  final String url;
  final double radius;
  final String? fallback;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    if (url.isEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: scheme.primaryContainer,
        child: Text(
          (fallback ?? '?').characters.first.toUpperCase(),
          style: TextStyle(color: scheme.onPrimaryContainer),
        ),
      );
    }
    return CircleAvatar(
      radius: radius,
      backgroundColor: scheme.surfaceContainerHighest,
      child: ClipOval(
        child: CuraeImage(
          url: url,
          width: radius * 2,
          height: radius * 2,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
