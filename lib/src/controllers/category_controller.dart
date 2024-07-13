import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:food_store/src/core/resources/data_state.dart';
import 'package:food_store/src/core/utils/resources/constant.dart';
import 'package:food_store/src/models/category_model.dart';

class CategoryController {
  final Dio _dio = Dio();

  Future<DataState<List<CategoryModel>>> getCategories() async {
    const String url = "${Constant.BASE_URL}/categories";
    try{
    final res = await _dio.get(url);
    if (res.statusCode == 200) {
      final data = res.data as List<dynamic>;
      final categories = List.generate(
        data.length,
        (i) => CategoryModel(
          categoryId: data[i]['id'],
          categoryName: data[i]['category_name'],
        ),
      );
      return DataSuccess(categories);
    } else {
      log(res.statusMessage.toString());
      return DataFailed(res.statusMessage);
    }

    }catch (e){
      log(e.toString());
      return DataFailed(e.toString());
    }
  }
}
