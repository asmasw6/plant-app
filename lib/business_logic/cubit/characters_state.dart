part of 'characters_cubit.dart';

@immutable
sealed class CharactersState {}

final class CharactersInitial extends CharactersState {}
final class CharactersLoaded extends CharactersState {
late final List<Charachter> characters;

  CharactersLoaded(this.characters);

}

final class CharactersFailure extends CharactersState {}


// for each moduel I make it cubit
// each moduel has state and each state may have meany states