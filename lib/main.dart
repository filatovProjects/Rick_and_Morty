import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/screens/home_screen.dart';

import '../providers/character_provider.dart';
import 'models/character_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CharacterAdapter());
  await Hive.openBox<Character>('characters'); // для всех персонажей
  await Hive.openBox<int>('favorites'); // для хранения ID избранных
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CharacterProvider(),
      child: MaterialApp(home: const HomeScreen()),
    );
  }
}
