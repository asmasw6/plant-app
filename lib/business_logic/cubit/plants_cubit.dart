import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:plants/data/models/plant.dart';
import 'package:plants/data/repositories/plants_repository.dart';

part 'plants_state.dart';

class PlantsCubit extends Cubit<PlantsState> {
  final PlantsRepository plantsRepository;
  List<Plant> plants = [];

  PlantsCubit(this.plantsRepository) : super(PlantsInitial());

  List<Plant> getAllPlants(){
    plantsRepository.getAllPlants().then((plant) {
      emit(PlantsLoaded(plant)); // انبعاث
      // as say please start
      this.plants = plant;
      
    },);

    return  plants ;
    }
}
