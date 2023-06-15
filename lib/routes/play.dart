import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

import '../main_game.dart';

class Play extends Component with HasGameRef<MainGame> {
  late final TextComponent _scoreText;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    await add(
      _scoreText = TextComponent(
        text: game.score.toString(),
        textRenderer: TextPaint(
          style: const TextStyle(
            fontFamily: 'PressStart2P',
            fontSize: 32,
            color: Colors.white,
          ),
        ),
        position: Vector2(
          game.size.x * 0.5,
          game.size.y * 0.4,
        ),
        anchor: Anchor.center,
      ),
    );

    await add(
      ButtonComponent(
        position: Vector2(0, game.size.y),
        onPressed: () => game.router.pushNamed('result'),
        button: TextComponent(
          text: 'Result',
        ),
        anchor: Anchor.bottomLeft,
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    _scoreText.text = game.score.toString();
  }
}
