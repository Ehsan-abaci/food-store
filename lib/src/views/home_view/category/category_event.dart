part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {}

class GetCategories extends CategoryEvent {
  @override
  List<Object?> get props => [];
}
