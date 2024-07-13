import 'package:vania/vania.dart';

class CreateCartTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('cart', () {
      id();
      bigInt('user_id', unsigned: true, nullable: false);
      bigInt('food_id', unsigned: true, nullable: false);
      bigInt('quantity', unsigned: true, nullable: false);
      timeStamp("created_at", nullable: true);
      timeStamp("updated_at", nullable: true);
      timeStamp("deleted_at", nullable: true);
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('cart');
  }
}
