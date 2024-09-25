import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:plants/business_logic/cubit/plants_cubit.dart';
import 'package:plants/constant/strings.dart';
import 'package:plants/data/models/plant.dart';
import 'package:plants/presentation/widgets/plant_item.dart';

class PlantsScreen extends StatefulWidget {
  const PlantsScreen({super.key});

  @override
  State<PlantsScreen> createState() => _PlantsScreenState();
}

class _PlantsScreenState extends State<PlantsScreen> {
  late List<Plant> allPlants;
  late List<Plant> searchedForPlants;
  bool isSearching = false;
  final searchTextController = TextEditingController();

  Widget buildSearchFeild() {
    return TextField(
      controller: searchTextController,
      cursorColor: lightGreen,
      decoration: const InputDecoration(
        hintText: "Search plant ...",
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: lightGreen,
          fontSize: 18,
        ),
      ),
      style: const TextStyle(
        color: Colors.blue,
        fontSize: 18,
      ),
      onChanged: (searchedPlant) {
        addSearchedForItem(searchedPlant);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PlantsCubit>(context).getAllPlants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkGreen,
        leading: isSearching
            ? const BackButton(
                color: lightGreen,
              )
            : Container(),
        title: isSearching ? buildSearchFeild() : buildAppBarTitle(),
        actions: buildAppBarActions(),
      ),
      body: OfflineBuilder(connectivityBuilder: (context, value, child) {
        final bool connected = value != ConnectivityResult.none;
        if (connected) {
          return buildBlocWidgte();
        } else {
          return builNoInternetWidget();
        }
      }, builder: (context) {
        return const Center(child: CircularProgressIndicator()); // Placeholder
      }),
    );
  }

  Widget builNoInternetWidget() {
    return const Center(
      child: Text(
        "Oops! It seems there's no internet connection. Please check your connection and try again. ❗🪓",
        style: TextStyle(
          fontSize: 18,
          color: darkGreen,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildBlocWidgte() {
    return BlocBuilder<PlantsCubit, PlantsState>(
      builder: (context, state) {
        if (state is PlantsLoaded) {
          allPlants = state.plants;
          return buildLoadedListWidget();
        } else {
          const Center(
            child: CircularProgressIndicator(
              color: darkGreen,
            ),
          );
        }
        //
        return Container();
      },
    );
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: darkGreen,
        child: Column(
          children: [
            buildPlantList(),
          ],
        ),
      ),
    );
  }

  Widget buildPlantList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: searchTextController.text.isEmpty
          ? allPlants.length
          : searchedForPlants.length,
      itemBuilder: (context, index) {
        return PlantItem(
          itemOfPlant: searchTextController.text.isEmpty
              ? allPlants[index]
              : searchedForPlants[index],
        );
      },
    );
  }

  void addSearchedForItem(String searchedPlant) {
    searchedForPlants = allPlants.where(
      (item) {
        return item.name
            .toLowerCase()
            .startsWith(searchedPlant.toLowerCase());
      },
    ).toList();
    setState(() {});
  }

  List<Widget> buildAppBarActions() {
    if (isSearching) {
      return [
        IconButton(
            onPressed: () {
              clearSearch();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.clear, color: lightGreen,))
      ];
    } else {
      return [
        IconButton(
            onPressed: () {
              startSearch();
            },
            icon: const Icon(Icons.search,color: lightGreen,))
      ];
    }
  }

  void startSearch() {
    // make new route and make back up buuton on app bar <-
    ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(
      onRemove: () {
        stopSearch();
      },
    ));
    setState(() {
      isSearching = true;
    });
  }

  void stopSearch() {
    clearSearch();

    setState(() {
      isSearching = false;
    });
  }

  void clearSearch() {
    setState(() {
      searchTextController.clear();
    });
  }

  Widget buildAppBarTitle() {
    return const Text(
      "Plants 🌴",
      style: TextStyle(
        color: lightGreen,
      ),
    );
  }
}
