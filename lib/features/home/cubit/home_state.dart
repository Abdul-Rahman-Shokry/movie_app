import '../models/home_data.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final HomeData homeData;

  HomeLoaded({required this.homeData});
}

class HomeError extends HomeState {
  final String message;

  HomeError({required this.message});
}
