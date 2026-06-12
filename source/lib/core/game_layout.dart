import 'package:flutter/material.dart';
import 'dart:math' as math;

class GameLayout {
  static double getCardHeight(BuildContext context, BoxConstraints constraints) {
    // Base height on screen size to ensure absolute consistency across different game UIs
    final screenHeight = MediaQuery.of(context).size.height;
    final availableHeight = constraints.maxHeight;
    // We want the card to be large but fit within constraints. 
    // 0.5 of screen height is a safe, consistent bet for most phones.
    // Ensure lower bound is not greater than upper bound to avoid ArgumentError
    final maxAllowedHeight = availableHeight * 0.95;
    final minHeight = math.min(250.0, maxAllowedHeight);
    return (screenHeight * 0.5).clamp(minHeight, maxAllowedHeight);
  }

  static double getCardWidth(double cardHeight, BoxConstraints constraints) {
    // Set width to 90% of the available screen width as requested
    return constraints.maxWidth * 0.90;
  }
}
