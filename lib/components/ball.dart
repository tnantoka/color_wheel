import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../main_game.dart';
import 'wheel.dart';

class Ball extends CircleComponent with HasGameRef<MainGame> {
  Ball({required this.colorIndex, super.radius, super.position})
      : super(
          anchor: Anchor.center,
        );

  int colorIndex;
  late final double speed;

  @override
  Future onLoad() async {
    super.onLoad();

    speed = game.contentSize.y * 0.3;

    await add(
      CircleHitbox(),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    paint = Paint()..color = Wheel.colors[colorIndex];
    position.y += speed * dt;
  }
}
