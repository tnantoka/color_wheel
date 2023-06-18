import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart' hide Route;

import 'routes/routes.dart';

class MainGame extends FlameGame with HasCollisionDetection {
  final contentSize = Vector2(375, 667);
  final contentBackgroundColor = Colors.black;

  late final RouterComponent router;
  var score = 0;

  var _contentArea = RectangleComponent();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    await add(
      _contentArea = RectangleComponent(
        size: contentSize,
        paint: Paint()..color = contentBackgroundColor,
      ),
    );

    router = RouterComponent(
      routes: {
        'home': Route(Home.new),
        'play': Route(Play.new),
        'result': Route(Result.new),
      },
      initialRoute: 'home',
    );
    await _contentArea.add(router);
  }

  @override
  void onGameResize(Vector2 size) {
    final scale = size.y / contentSize.y;
    _contentArea.scale = Vector2.all(scale);
    _contentArea.position =
        Vector2(size.x * 0.5 - contentSize.x * 0.5 * scale, 0);
    super.onGameResize(size);
  }

  @override
  Color backgroundColor() {
    return Colors.grey.shade700;
  }
}
