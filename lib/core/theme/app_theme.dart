import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'colors.dart';
import 'text_styles.dart';

abstract final class AppTheme {
  static ThemeData light = FlexThemeData.light(
    useMaterial3: true,
    colors: FlexSchemeColor.from(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      brightness: Brightness.light,
      swapOnMaterial3: true,
    ),
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      navigationRailUseIndicator: true,
      alignedDropdown: true,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
    fontFamily: AppTextStyles.fontFamily,
  );

  static ThemeData dark = FlexThemeData.dark(
    useMaterial3: true,
    colors: FlexSchemeColor.from(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      brightness: Brightness.dark,
      swapOnMaterial3: true,
    ).defaultError.toDark(30, true),
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnColors: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      navigationRailUseIndicator: true,
      alignedDropdown: true,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
    fontFamily: AppTextStyles.fontFamily,
  );
}
