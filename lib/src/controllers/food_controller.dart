import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:food_store/src/core/resources/data_state.dart';
import 'package:food_store/src/core/utils/resources/constant.dart';
import 'package:food_store/src/models/food_model.dart';

class FoodController {
  final Dio _dio = Dio();
  Future<DataState<List<FoodModel>>> getPopularFoods(int id) async {
    String url = "${Constant.BASE_URL}/foods/popular/$id";
    try {
      final res = await _dio.get(url);
      if (res.statusCode == 200) {
        log(res.data.toString());
        final data = res.data as List<dynamic>;
        final foods = List.generate(
          data.length,
          (i) => FoodModel.fromMap(data[i]),
        );
        return DataSuccess(foods);
      } else {
        log(res.statusMessage.toString());
        return DataFailed(res.statusMessage);
      }
    } catch (e) {
      log(e.toString());
      return DataFailed(e.toString());
    }
  }
}
