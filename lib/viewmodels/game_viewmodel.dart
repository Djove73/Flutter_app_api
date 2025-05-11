import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/game_item.dart';

class GameViewModel extends ChangeNotifier {
  final List<GameItem> _allGames = [];
  final List<GameItem> _filteredGames = [];
  bool _isLoading = false;
  String? _error;
  bool _isInitialized = false;

  List<GameItem> get games => List.unmodifiable(_filteredGames);
  bool get isLoading => _isLoading;
  bool get isInitialized => _isInitialized;
  String? get error => _error;

  Future<void> fetchGames() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('https://www.freetogame.com/api/games'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _allGames.clear();
        _allGames.addAll(data.map((json) => GameItem.fromJson(json)));
        _filteredGames
          ..clear()
          ..addAll(_allGames);
        _isInitialized = true;
      } else {
        _error = 'Error: Código ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Error de conexión: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  void searchGames(String query) {
    final q = query.toLowerCase();
    _filteredGames
      ..clear()
      ..addAll(_allGames.where((game) =>
          game.title.toLowerCase().contains(q) ||
          game.shortDescription.toLowerCase().contains(q) ||
          game.genre.toLowerCase().contains(q)));
    notifyListeners();
  }
}
