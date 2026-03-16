import 'dart:math';

import 'package:flutter/material.dart';
import 'package:solid_software_test_app/color_converter.dart';
import 'package:solid_software_test_app/color_system_widget.dart';

/// Value of black color in RGB pallet
const lowerBorderValue = 0xFF000000;

/// 16 777 216 decimal value in hexadecimal system
/// (number of possible colors to generate)
/// 0x00FFFFFF + 1
const topBorderValue = 0x1000000;

void main() {
  runApp(const Main());
}

/// Main class for the app
class Main extends StatelessWidget {
  /// Constructor for the class
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

/// Home screen of the app
class MyHomePage extends StatefulWidget {
  /// Constructor for the class
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _generator = Random();
  Color _backgroundColor = Colors.white;

  void _drawColor() {
    final newColor = lowerBorderValue + _generator.nextInt(topBorderValue);
    setState(() {
      _backgroundColor = Color(newColor);
    });
  }

  @override
  Widget build(BuildContext context) {
    final redValue = _backgroundColor.convertTo8bit(_backgroundColor.r);
    final greenValue = _backgroundColor.convertTo8bit(_backgroundColor.g);
    final blueValue = _backgroundColor.convertTo8bit(_backgroundColor.b);

    final (hue, saturation, lightness) = _backgroundColor.convertToHSL();

    final (cyan, magenta, yellow, black) = _backgroundColor.convertToCMYK();

    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _drawColor,
        child: AnimatedContainer(
          width: double.infinity,
          height: double.infinity,
          duration: const Duration(milliseconds: 500),
          decoration: BoxDecoration(
            color: _backgroundColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(child: SizedBox()),
              Text(
                'Hello there',
                style: TextStyle(
                  color: _backgroundColor.getContrastColor(),
                  fontWeight: FontWeight.bold,
                  fontSize: 32.0,
                ),
              ),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ColorSystemWidget(
                      systemName: 'RGB',
                      textColor: _backgroundColor.getContrastColor(),
                      colorValues: [
                        'RED: $redValue ',
                        'GREEN: $greenValue ',
                        'BLUE: $blueValue ',
                      ],
                    ),

                    ColorSystemWidget(
                      systemName: 'HSL',
                      textColor: _backgroundColor.getContrastColor(),
                      colorValues: [
                        'HUE: $hue ',
                        'SATURATION: $saturation% ',
                        'LIGHTNESS: $lightness% ',
                      ],
                    ),
                    ColorSystemWidget(
                      systemName: 'CMYK',
                      textColor: _backgroundColor.getContrastColor(),
                      colorValues: [
                        'CYAN: $cyan% ',
                        'MAGENTA: $magenta% ',
                        'YELLOW: $yellow% ',
                        'BLACK: $black% ',
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
