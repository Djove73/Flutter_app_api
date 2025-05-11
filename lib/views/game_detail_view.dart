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
      body: Container(
        color: const Color(0xFF36393F), // Discord dark theme background color
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                game.title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 8),
              if (game.thumbnail.isNotEmpty)
                Center(
                  child: Image.network(
                    game.thumbnail,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image, size: 100, color: Colors.white),
                  ),
                ),
              const SizedBox(height: 16),
              Text(
                game.shortDescription,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              Text(
                'Genre: ${game.genre}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              Text(
                'Platform: ${game.platform}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
