import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_store/src/core/utils/resources/assets_manager.dart';
import 'package:food_store/src/core/utils/resources/color_manager.dart';
import 'package:food_store/src/views/home_view/home_page.dart';
import 'package:food_store/src/views/home_view/list_food_item.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key, required this.foodItem});
  final FoodItem foodItem;
  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  int selected = 0;
  bool readMore = false;
  bool isAddedToCart = false;
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height;
    final w = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: ColorManager.bgColor,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: h * .55,
            child: Stack(
              children: [
                _getClippedBackground(),
                _getFoodImage(),
                _getAppbar(),
              ],
            ),
          ),
          _getFoodDetailContent(),
          _getTabBarContent(h, w),
          _getDescriptionContent(h, w),
          _getAddToCartButton(h, w),
        ],
      ),
    );
  }

  _getAddToCartButton(double h, double w) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 25, bottom: 10),
      child: Stack(
        children: [
          Positioned(
            child: Visibility(
              visible: isAddedToCart,
              child: AnimatedContainer(
                  alignment: Alignment.center,
                  duration: const Duration(milliseconds: 400),
                  width: isAddedToCart ? w * .4 : 0,
                  height: h * .075,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: ColorManager.primary,
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                          shape: const CircleBorder(),
                        ),
                        child: const Text("-"),
                      ),
                      const Text(
                        "1",
                        style: TextStyle(fontSize: 26),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: ColorManager.primary,
                          textStyle: const TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                          foregroundColor: Colors.white,
                          shape: const CircleBorder(),
                        ),
                        child: const Text("+"),
                      ),
                    ],
                  )),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isAddedToCart = !isAddedToCart;
                });
              },
              child: AnimatedContainer(
                alignment: Alignment.center,
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                duration: const Duration(milliseconds: 300),
                width: isAddedToCart ? w * .5 : w,
                height: h * .075,
                decoration: BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  "Add to cart",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getDescriptionContent(double h, double w) {
    const String desc =
        "Lorem ipsum dolor sit amet consectetur adipisicing elit. Omnis sequi pariatur alias. Ad, minima? Praesentium, quasi. Nobis reprehenderit voluptas sunt, doloremque, laudantium optio veniam placeat quo voluptates ipsum repellat iure aut illum excepturi! Reprehenderit, dolorum. Iste ut dolore facilis earum explicabo consequuntur, labore nihil iure eos, ratione sequi voluptates blanditiis nemo voluptatum at modi, inventore eaque culpa alias quaerat quam! Hic harum accusamus modi autem adipisci magni sit ad iure temporibus natus molestias, in voluptatem, iusto commodi voluptate maiores, optio esse ipsum. Asperiores vitae voluptatibus repellat harum consectetur! Id quia excepturi magnam numquam maiores, voluptatem quisquam illo? Ut, eius ipsum!";
    String shortedDesc = "";
    int c = 0;
    for (var s in desc.split(" ")) {
      if (c > 27) break;
      shortedDesc += "$s ";
      c++;
    }
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
      child: GestureDetector(
        onTap: () {
          setState(() {
            readMore = !readMore;
          });
        },
        child: RichText(
          text: TextSpan(
            text: readMore ? desc : shortedDesc,
            children: [
              TextSpan(
                text: readMore ? " less" : " more",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: ColorManager.primary,
                ),
              ),
            ],
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              height: 1.3,
            ),
          ),
        ),
      ),
    );
  }

  _getTabBarContent(double h, double w) {
    final categories = <String>["Details", "Review"];

    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
      child: SizedBox(
        height: 45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
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
            SvgPicture.asset(
              AssetsIcon.like,
              fit: BoxFit.scaleDown,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  _getFoodDetailContent() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _getFoodName(),
          _getFoodCost(),
        ],
      ),
    );
  }

  _getFoodCost() {
    return Text(
      "Rs. ${widget.foodItem.price}",
      style: TextStyle(
        color: ColorManager.primary,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  _getFoodName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.foodItem.foodName,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          widget.foodItem.categoryName,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }

  Positioned _getAppbar() {
    return Positioned(
      top: 50,
      left: 20,
      right: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: const ShapeDecoration(
              color: Colors.white,
              shape: CircleBorder(),
            ),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: SvgPicture.asset(
                AssetsIcon.back,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          SvgPicture.asset(AssetsIcon.more),
        ],
      ),
    );
  }

  Positioned _getFoodImage() {
    return Positioned(
      top: 150,
      left: 0,
      right: 0,
      height: 300,
      child: PhotoHero(
        tag: widget.key.toString(),
        photo: widget.foodItem.foodImg,
      ),
    );
  }

  Positioned _getClippedBackground() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        width: double.infinity,
        height: 400,
        decoration: BoxDecoration(
          color: ColorManager.primary,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(200),
            bottomLeft: Radius.circular(200),
          ),
        ),
      ),
    );
  }
}
