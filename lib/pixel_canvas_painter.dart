import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class Pixel extends Equatable {
  final Offset offset;
  final Color color;

  const Pixel({
    required this.offset,
    required this.color,
  });

  @override
  List<Object> get props => [offset, color];

  @override
  int get hashCode => offset.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Pixel && other.offset == offset && other.color == color;
  }
}

class MyPainter extends CustomPainter {
  final Map<Offset, Color> pixels;

  MyPainter({required this.pixels});

  @override
  void paint(Canvas canvas, Size size) {
    const pixelSize = 1.0; // Define the size of a single pixel

    for (final entry in pixels.entries) {
      final pixelOffset = entry.key;
      final pixelColor = entry.value;

      final pixelRect = Rect.fromLTWH(
        pixelOffset.dx,
        pixelOffset.dy,
        pixelSize,
        pixelSize,
      );

      canvas.drawRect(
        pixelRect,
        Paint()
          ..color = pixelColor
          ..style = PaintingStyle.fill,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
