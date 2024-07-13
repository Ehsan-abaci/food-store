import 'package:food_store_backend/app/http/controllers/food_controller.dart';
import 'package:food_store_backend/app/http/middleware/admin_middleware.dart';
import 'package:food_store_backend/app/http/middleware/authenticate.dart';
import 'package:vania/vania.dart';

class FoodApiRoute extends Route {
  @override
  void register() {
    /// Base prefix
    Router.basePrefix("api/v1");

    Router.get("foods", foodController.showAll);
    Router.get("foods/popular/{categoryId}", foodController.showPopularFood);
    Router.get("categories/{categoryId}/foods",
        foodController.showSpecificFoodOfCategory);
    Router.put("foods/increase_view/{id}", foodController.increseView);
    Router.group(
      () {
        Router.post("{categoryId}", foodController.create);
        Router.put("{id}", foodController.update);
        Router.delete("{id}", foodController.destroy);
      },
      prefix: "foods",
      middleware: [AuthenticateMiddleware(), AdminMiddleware()],
    );
  }
}
