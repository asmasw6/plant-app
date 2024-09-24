import 'package:bloc/bloc.dart';
import 'package:charchters/data/models/charachter.dart';
import 'package:charchters/data/repositories/characters_repository.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  List<Charachter> characters = [];

  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  List<Charachter> getAllCharrachters(){
    charactersRepository.getAllCharrachters().then((characters) {
      emit(CharactersLoaded(characters)); // انبعاث
      // as say please start
      this.characters = characters;
      
    },);

    return  characters ;
    }
}
