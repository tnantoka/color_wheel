import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../main_game.dart';
import '../components/components.dart';

class Play extends Component with HasGameRef<MainGame> {
  static final _random = Random();

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
            fontSize: 28,
            color: Colors.white,
          ),
        ),
        position: Vector2(
          game.contentSize.x * 0.5,
          game.contentSize.y * 0.3,
        ),
        anchor: Anchor.center,
      ),
    );

    await add(
      Wheel(
        position: Vector2(
          game.contentSize.x * 0.5,
          game.contentSize.y * 0.7,
        ),
        size: Vector2(
          game.contentSize.y * 0.3,
          game.contentSize.y * 0.3,
        ),
        onSuccess: _onSuccess,
        onFail: _onFail,
      ),
    );
  }

  @override
  void onMount() {
    super.onMount();

    game.score = 0;
    _addBall();
  }

  @override
  void update(double dt) {
    super.update(dt);

    _scoreText.text = game.score.toString();
  }

  Future _onSuccess() async {
    _addBall();
    game.score++;
  }

  Future _onFail() async {
    game.router.pushReplacementNamed('result');
  }

  Future _addBall() async {
    final radius = game.contentSize.y * 0.02;
    await add(
      Ball(
        radius: radius,
        position: Vector2(
          game.contentSize.x * 0.5,
          -radius,
        ),
        colorIndex: _random.nextInt(Wheel.colors.length),
      ),
    );
  }
}
