// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class CategoryModel {
  int categoryId;
  String categoryName;

  CategoryModel({
    required this.categoryId,
    required this.categoryName,
  });

  

  CategoryModel copyWith({
    int? categoryId,
    String? categoryName,
  }) {
    return CategoryModel(
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category_id': categoryId,
      'category_name': categoryName,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryId: map['category_id'] as int,
      categoryName: map['category_name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) => CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
