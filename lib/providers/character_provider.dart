import 'package:flutter/material.dart';

import '../models/character_model.dart';
import '../services/characters_service.dart';



class CharacterProvider extends ChangeNotifier {
  final CharacterApiService _apiService = CharacterApiService();

  final List<Character> _characters = [];
  List<Character> get characters => _characters;

  final Set<int> _favorites = {};
  Set<int> get favorites => _favorites;

  bool isLoading = false;
  bool hasMore = true;
  int _page = 1;

  Future<void> loadCharacters() async {
    if (isLoading || !hasMore) return;

    isLoading = true;
    notifyListeners();

    try {
      final newCharacters = await _apiService.fetchCharacters(page: _page);

      if (newCharacters.isEmpty) {
        hasMore = false;
      } else {
        _characters.addAll(newCharacters);
        _page++;
      }
    } catch (_) {
      hasMore = false;
    }

    isLoading = false;
    notifyListeners();
  }

  void toggleFavorite(int id) {
    _favorites.contains(id) ? _favorites.remove(id) : _favorites.add(id);
    notifyListeners();
  }

  bool isFavorite(int id) => favorites.contains(id);

}