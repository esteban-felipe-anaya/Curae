import 'package:flutter/material.dart';

/// Centralised design tokens. No raw colors / spacing / radii anywhere in the
/// widget tree — everything references these constants.
class AppTokens {
  AppTokens._();

  /// Brand seed — healing emerald-teal.
  static const Color seed = Color(0xFF006C51);

  /// Soft sky-blue accent for informational states.
  static const Color info = Color(0xFF3E7BB6);
  static const Color success = Color(0xFF2E7D52);
  static const Color warning = Color(0xFFB26A00);

  // Spacing scale (4pt grid).
  static const double space2 = 2;
  static const double space4 = 4;
  static const double space8 = 8;
  static const double space12 = 12;
  static const double space16 = 16;
  static const double space20 = 20;
  static const double space24 = 24;
  static const double space32 = 32;
  static const double space48 = 48;

  // Corner radii.
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 24;
  static const double radiusPill = 999;

  static const BorderRadius brSm = BorderRadius.all(Radius.circular(radiusSm));
  static const BorderRadius brMd = BorderRadius.all(Radius.circular(radiusMd));
  static const BorderRadius brLg = BorderRadius.all(Radius.circular(radiusLg));
  static const BorderRadius brXl = BorderRadius.all(Radius.circular(radiusXl));

  // Motion.
  static const Duration motionFast = Duration(milliseconds: 150);
  static const Duration motionMed = Duration(milliseconds: 250);
  static const Duration motionSlow = Duration(milliseconds: 400);

  // Responsive breakpoints (Material 3 window size classes).
  static const double breakpointMedium = 600; // >= tablet
  static const double breakpointExpanded = 840; // >= desktop/web wide

  // Layout.
  static const double maxContentWidth = 1200;
  static const double cardElevation = 0;
}

/// Convenience padding tokens.
class Gaps {
  Gaps._();
  static const h4 = SizedBox(width: AppTokens.space4);
  static const h8 = SizedBox(width: AppTokens.space8);
  static const h12 = SizedBox(width: AppTokens.space12);
  static const h16 = SizedBox(width: AppTokens.space16);
  static const v4 = SizedBox(height: AppTokens.space4);
  static const v8 = SizedBox(height: AppTokens.space8);
  static const v12 = SizedBox(height: AppTokens.space12);
  static const v16 = SizedBox(height: AppTokens.space16);
  static const v24 = SizedBox(height: AppTokens.space24);
  static const v32 = SizedBox(height: AppTokens.space32);
}
