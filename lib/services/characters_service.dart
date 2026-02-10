import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty/models/character_model.dart';

class CharacterApiService {
  static const url = 'https://rickandmortyapi.com/api/character';

  Future<List<Character>> fetchCharacters({int page = 1}) async {
    final response = await http.get(Uri.parse('$url?page=$page'));

    if (response.statusCode != 200) {
      throw Exception('Ошибка загрузки персонажа');
    }

    final data = json.decode(response.body);
    final results = data['results'] as List;

    return results.map((e) => Character.fromJson(e)).toList();

  }
}