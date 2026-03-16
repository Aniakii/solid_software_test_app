import 'dart:math';

import 'package:flutter/material.dart';

/// maximum value of single color in RGB system
const maxRGBValue = 255;

/// value to normalize percentage numbers
const maxPercentageValue = 100;

/// threshold for choosing color for the displayed text
const colorContrastThreshold = 0.2;


/// Class that handles converting color's values between different systems
extension ColorConverter on Color {
  /// Converts RGB color value to 8 bit value
  int convertTo8bit(double colorValue) {
    return (colorValue * maxRGBValue).round().clamp(0, maxRGBValue);
  }

  /// Converts RGB to HSL
  (int, int, int) convertToHSL() {
    final hslColor = HSLColor.fromColor(this);

    return (
      hslColor.hue.round(),
      (hslColor.saturation * maxPercentageValue).round(),
      (hslColor.lightness * maxPercentageValue).round(),
    );
  }

  /// Converts RGB to CMYK
  (int, int, int, int) convertToCMYK() {
    final r = this.r;
    final g = this.g;
    final b = this.b;

    final k = 1.0 - max(r, max(g, b));

    if (k == 1.0) {
      return (0, 0, 0, maxPercentageValue);
    }

    final c = (1.0 - r - k) / (1.0 - k);
    final m = (1.0 - g - k) / (1.0 - k);
    final y = (1.0 - b - k) / (1.0 - k);

    return (
      (c * maxPercentageValue).round(),
      (m * maxPercentageValue).round(),
      (y * maxPercentageValue).round(),
      (k * maxPercentageValue).round(),
    );
  }

  /// Returns better contrasting color for the text
  Color getContrastColor() {
    return computeLuminance() > colorContrastThreshold
        ? Colors.black
        : Colors.white;
  }
}
