import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/game_viewmodel.dart';

class GameItemsView extends StatelessWidget {
  const GameItemsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameViewModel()..fetchGames(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Free To Play Games'),
        ),
        body: Consumer<GameViewModel>(
          builder: (context, viewModel, _) {
            if (!viewModel.isInitialized) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Search Games',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: viewModel.searchGames,
                  ),
                ),
                Expanded(
                  child: viewModel.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : viewModel.error != null
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    viewModel.error!,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: viewModel.fetchGames,
                                    child: const Text('Retry'),
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemCount: viewModel.games.length,
                              itemBuilder: (context, index) {
                                final game = viewModel.games[index];
                                return Card(
                                  margin: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    leading: Image.network(
                                      game.thumbnail,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) =>
                                          const Icon(Icons.broken_image),
                                    ),
                                    title: Text(game.title),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(game.shortDescription),
                                        Text('Genre: ${game.genre}'),
                                        Text('Platform: ${game.platform}'),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
