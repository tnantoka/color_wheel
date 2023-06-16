import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'main_game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final game = MainGame();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget<MainGame>(
        game: game,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            launchUrlString('https://github.com/tnantoka/color_wheel'),
        backgroundColor: Colors.blueGrey,
        child: const Icon(Icons.code),
      ),
    );
  }
}
