import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/character_model.dart';
import '../services/characters_service.dart';


class CharacterProvider extends ChangeNotifier {
  final CharacterApiService _apiService = CharacterApiService();

  final List<Character> _characters = [];
  List<Character> get characters => _characters;

  final Box<int> _favoritesBox = Hive.box<int>('favorites');
  final Set<int> _favorites = {};

  CharacterProvider() {
    _favorites.addAll(_favoritesBox.values);
  }

  List<Character> get favoriteCharacters =>
      _characters.where((c) => _favorites.contains(c.id)).toList();

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
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading = false;
    notifyListeners();
  }

  void toggleFavorite(int id) {
    if (_favorites.contains(id)) {
      _favorites.remove(id);
      _favoritesBox.delete(id); // удаляем из Hive
    } else {
      _favorites.add(id);
      _favoritesBox.put(id, id); // сохраняем в Hive
    }
    notifyListeners();
  }

  bool isFavorite(int id) => _favorites.contains(id);
}
