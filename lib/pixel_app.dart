import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'pixel_canvas_painter.dart';
import 'canvas_viewer.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:firebase_database/firebase_database.dart';


class PixelApp extends StatefulWidget {
  const PixelApp({super.key});

  @override
  _PixelAppState createState() => _PixelAppState();
}

class _PixelAppState extends State<PixelApp> {
  Color _currentColor = Colors.black;
  final Map<Offset, Color> _pixels = {};

  void _showColorPickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: ColorPicker(
            color: _currentColor,
            onColorChanged: (Color color) {
              setState(() => _currentColor = color);
            },
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Got it'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pixel App'),
          backgroundColor: Colors.blueGrey.shade800,
          actions: [
            IconButton(
              icon: const Icon(Icons.color_lens, color: Colors.white),
              onPressed: _showColorPickerDialog,
            ),
          ],
        ),
        body: Center(
          child: CanvasViewer(
            onPixelAdd: (offset, color) {
              setState(() {
                _pixels[offset] = color;
              });
            },
            pixels: _pixels,
            color: _currentColor,
          ),
        ),
      ),
    );
  }
}

class ColorPicker extends StatelessWidget {
  const ColorPicker({
    Key? key,
    required this.color,
    required this.onColorChanged,
  }) : super(key: key);

  final Color color;
  final void Function(Color) onColorChanged;

  @override
  Widget build(BuildContext context) => Flexible(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: BlockPicker(
            pickerColor: color,
            onColorChanged: onColorChanged,
            layoutBuilder: (context, colors, child) => Row(
              children: [for (Color color in colors) child(color)],
            ),
            availableColors: const [
              Colors.red,
              Colors.pink,
              Colors.purple,
              Colors.deepPurple,
              Colors.indigo,
              Colors.blue,
              Colors.lightBlue,
              Colors.cyan,
              Colors.teal,
              Colors.green,
              Colors.lightGreen,
              Colors.lime,
              Colors.yellow,
              Colors.amber,
              Colors.orange,
              Colors.deepOrange,
              Colors.brown,
              Colors.grey,
              Colors.blueGrey,
              Colors.black,
              Colors.white,
            ],
          ),
        ),
      );
}
