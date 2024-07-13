import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:food_store/src/core/utils/resources/assets_manager.dart';
import 'package:food_store/src/core/utils/resources/color_manager.dart';
import 'package:food_store/src/views/home_view/category/category_bloc.dart';
import 'package:food_store/src/views/home_view/food/food_bloc.dart';
import 'package:food_store/src/views/home_view/list_food_item.dart';

class FoodItem {
  final Uint8List? foodImg;
  final String foodName;
  final String categoryName;
  final String price;
  FoodItem({
    this.foodImg,
    required this.foodName,
    required this.categoryName,
    required this.price,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selected = 0;
  List<FoodItem> _allFoods = [];
  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(GetCategories());
    context.read<FoodBloc>().add(GetPopularFoods(id: 0));
    _allFoods = List.generate(
      3,
      (i) => FoodItem(
        // foodImg: 'assets/images/food_${i + 1}.png',
        foodName: "Humburger",
        categoryName: "burger",
        price: "200.0",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: Container(
        width: 342,
        height: 66,
        decoration: BoxDecoration(
          color: ColorManager.primary,
          borderRadius: BorderRadius.circular(60),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(AssetsIcon.home),
            SvgPicture.asset(AssetsIcon.like),
            SvgPicture.asset(AssetsIcon.shop),
            SvgPicture.asset(AssetsIcon.user),
          ],
        ),
      ),
      backgroundColor: ColorManager.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _getAppBarContent(),
              _getTitleContent(),
              _getSearchBar(),
              _getCategoryListContent(),
              _getFoodListContent("Popular Food"),
              _getFoodListContent("Nearest Food"),
              const SizedBox(height: 85),
            ],
          ),
        ),
      ),
    );
  }

  _getAppBarContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorManager.bgColor,
              image: const DecorationImage(
                image: AssetImage(
                  AssetsImage.profile,
                ),
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          SvgPicture.asset(AssetsIcon.bell),
        ],
      ),
    );
  }

  _getTitleContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Align(
        alignment: Alignment.centerLeft,
        child: RichText(
          text: TextSpan(
            text: "Choose \n",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
            children: [
              const TextSpan(
                text: "Your Favorite ",
              ),
              TextSpan(
                text: "Food",
                style: TextStyle(
                  color: ColorManager.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.zero,
              margin: const EdgeInsets.only(right: 10),
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "search",
                  prefixIcon: Icon(CupertinoIcons.search),
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            width: 59,
            decoration: BoxDecoration(
              color: ColorManager.primary,
              borderRadius: BorderRadius.circular(46),
            ),
            child: SvgPicture.asset(
              AssetsIcon.settingIcon,
              fit: BoxFit.scaleDown,
            ),
          ),
        ],
      ),
    );
  }

  _getCategoryListContent() {
    var categories = <String>["All"];

    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryComplete) {
          for (var ct in state.categories) {
            categories.add(ct.categoryName);
          }
        }
        return Padding(
          padding: const EdgeInsets.only(left: 20, top: 24),
          child: SizedBox(
            height: 45,
            child: ListView.builder(
              itemCount: categories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) => Padding(
                padding: const EdgeInsets.only(right: 17),
                child: GestureDetector(
                  onTap: () => setState(() {
                    selected = i;
                  }),
                  child: Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color:
                          i == selected ? ColorManager.primary : Colors.white,
                      borderRadius: BorderRadius.circular(34),
                    ),
                    child: Text(
                      categories[i],
                      style: TextStyle(
                          fontSize: 14,
                          color: i == selected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _getFoodListContent(String categoryName) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                categoryName,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "See All",
                  style: TextStyle(
                    color: ColorManager.primary,
                  ),
                ),
              )
            ],
          ),
        ),
        BlocBuilder<FoodBloc, FoodState>(
          builder: (context, state) {
            _allFoods.clear();
            if (state is FoodComplete) {
              for (var f in state.popularFoods) {
                _allFoods.add(FoodItem(
                  foodImg: f.foodImg,
                  foodName: f.foodName,
                  categoryName: f.category.categoryName,
                  price: f.foodPrice.toString(),
                ));
              }
            }
            return SizedBox(
              height: 179,
              width: MediaQuery.sizeOf(context).width,
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: 20),
                scrollDirection: Axis.horizontal,
                physics: AlwaysScrollableScrollPhysics(),
                children: [
                  ..._allFoods.map(
                    (e) => ListFoodItem(
                      foodItem: e,
                    ),
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
