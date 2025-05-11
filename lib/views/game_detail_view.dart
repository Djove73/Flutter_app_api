import 'package:flutter/material.dart';
import '../models/game_item.dart';

class GameDetailView extends StatelessWidget {
  final GameItem game;

  const GameDetailView({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(game.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            if (game.thumbnail.isNotEmpty)
              Center(
                child: Image.network(
                  game.thumbnail,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 100),
                ),
              ),
            const SizedBox(height: 16),
            Text(
              game.title,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Genre: ${game.genre}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Platform: ${game.platform}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              game.shortDescription,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
