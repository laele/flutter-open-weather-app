import 'package:flutter/material.dart';

final class AppPallete extends ThemeExtension<AppPallete> {
  final Color? scaffoldBackgroundColor;
  final Color? primaryContainerColor;
  final Color? primaryTextColor;
  final Color? primaryBoxShadowContainerColor;
  final Color? shimmerBoxColor;
  final Color? highlightShimmerColor;
  final Color? snackbarBackgroundColor;
  final Color? snackbarTextColor;

  const AppPallete({
    this.scaffoldBackgroundColor,
    this.primaryTextColor,
    this.primaryContainerColor,
    this.primaryBoxShadowContainerColor,
    this.shimmerBoxColor,
    this.highlightShimmerColor,
    this.snackbarBackgroundColor,
    this.snackbarTextColor,
  });

  @override
  ThemeExtension<AppPallete> copyWith({
    Color? scaffoldBackgroundColor,
    Color? primaryTextColor,
    Color? primaryContainerColor,
    Color? primaryBoxShadowContainerColor,
    Color? shimmerBoxColor,
    Color? highlightShimmerColor,
    Color? snackbarBackgroundColor,
    Color? snackbarTextColor,
  }) {
    return AppPallete(
      scaffoldBackgroundColor: scaffoldBackgroundColor ?? this.scaffoldBackgroundColor,
      primaryTextColor: primaryTextColor ?? this.primaryTextColor,
      primaryContainerColor: primaryContainerColor ?? this.primaryContainerColor,
      primaryBoxShadowContainerColor: primaryBoxShadowContainerColor ?? this.primaryBoxShadowContainerColor,
      shimmerBoxColor: shimmerBoxColor ?? this.shimmerBoxColor,
      highlightShimmerColor: highlightShimmerColor ?? this.highlightShimmerColor,
      snackbarBackgroundColor: snackbarBackgroundColor ?? this.snackbarBackgroundColor,
      snackbarTextColor: snackbarTextColor ?? this.snackbarTextColor,
    );
  }

  @override
  ThemeExtension<AppPallete> lerp(covariant ThemeExtension<AppPallete>? other, double t) {
    if (other is! AppPallete) return this;
    return AppPallete(
      scaffoldBackgroundColor: Color.lerp(scaffoldBackgroundColor, other.scaffoldBackgroundColor, t),
      primaryTextColor: Color.lerp(primaryTextColor, other.primaryTextColor, t),
      primaryContainerColor: Color.lerp(primaryContainerColor, other.primaryContainerColor, t),
      primaryBoxShadowContainerColor: Color.lerp(primaryBoxShadowContainerColor, other.primaryBoxShadowContainerColor, t),
      shimmerBoxColor: Color.lerp(shimmerBoxColor, other.shimmerBoxColor, t),
      highlightShimmerColor: Color.lerp(highlightShimmerColor, other.highlightShimmerColor, t),
      snackbarBackgroundColor: Color.lerp(snackbarBackgroundColor, other.snackbarBackgroundColor, t),
      snackbarTextColor: Color.lerp(snackbarTextColor, other.snackbarTextColor, t),
    );
  }
}

class Palettes {
  static AppPallete light = AppPallete(
    scaffoldBackgroundColor: Color.fromARGB(255, 227, 240, 253),
    primaryTextColor: Color.fromARGB(255, 10, 68, 175),
    primaryContainerColor: Colors.white,
    primaryBoxShadowContainerColor: Colors.black.withAlpha(70),
    shimmerBoxColor: Color.fromARGB(255, 186, 204, 222),
    highlightShimmerColor: Color.fromARGB(255, 210, 222, 234),
    snackbarBackgroundColor: const Color.fromARGB(255, 3, 72, 184),
    snackbarTextColor: Colors.white,
  );
  static AppPallete dark = AppPallete(
    scaffoldBackgroundColor: null,
    primaryTextColor: Colors.white,
    primaryContainerColor: Color.fromARGB(255, 40, 40, 40),
    primaryBoxShadowContainerColor: Colors.black.withAlpha(90),
    shimmerBoxColor: Colors.grey.shade900,
    highlightShimmerColor: Colors.grey.shade800,
    snackbarBackgroundColor: Color.fromARGB(255, 40, 40, 40),
    snackbarTextColor: Colors.white,
  );
}
