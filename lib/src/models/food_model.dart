import 'dart:convert';
import 'dart:typed_data';

import 'package:food_store/src/models/category_model.dart';

class FoodModel {
  int id;
  CategoryModel category;
  String foodName;
  String foodPrice;
  String? foodDescription;
  Uint8List? foodImg;
  int view;
  FoodModel({
    required this.id,
    required this.category,
    required this.foodName,
    required this.foodPrice,
    required this.foodDescription,
    required this.foodImg,
    required this.view,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'category_id': category.categoryId,
      'category_name': category.categoryName,
      'food_name': foodName,
      'food_price': foodPrice,
      'food_description': foodDescription,
      'food_image': foodImg,
      'view': view,
    };
  }

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      id: map['id'] as int,
      category: CategoryModel.fromMap(map),
      foodName: map['food_name'] as String,
      foodPrice: map['food_price'] as String,
      foodDescription: map['food_description'] != null
          ? map['food_description'] as String
          : null,
      // foodImg: Uint8List(5),
      foodImg: map['food_image'] != null
          ? Uint8List.fromList(List<int>.from(json.decode(map['food_image'])))
          : null,
      view: map['view'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory FoodModel.fromJson(String source) =>
      FoodModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

/*
 "id": 5,
        "category_id": 2,
        "category_name": "Pizza",
        "food_name": "Veggie Pizza",
        "food_price": "300",
        "food_description": "A delicious food",
        "food_image": "/foods/aef4c4bd49615fee042d698a0fcc7ac2.jpg",
        "view": 5
*/