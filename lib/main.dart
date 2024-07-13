import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_store/src/controllers/category_controller.dart';
import 'package:food_store/src/controllers/food_controller.dart';
import 'package:food_store/src/views/home_view/category/category_bloc.dart';
import 'package:food_store/src/views/home_view/food/food_bloc.dart';
import 'package:food_store/src/views/home_view/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CategoryBloc(CategoryController()),
        ),
           BlocProvider(
          create: (context) => FoodBloc(FoodController()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ّFood Store',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: const HomePage(),
      ),
    );
  }
}
