import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_store/src/controllers/food_controller.dart';
import 'package:food_store/src/core/resources/data_state.dart';
import 'package:food_store/src/models/food_model.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final FoodController _foodController;
  FoodBloc(this._foodController) : super(FoodInitial()) {
    on<GetPopularFoods>((event, emit) async {
      emit(FoodLoading());
      final dataState = await _foodController.getPopularFoods(event.id);
      if (dataState is DataSuccess) {
        emit(
          FoodComplete(
            popularFoods: dataState.data ?? [],
            nearestFoods: const [],
          ),
        );
      }
    });
  }
}
