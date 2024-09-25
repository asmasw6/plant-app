// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants/business_logic/cubit/plants_cubit.dart';
import 'package:plants/constant/strings.dart';
import 'package:plants/data/models/plant.dart';

class PlantsDetails extends StatelessWidget {
  final Plant plant;
  const PlantsDetails({
    Key? key,
    required this.plant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //BlocProvider.of<PlantsCubit>(context).getAllCharrachters();
    return Scaffold(
      backgroundColor: green,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          //Sliver List is responsiple for get details of plant Image
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    plantInfo(
                        "Scientific Name: ", plant.scientificName.join(" | ")),
                    buildDivider(220),
                    plantInfo("Cycle: ", plant.cycle),
                    buildDivider(300),
                    plantInfo("Watering: ", plant.watering),
                    buildDivider(275),
                    plantInfo("Sunlight: ", plant.sunlight.join(" | ")),
                    buildDivider(275),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<PlantsCubit, PlantsState>(
                      builder: (context, state) {
                        return checkIfIsLoaded(state);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 200,
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget checkIfIsLoaded(PlantsState state) {
    if (state is PlantsLoaded) {
      return displayTextAnimated(state);
    } else {
      return const Center(
        child: CircularProgressIndicator(
          color: darkGreen,
        ),
      );
    }
  }

  Widget displayTextAnimated(PlantsState state) {
    if (state is PlantsLoaded) {
      var text = state.plants;

      // Find the item with the matching id
      Plant? foundPlant = text.firstWhere(
        (item) => item.Id == plant.Id,
        //orElse: () => null, // Return null if no match is found
      );

      if (foundPlant != null) {
        return Center(
          child: DefaultTextStyle(
            style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: darkGreen, shadows: [
              Shadow(
                blurRadius: 7,
                color: Colors.orangeAccent,
                offset: Offset(0, 0),
              ),
            ]),
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [FlickerAnimatedText(foundPlant.name)],
            ),
          ),
        );
      } else {
        // If no palnt is found, return a fallback widget
        return const Center(
          child: Text("not found"),
        );
      }
    } else {
      // If the state is not PlantsLoaded, return an empty container or placeholder widget
      return const Center(
        child: CircularProgressIndicator(
          color: darkGreen,
        ),
      );
    }
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      //title And background image
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: lightGreen,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Container(
          color: green, // Black shade with 50% opacity
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Text(
            plant.name,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: darkGreen,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        background: Hero(
          tag: plant.Id,
          child: (plant.defaultImage?.originalUrl != null &&
                  plant.defaultImage!.originalUrl!.isNotEmpty)
              ? Image.network(
                  plant.defaultImage!.originalUrl!,
                  fit: BoxFit.cover,
                )
              : const Center(
                  child: Text("Doesn't has image 🌲"),
                ),
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
            color: darkGreen,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        TextSpan(
          text: value,
          style: const TextStyle(
            color: darkGreen,
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
      color: Colors.green.shade900,
      endIndent: endIndent,
      height: 30,
      thickness: 2.5,
    );
  }
}
