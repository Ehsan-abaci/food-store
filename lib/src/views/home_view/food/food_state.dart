
part of 'food_bloc.dart';

abstract class FoodState extends Equatable {}

class FoodInitial extends FoodState {
  @override
  List<Object?> get props => [];
}

class FoodComplete extends FoodState {
  List<FoodModel> popularFoods;
  List<FoodModel> nearestFoods;
  FoodComplete({
    required this.popularFoods,
    required this.nearestFoods,
  });
  @override
  List<Object?> get props => [];

  FoodComplete copyWith({
    List<FoodModel>? popularFoods,
    List<FoodModel>? nearestFoods,
  }) {
    return FoodComplete(
      popularFoods: popularFoods ?? this.popularFoods,
      nearestFoods: nearestFoods ?? this.nearestFoods,
    );
  }
}

class FoodLoading extends FoodState {
  @override
  List<Object?> get props => [];
}

class FoodError extends FoodState {
  @override
  List<Object?> get props => [];
}
