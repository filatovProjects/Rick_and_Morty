import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/providers/character_provider.dart';
import 'package:rick_and_morty/widgets/character_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CharacterProvider>();
    final favorites = provider.favoriteCharacters;
    favorites.sort((a,b) => a.name.compareTo(b.name));

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites'), centerTitle: true),

      body: favorites.isEmpty
          ? const Center(child: Text('No favorites yet'))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return CharacterCard(character: favorites[index]);
              },
            ),
    );
  }
}
