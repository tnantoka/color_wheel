import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/input.dart';

import '../main_game.dart';

class Play extends Component with HasGameRef<MainGame> {
  @override
  Future<void> onLoad() async {
    super.onLoad();

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
}
