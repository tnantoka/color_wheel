import 'package:flame/game.dart';

import 'routes/routes.dart';

class MainGame extends FlameGame with HasCollisionDetection {
  late final RouterComponent router;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    router = RouterComponent(
      routes: {
        'home': Route(Home.new),
        'play': Route(Play.new),
        'result': Route(Result.new),
      },
      initialRoute: 'home',
    );
    await add(router);
  }
}
