import 'package:charchters/business_logic/cubit/characters_cubit.dart';
import 'package:charchters/data/models/charachter.dart';
import 'package:charchters/presentation/widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharachterScreen extends StatefulWidget {
  const CharachterScreen({super.key});

  @override
  State<CharachterScreen> createState() => _CharachterScreenState();
}

class _CharachterScreenState extends State<CharachterScreen> {
  late List<Charachter> allCharrachters;
  late List<Charachter> searchedForCharacters;
  bool isSearching = false;
  final searchTextController = TextEditingController();

  Widget buildSearchFeild() {
    return TextField(
      controller: searchTextController,
      cursorColor: Colors.red,
      decoration: const InputDecoration(
        hintText: "Search character ..",
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: Colors.blue,
          fontSize: 18,
        ),
      ),
      style: const TextStyle(
        color: Colors.blue,
        fontSize: 18,
      ),
      onChanged: (searchedCharacter) {
        addSearchedForItem(searchedCharacter);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharrachters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        leading: isSearching
            ? const BackButton(
                color: Colors.black,
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
        return Center(child: CircularProgressIndicator()); // Placeholder
      }),
    );
  }

  Widget builNoInternetWidget() {
    return Center(
      child: Text(
        "Oops! It seems there's no internet connection. Please check your connection and try again.",
        style: TextStyle(
          fontSize: 18,
          color: Colors.redAccent,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildBlocWidgte() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharrachters = state.characters;
          return buildLoadedListWidget();
        } else {
          const Center(
            child: CircularProgressIndicator(
              color: Colors.indigoAccent,
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
        color: Colors.black12,
        child: Column(
          children: [
            buildCharachterList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharachterList() {
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
          ? allCharrachters.length
          : searchedForCharacters.length,
      itemBuilder: (context, index) {
        return CharacterItem(
          itemOfCharacter: searchTextController.text.isEmpty
              ? allCharrachters[index]
              : searchedForCharacters[index],
        );
      },
    );
  }

  void addSearchedForItem(String searchedCharacter) {
    searchedForCharacters = allCharrachters.where(
      (item) {
        return item.name
            .toLowerCase()
            .startsWith(searchedCharacter.toLowerCase());
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
            icon: Icon(Icons.clear))
      ];
    } else {
      return [
        IconButton(
            onPressed: () {
              startSearch();
            },
            icon: Icon(Icons.search))
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
      "Characters",
      style: TextStyle(
        color: Colors.indigoAccent,
      ),
    );
  }
}
