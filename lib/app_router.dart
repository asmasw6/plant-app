
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants/business_logic/cubit/plants_cubit.dart';
import 'package:plants/constant/strings.dart';
import 'package:plants/data/models/plant.dart';
import 'package:plants/data/repositories/plants_repository.dart';
import 'package:plants/data/web_services/plants_web_services.dart';
import 'package:plants/presentation/screens/plants_details_screen.dart';
import 'package:plants/presentation/screens/plants_screen.dart';

class AppRouter {
  late PlantsRepository plantsRepository;
  late PlantsCubit plantsCubit;

  AppRouter() {
    plantsRepository =
        PlantsRepository(plantsWebServices: PlantsWebServices());
    plantsCubit = PlantsCubit(plantsRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case plantsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => plantsCubit,
            child: const PlantsScreen(),
          ),
        );

      case plantsDetails:
        final plant = settings.arguments as Plant;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => plantsCubit,
            child: PlantsDetails(
              plant: plant,
            ),
          ),
        );

      default:
        return null;
    }
  }
}
