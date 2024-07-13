import 'package:vania/vania.dart';

class CreateFoodTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('food', () {
      id();
      string('food_name', nullable: false);
      bigInt('category_id', unsigned: true, nullable: false);
      string('food_description', nullable: true);
      string('food_image', nullable: true);
      string('food_price', nullable: false);
      bigInt('view', nullable: false);

      timeStamp("created_at", nullable: true);
      timeStamp("updated_at", nullable: true);
      timeStamp("deleted_at", nullable: true);

      foreign('category_id', 'category', 'id',
          onDelete: 'CASCADE', onUpdate: 'CASCADE');
    });
  }

  @override
  Future<void> down() async {
    super.down();

    await dropIfExists('food');
  }
}
