import 'package:food_store_backend/app/http/controllers/user_controller.dart';
import 'package:food_store_backend/app/http/middleware/authenticate.dart';
import 'package:vania/vania.dart';

class AuthApiRoute implements Route {
  @override
  void register() {
    /// Base RoutePrefix
    Router.basePrefix('api/v1');

    Router.post('signup', userController.register);
    Router.post('admin/signup', userController.registerAdmin);
    Router.post('login', userController.login);
    Router.group(
      () {
        Router.get('info', userController.show);
        Router.put('update', userController.update);
        Router.delete('delete', userController.destroy);
      },
      prefix: 'user',
      middleware: [AuthenticateMiddleware()],
    );
  }
}
