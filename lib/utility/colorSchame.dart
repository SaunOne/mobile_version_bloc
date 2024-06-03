import 'package:flutter/material.dart';
import 'package:mobile_version_bloc/utility/appColor.dart';

final ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme(
    primary: AppColors.primaryColor,
    primaryContainer: AppColors.primaryVariant,
    secondary: AppColors.secondaryColor,
    secondaryContainer: AppColors.secondaryVariant,
    surface: AppColors.surfaceColor,
    background: AppColors.backgroundColor,
    error: AppColors.errorColor,
    onPrimary: AppColors.onPrimaryColor,
    onSecondary: AppColors.onSecondaryColor,
    onSurface: AppColors.onSurfaceColor,
    onBackground: AppColors.onBackgroundColor,
    onError: AppColors.onErrorColor,
    brightness: Brightness.light, // Atau Brightness.dark untuk tema gelap
  ),
  primaryColor: AppColors.primaryColor,
  backgroundColor: AppColors.backgroundColor,
  scaffoldBackgroundColor: AppColors.backgroundColor,
  errorColor: AppColors.errorColor,
  // Tambahkan elemen tema lainnya sesuai kebutuhan
);
