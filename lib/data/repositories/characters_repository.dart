import 'package:charchters/data/models/charachter.dart';
import 'package:charchters/data/web_services/characters_web_services.dart';

class CharactersRepository {
  final CharactersWebServices charactersWebServices;

  CharactersRepository({required this.charactersWebServices});

  Future<List<Charachter>> getAllCharrachters() async {
    final characters = await charactersWebServices.getAllCharrachters();
    return characters.map(
      (charachter) {
       return Charachter.fromJson(charachter);
      },
    ).toList();
  }
}

// data >> from db >> then web services >> reposity>> bloc/cubit >> UI
