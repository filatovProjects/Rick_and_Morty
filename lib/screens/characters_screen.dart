import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/character_provider.dart';
import '../widgets/character_card.dart';


class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  @override
  void initState() {
    super.initState();

   Future.microtask(
       () => context.read<CharacterProvider>().loadCharacters(),
   );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CharacterProvider>();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters'),
        centerTitle: true,
      ),

      body: provider.isLoading && provider.characters.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
          itemCount: provider.characters.length,
          itemBuilder: (context, index) {
            final character = provider.characters[index];
            return CharacterCard(character: character);
          }
      )
    );
  }
}
