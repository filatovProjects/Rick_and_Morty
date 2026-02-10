import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/character_model.dart';
import '../providers/character_provider.dart';

class CharacterCard extends StatelessWidget {
  final Character character;

  const CharacterCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CharacterProvider>();
    final isFavorite = provider.isFavorite(character.id);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(character.image)),
        title: Text(character.name),
        subtitle: Text('${character.status} - ${character.species}'),
        trailing: IconButton(
          icon: Icon(
            isFavorite ? Icons.star : Icons.star_border,
            color: isFavorite ? Colors.amber : Colors.grey,
          ),
          onPressed: () {
            provider.toggleFavorite(character.id);
          },
        ),
      ),
    );
  }
}
