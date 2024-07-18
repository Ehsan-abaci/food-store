import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:food_store/src/core/utils/resources/color_manager.dart';
import 'package:food_store/src/views/food_view/food_page.dart';
import 'package:food_store/src/views/home_view/home_page.dart';

class ListFoodItem extends StatelessWidget {
  ListFoodItem({
    super.key,
    required this.foodItem,
  });
  final FoodItem foodItem;
  final uKey = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => FoodPage(foodItem: foodItem, key: uKey),
        ),
      ),
      child: Container(
        height: 179,
        width: 126,
        padding: const EdgeInsets.symmetric(vertical: 5),
        margin: const EdgeInsets.only(right: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Column(
          children: [
            _getFoodImg(),
            Expanded(
              child: Column(
                children: [
                  _getFoodNameContent(),
                  _getCategoryNameContent(),
                  _getPriceContent(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getFoodImg() {
    return Expanded(
      child: PhotoHero(
        tag: uKey.toString(),
        photo: foodItem.foodImg,
      ),
    );
  }

  _getFoodNameContent() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
        child: FittedBox(
          child: Text(
            maxLines: 1,
            foodItem.foodName,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  _getCategoryNameContent() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          foodItem.categoryName,
          style: TextStyle(
            color: ColorManager.ctgColor,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  _getPriceContent() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 10),
        child: Text(
          "Rs. ${foodItem.price}",
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class PhotoHero extends StatelessWidget {
  const PhotoHero({
    super.key,
    required this.tag,
    this.photo,
    this.onTap,
  });
  final String tag;
  final dynamic photo;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: photo is Uint8List
              ? Image.memory(
                  photo!,
                  fit: BoxFit.fill,
                )
              : Image.asset(
                  photo,
                  fit: BoxFit.fill,
                ),
        ),
      ),
    );
  }
}
