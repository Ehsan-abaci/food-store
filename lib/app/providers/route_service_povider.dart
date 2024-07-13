import 'package:food_store_backend/route/auth_api_route.dart';
import 'package:food_store_backend/route/category_api_route.dart';
import 'package:food_store_backend/route/food_api_route.dart';
import 'package:vania/vania.dart';
import 'package:food_store_backend/route/web.dart';
import 'package:food_store_backend/route/web_socket.dart';

class RouteServiceProvider extends ServiceProvider {
  @override
  Future<void> boot() async {}

  @override
  Future<void> register() async {
    WebRoute().register();
    AuthApiRoute().register();
    CategoryApiRoute().register();
    FoodApiRoute().register();
    WebSocketRoute().register();
  }
}
