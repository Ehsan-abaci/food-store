// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'food_bloc.dart';

abstract class FoodEvent extends Equatable {}

class GetPopularFoods extends FoodEvent {
  int id;
  GetPopularFoods({
    required this.id,
  });
  @override
  List<Object?> get props => [id];
}
