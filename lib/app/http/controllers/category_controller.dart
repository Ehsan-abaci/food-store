import 'dart:io';

import 'package:food_store_backend/app/models/category_model.dart';
import 'package:vania/vania.dart';

class CategoryController extends Controller {
  //! create category
  Future<Response> create(Request req) async {
    req.validate({'name': 'required'});

    await CategoryModel().query().insert({
      "category_name": req.input('name'),
      "created_at": DateTime.now(),
      "updated_at": DateTime.now(),
    });
    return Response.json(
      {"message": "Category created successfully"},
      HttpStatus.created,
    );
  }

  //! show all
  Future<Response> showAll() async {
    final categoryLST = await CategoryModel()
        .query()
        .whereNull("deleted_at")
        .select(['id', 'category_name']).get();
    return Response.json(categoryLST);
  }

  //! update
  Future<Response> update(Request request, int id) async {
    final singleCategory = await CategoryModel()
        .query()
        .where("id", "=", id)
        .whereNull("deleted_at")
        .first();
    if (singleCategory == null) {
      return Response.json(
          {"message": "category not found"}, HttpStatus.notFound);
    }
    await CategoryModel()
        .query()
        .where("id", "=", id)
        .whereNull("deleted_at")
        .update({
      "category_name": request.input('name') ?? singleCategory['category_name'],
      "updated_at": DateTime.now(),
    });
    return Response.json({"message": "Category updated successfully"});
  }

//! delete category
  Future<Response> destroy(int id) async {
    final category = await CategoryModel()
        .query()
        .where('id', '=', id)
        .whereNull("deleted_at")
        .first();
    if (category == null) {
      return Response.json({
        "message": "Category not found",
      }, HttpStatus.notFound);
    }
    await CategoryModel()
        .query()
        .where('id', '=', id)
        .whereNull("deleted_at")
        .delete();
    return Response.json({
      "message": "Category deleted successfully",
    });
  }
}

final CategoryController categoryController = CategoryController();
