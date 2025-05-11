import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../views/game_detail_view.dart';
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
        body: Container(
          color: const Color(0xFF36393F), // Discord dark theme background color
          child: Consumer<GameViewModel>(
            builder: (context, viewModel, _) {
              if (!viewModel.isInitialized) {
                return const Center(child: CircularProgressIndicator());
              }

              return Column(
                children: [
                  // Campo de busqueda
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Search Games',
                        labelStyle: const TextStyle(color: Colors.white),
                        prefixIcon: const Icon(Icons.search, color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        filled: true,
                        fillColor: const Color(0xFF202225), // Discord dark theme input color
                      ),
                      style: const TextStyle(color: Colors.white),
                      onChanged: viewModel.searchGames,
                    ),
                  ),
                  // Lista de juegos o mensaje de error
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
                                    color: const Color(0xFF2F3136), // Discord dark theme card color
                                    margin: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => GameDetailView(game: game),
                                          ),
                                        );
                                      },
                                      leading: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          game.thumbnail,
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) =>
                                              const Icon(Icons.broken_image, color: Colors.white),
                                        ),
                                      ),
                                      title: Text(
                                        game.title,
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(game.shortDescription, style: const TextStyle(color: Colors.grey)),
                                          Text('Genre: ${game.genre}', style: const TextStyle(color: Colors.grey)),
                                          Text('Platform: ${game.platform}', style: const TextStyle(color: Colors.grey)),
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
      ),
    );
  }
}
