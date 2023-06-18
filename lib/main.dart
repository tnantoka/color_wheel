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
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final game = MainGame();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GameWidget<MainGame>(
          game: game,
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton.icon(
                onPressed: () => launchUrlString('https://flame.tnantoka.com/'),
                icon: const Icon(Icons.home),
                label: const Text('Home'),
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: () =>
                    launchUrlString('https://github.com/tnantoka/color_wheel'),
                icon: const Icon(Icons.code),
                label: const Text('GitHub'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
