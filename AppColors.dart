import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color? backgroundColor;
  final Color? textColor;
  final Color? appBarTextColor;
  final Color? cardColor;
  final Color? accentColor;

  const AppColors({
    required this.backgroundColor,
    required this.textColor,
    required this.appBarTextColor,
    required this.cardColor,
    required this.accentColor,
  });

  @override
  AppColors copyWith({
    Color? backgroundColor,
    Color? textColor,
    Color? appBarTextColor,
    Color? cardColor,
    Color? accentColor,
  }) {
    return AppColors(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      appBarTextColor: appBarTextColor ?? this.appBarTextColor,
      cardColor: cardColor ?? this.cardColor,
      accentColor: accentColor ?? this.accentColor,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      textColor: Color.lerp(textColor, other.textColor, t),
      appBarTextColor: Color.lerp(appBarTextColor, other.appBarTextColor, t),
      cardColor: Color.lerp(cardColor, other.cardColor, t),
      accentColor: Color.lerp(accentColor, other.accentColor, t),
    );
  }
}