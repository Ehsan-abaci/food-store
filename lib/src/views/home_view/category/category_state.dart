
part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {}

class CategoryInitial extends CategoryState {
  @override
  List<Object?> get props => [];
}

class CategoryComplete extends CategoryState {
  List<CategoryModel> categories;
  CategoryComplete({
    required this.categories,
  });
  @override
  List<Object?> get props => [];
}

class CategoryLoading extends CategoryState {
  @override
  List<Object?> get props => [];
}

class CategoryError extends CategoryState {
  @override
  List<Object?> get props => [];
}
