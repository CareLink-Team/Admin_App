import 'package:flutter/material.dart';

abstract final class AppColors {
  // Brand / Medical identity colors
  static const Color primary = Color(0xFF1145A4); // Calm medical blue
  static const Color secondary = Color(0xFFB61D1D); // Alerts / critical

  // Neutrals (UI structure)
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Colors.white;

  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);

  // Status colors
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFDC2626);
}
