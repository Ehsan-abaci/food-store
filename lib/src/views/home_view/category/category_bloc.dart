import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_store/src/controllers/category_controller.dart';
import 'package:food_store/src/core/resources/data_state.dart';


import '../../../models/category_model.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryController _categoryController;
  CategoryBloc(this._categoryController) : super(CategoryInitial()) {
    on<GetCategories>((event, emit) async {
      emit(CategoryLoading());
      final dataState = await _categoryController.getCategories();
      if (dataState is DataSuccess) {
        emit(
          CategoryComplete(categories: dataState.data ?? []),
        );
      } else {
        emit(CategoryError());
      }
    });
  }
}
