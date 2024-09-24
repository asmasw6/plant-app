// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:charchters/business_logic/cubit/characters_cubit.dart';
import 'package:flutter/material.dart';

import 'package:charchters/data/models/charachter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersDetails extends StatelessWidget {
  final Charachter character;
  const CharactersDetails({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //BlocProvider.of<CharactersCubit>(context).getAllCharrachters();
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          //Sliver List is responsiple for get details of plant Image
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    plantInfo("Scientific Name: ",
                        character.scientificName.join(" | ")),
                    buildDivider(220),
                    plantInfo("Cycle: ", character.cycle),
                    buildDivider(300),
                    plantInfo("Watering: ", character.watering),
                    buildDivider(275),
                    plantInfo("Sunlight: ", character.sunlight.join(" | ")),
                    buildDivider(275),
                    SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<CharactersCubit, CharactersState>(
                      builder: (context, state) {
                        return checkIfIsLoaded(state);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 200,
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget checkIfIsLoaded(CharactersState state) {
    if (state is CharactersLoaded) {
      return displayTextAnimated(state);
    } else {
      return Center(
        child: CircularProgressIndicator(
          color: Colors.green,
        ),
      );
    }
  }

  Widget displayTextAnimated(CharactersState state) {
  if (state is CharactersLoaded) {
    var text = state.characters;

    // Find the item with the matching id
    Charachter? foundCharacter = text.firstWhere(
      (item) => item.Id == character.Id,
      //orElse: () => null, // Return null if no match is found
    );

    if (foundCharacter != null) {
      return Center(
        child: DefaultTextStyle(
          style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              shadows: [
                Shadow(
                  blurRadius: 7,
                  color: Colors.brown,
                  offset: Offset(0, 0),
                ),
              ]),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [FlickerAnimatedText(foundCharacter.name)],
          ),
        ),
      );
    } else {
      // If no character is found, return a fallback widget
      return Center(
        child: Text("not found"),
      );
    }
  } else {
    // If the state is not CharactersLoaded, return an empty container or placeholder widget
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

  Widget buildSliverAppBar() {
    return SliverAppBar(
      //title And background image
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.greenAccent,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.name,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          textAlign: TextAlign.start,
        ),
        background: Hero(
          tag: character.Id,
          child: (character.defaultImage?.originalUrl != null &&
                  character.defaultImage!.originalUrl!.isNotEmpty)
              ? Image.network(
                  character.defaultImage!.originalUrl!,
                  fit: BoxFit.cover,
                )
              : Center(
                  child: Text("Doesn't has image 🌲"),
                ),

          //Image.network(src),
        ),
      ),
    );
  }

  Widget plantInfo(String title, String value) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: title,
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        TextSpan(
          text: value,
          style: const TextStyle(
            color: Colors.green,
            fontSize: 16,
          ),
        ),
      ]),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      color: Colors.green.shade700,
      endIndent: endIndent,
      height: 30,
      thickness: 2.5,
    );
  }
}
