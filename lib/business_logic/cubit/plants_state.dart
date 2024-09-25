part of 'plants_cubit.dart';

@immutable
sealed class PlantsState {}

final class PlantsInitial extends PlantsState {}
final class PlantsLoaded extends PlantsState {
late final List<Plant> plants;

  PlantsLoaded(this.plants);

}

final class PlantsFailure extends PlantsState {}


// for each moduel I make it cubit
// each moduel has state and each state may have meany states