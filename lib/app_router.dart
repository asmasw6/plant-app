import 'package:charchters/business_logic/cubit/characters_cubit.dart';
import 'package:charchters/constant/strings.dart';
import 'package:charchters/data/models/charachter.dart';
import 'package:charchters/data/repositories/characters_repository.dart';
import 'package:charchters/data/web_services/characters_web_services.dart';
import 'package:charchters/presentation/screens/charachter_screen.dart';
import 'package:charchters/presentation/screens/characters_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepository =
        CharactersRepository(charactersWebServices: CharactersWebServices());
    charactersCubit = CharactersCubit(charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charachtersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => charactersCubit,
            child: const CharachterScreen(),
          ),
        );

      case charachtersDetails:
        final character = settings.arguments as Charachter;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => charactersCubit,
            child: CharactersDetails(
              character: character,
            ),
          ),
        );

      default:
        return null;
    }
  }
}
