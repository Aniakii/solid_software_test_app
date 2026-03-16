import 'package:flutter/material.dart';

/// Widget to represent color values in a specific system
class ColorSystemWidget extends StatelessWidget {
  /// constructor for the widget
  const ColorSystemWidget({
    required this.systemName,
    required this.textColor,
    required this.colorValues,
    super.key,
  });

  /// name of the represented system
  final String systemName;

  /// color of the text
  final Color textColor;

  /// names and values of elements in represented system
  final List<String> colorValues;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          Text(
            '$systemName values:',
            textAlign: .center,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          Wrap(
            alignment: .spaceEvenly,
            children: colorValues.map((element) {
              return Text(
                element,
                style: TextStyle(
                  color: textColor,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
