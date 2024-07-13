import 'package:vania/vania.dart';

class CreateUserTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('users', () {
      id();
      string("user_name", nullable: false);
      string("email", nullable: false);
      string("password", nullable: false);
      string("avatar", nullable: true);
      tinyInt("is_admin", defaultValue: 0);

      timeStamp("created_at", nullable: true);
      timeStamp("updated_at", nullable: true);
      timeStamp("deleted_at", nullable: true);

      // index(ColumnIndex.unique, 'email', ['email']);
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('users');
  }
}
