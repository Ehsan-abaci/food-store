import 'package:food_store_backend/app/models/user.dart';
import 'package:vania/vania.dart';

class AdminMiddleware extends Middleware {
  @override
  handle(Request req) async {
    final isAdmin = await User()
        .query()
        .where('id', '=', Auth().id())
        .whereNull("deleted_at")
        .select(['is_admin']).first();

    if (isAdmin?['is_admin'] == 0) {
      return abort(403, 'You are not an admin');
    }
    next?.handle(req);
  }
}
