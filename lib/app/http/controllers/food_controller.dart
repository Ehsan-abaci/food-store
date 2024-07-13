import 'dart:io';
import 'dart:typed_data';

import 'package:food_store_backend/app/models/food_model.dart';
import 'package:vania/vania.dart';

class FoodController extends Controller {
  //! show all
  Future<Response> showAll() async {
    final foodLST = await FoodModel()
        .query()
        .whereNull("food.deleted_at")
        .join('category as c', 'food.category_id', '=', 'c.id')
        .select([
      "food.id",
      "food.category_id",
      "c.category_name",
      "food.food_name",
      "food.food_price",
      "food.food_description",
      "food.food_image",
      "food.view",
    ]).get();
    return Response.json(foodLST);
  }

  //! Show Specific Food Of Category
  Future<Response> showSpecificFoodOfCategory(int categoryId) async {
    final foodLST = await FoodModel()
        .query()
        .whereNull("food.deleted_at")
        .join('category as c', 'food.category_id', '=', 'c.id')
        .where('category_id', '=', '$categoryId')
        .select([
      "food.id",
      "food.category_id",
      "c.category_name",
      "food.food_name",
      "food.food_price",
      "food.food_description",
      "food.food_image",
      "food.view",
    ]).get();
    return Response.json(foodLST);
  }

  Future<Response> create(Request req, int categoryId) async {
    req.validate({
      'food_name': 'required',
      'food_price': 'required',
    });

    RequestFile? img = req.file('food_image');
    String? imgPath;
    if (img != null) {
      imgPath = await img.store(path: 'foods', filename: img.filename);
    }

    await FoodModel().query().insert({
      "food_name": req.input('food_name'),
      "category_id": categoryId,
      "food_price": req.input('food_price'),
      "food_description": req.input('food_description'),
      "food_image": imgPath,
      "created_at": DateTime.now(),
      "updated_at": DateTime.now(),
    });
    return Response.json(
      {"message": "Food created successfully"},
      HttpStatus.created,
    );
  }

  Future<Response> update(Request req, int id) async {
    final food = await FoodModel()
        .query()
        .where('id', "=", "$id")
        .whereNull('deleted_at')
        .first();
    if (food == null) {
      return Response.json(
        {'message': "The food doesn't exists"},
        HttpStatus.badRequest,
      );
    }
    RequestFile? img = req.file('food_image');
    Uint8List? imgByte;
    if (img != null) {
  
      // imgPath = await img.store(path: 'foods', filename: img.filename);
      imgByte = await img.bytes;
    }
    await FoodModel()
        .query()
        .where('id', '=', "$id")
        .whereNull('deleted_at')
        .update({
      'food_name': req.input('food_name') ?? food['food_name'],
      'food_price': req.input('food_price') ?? food['food_price'],
      'food_image': imgByte ?? food['food_image'],
      'food_description':
          req.input('food_description') ?? food['food_description'],
      'updated_at': DateTime.now(),
    });
    return Response.json({
      "message": "Food updated successfully",
    });
  }

  //! popular food
  Future<Response> showPopularFood(int categoryId) async {
    if (categoryId == 0) {
      final foodLST = await FoodModel()
          .query()
          .whereNull("food.deleted_at")
          .join('category as c', 'food.category_id', '=', 'c.id')
          .orderBy('view', 'desc')
          .select([
        "food.id",
        "food.category_id",
        "c.category_name",
        "food.food_name",
        "food.food_price",
        "food.food_description",
        "food.food_image",
        "food.view",
      ]).get();
      return Response.json(foodLST);
    }
    final foodLST = await FoodModel()
        .query()
        .whereNull("food.deleted_at")
        .join('category as c', 'food.category_id', '=', 'c.id')
        .where('category_id', '=', '$categoryId')
        .orderBy('view', 'desc')
        .select([
      "food.id",
      "food.category_id",
      "c.category_name",
      "food.food_name",
      "food.food_price",
      "food.food_description",
      "food.food_image",
      "food.view",
    ]).get();
    return Response.json(foodLST);
  }

//! Increse view
  Future<Response> increseView(int id) async {
    final currentView =
        (await FoodModel().query().where('id', '=', id).first())?['view'];

    await FoodModel().query().where('id', '=', id).update({
      "view": currentView + 1,
    });
    return Response.json({
      "message": "Food view updated successfully",
    });
  }

  Future<Response> destroy(int id) async {
    await FoodModel().query().where('id', '=', id).update({
      'deleted_at': DateTime.now(),
    });
    return Response.json({
      'message': 'Food deleted successfully',
    });
  }
}

final FoodController foodController = FoodController();
