import 'package:food_store_backend/app/http/controllers/category_controller.dart';
import 'package:food_store_backend/app/http/middleware/admin_middleware.dart';
import 'package:food_store_backend/app/http/middleware/authenticate.dart';
import 'package:vania/vania.dart';

class CategoryApiRoute extends Route {
  @override
  void register() {
    /// Base prefix
    Router.basePrefix("api/v1");

    Router.get("categories", categoryController.showAll);
    Router.group(
      () {
        Router.post("", categoryController.create);
        Router.put("{id}", categoryController.update);
        Router.delete("{id}", categoryController.destroy);
      },
      prefix: "categories",
      middleware: [AuthenticateMiddleware(), AdminMiddleware()],
    );
  }
}
