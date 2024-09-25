
import 'package:plants/data/models/plant.dart';
import 'package:plants/data/web_services/plants_web_services.dart';

class PlantsRepository {
  final PlantsWebServices plantsWebServices;

  PlantsRepository({required this.plantsWebServices});

  Future<List<Plant>> getAllPlants() async {
    final plants = await plantsWebServices.getAllPlants();
    return plants.map(
      (plant) {
       return Plant.fromJson(plant);
      },
    ).toList();
  }
}

// data >> from db >> then web services >> reposity>> bloc/cubit >> UI
