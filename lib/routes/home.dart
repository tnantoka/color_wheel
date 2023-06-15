import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/input.dart';

import '../main_game.dart';

class Home extends Component with HasGameRef<MainGame> {
  @override
  Future<void> onLoad() async {
    super.onLoad();

    await add(
      ButtonComponent(
        position: Vector2(0, game.size.y),
        onPressed: () => game.router.pushNamed('play'),
        button: TextComponent(
          text: 'Play',
        ),
        anchor: Anchor.bottomLeft,
      ),
    );
  }
}
