import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import 'ball.dart';

class Wheel extends CustomPainterComponent
    with HasGameRef, TapCallbacks, CollisionCallbacks {
  Wheel({
    super.position,
    super.size,
    required this.onSuccess,
    required this.onFail,
  }) : super(
          anchor: Anchor.center,
        );

  static final colors = [
    const Color.fromARGB(255, 254, 109, 104),
    const Color.fromARGB(255, 254, 200, 66),
    const Color.fromARGB(255, 0, 149, 56),
    const Color.fromARGB(255, 93, 150, 219),
    const Color.fromARGB(255, 0, 113, 207),
    const Color.fromARGB(255, 191, 83, 80),
  ];

  final VoidCallback onSuccess;
  final VoidCallback onFail;

  var _colorIndex = 0;

  @override
  Future onLoad() async {
    super.onLoad();

    painter = WheelPainter(
        colors: colors,
        backgroundColor: game.backgroundColor(),
        colorIndex: _colorIndex);

    await add(
      CircleHitbox(),
    );
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);

    if (event.localPosition.x < size.x * 0.5) {
      _colorIndex++;
      if (_colorIndex > colors.length - 1) {
        _colorIndex = 0;
      }
    } else {
      _colorIndex--;
      if (_colorIndex < 0) {
        _colorIndex = colors.length - 1;
      }
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    (painter as WheelPainter).colorIndex = _colorIndex;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Ball) {
      other.removeFromParent();
      if (other.colorIndex == _colorIndex) {
        onSuccess();
      } else {
        onFail();
      }
    }
  }
}

class WheelPainter extends CustomPainter {
  WheelPainter({
    required this.colors,
    required this.backgroundColor,
    required this.colorIndex,
  });

  final List<Color> colors;
  final Color backgroundColor;
  int colorIndex;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(
      0,
      0,
      size.width,
      size.height,
    );

    final step = 360 / colors.length;

    for (var i = 0; i < colors.length; i++) {
      canvas.drawArc(
        rect,
        radians((i - colorIndex) * step - 90 - step * 0.5),
        radians(step),
        true,
        Paint()..color = colors[i],
      );
    }

    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.5),
      size.width * 0.28,
      Paint()..color = backgroundColor,
    );
  }

  @override
  bool shouldRepaint(covariant WheelPainter oldDelegate) {
    return oldDelegate.colorIndex != colorIndex;
  }
}
