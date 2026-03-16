import 'dart:math';

import 'package:flutter/material.dart';

/// Maximum value of single color in RGB system
const _maxRGBValue = 255;

/// Value to normalize percentage numbers
const _maxPercentageValue = 100;

/// Threshold for choosing color for the displayed text
const _colorContrastThreshold = 0.2;

/// Class that handles converting color's values between different systems
extension ColorConverter on Color {
  /// Converts RGB color value to 8 bit value
  int convertTo8bit(double colorValue) {
    return (colorValue * _maxRGBValue).round().clamp(0, _maxRGBValue);
  }

  /// Converts RGB to HSL
  (int, int, int) convertToHSL() {
    final hslColor = HSLColor.fromColor(this);

    return (
      hslColor.hue.round(),
      (hslColor.saturation * _maxPercentageValue).round(),
      (hslColor.lightness * _maxPercentageValue).round(),
    );
  }

  /// Converts RGB to CMYK
  (int, int, int, int) convertToCMYK() {
    final r = this.r;
    final g = this.g;
    final b = this.b;

    final k = 1.0 - max(r, max(g, b));

    if (k == 1.0) {
      return (0, 0, 0, _maxPercentageValue);
    }

    final c = (1.0 - r - k) / (1.0 - k);
    final m = (1.0 - g - k) / (1.0 - k);
    final y = (1.0 - b - k) / (1.0 - k);

    return (
      (c * _maxPercentageValue).round(),
      (m * _maxPercentageValue).round(),
      (y * _maxPercentageValue).round(),
      (k * _maxPercentageValue).round(),
    );
  }

  /// Returns better contrasting color for the text
  Color getContrastColor() {
    return computeLuminance() > _colorContrastThreshold
        ? Colors.black
        : Colors.white;
  }
}
