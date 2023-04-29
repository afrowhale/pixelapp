import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pixel_canvas_painter.dart';

class CanvasViewer extends StatelessWidget {
  const CanvasViewer({
    Key? key,
    required this.onPixelAdd,
    required this.color,
    required this.pixels,
  }) : super(key: key);

  final Function(Offset, Color) onPixelAdd;
  final Map<Offset, Color> pixels;
  final Color color;

  @override
  Widget build(BuildContext context) => InteractiveViewer(
        constrained: false,
        minScale: 0.8,
        maxScale: 20,
        child: SizedBox(
          width: 1000,
          height: 1000,
          child: Listener(
         onPointerDown: (event) {
  if (RawKeyboard.instance.keysPressed.isEmpty &&
                  event.buttons == 1) {
    final pixelOffset = event.localPosition;
    const pixelSize = 1.0; // Define the size of a single pixel
    final gridX = (pixelOffset.dx / pixelSize).floor();
    final gridY = (pixelOffset.dy / pixelSize).floor();
    final roundedOffset = Offset(gridX * pixelSize, gridY * pixelSize);

    bool pixelExists = pixels.containsKey(roundedOffset);
    if (!pixelExists) {
      onPixelAdd(roundedOffset, color);
    }
  }
},



            child: CustomPaint(
              size: const Size(1000, 1000),
              painter: MyPainter(
                pixels: pixels,
              ),
            ),
          ),
        ),
      );
}
