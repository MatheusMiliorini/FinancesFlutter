import 'package:finances/database/database_helper.dart';
import 'package:finances/models/account.dart';

class AccountDB extends DatabaseHelper {
  final String tableName = 'accounts';

  Future<int> create(Account account) async {
    final db = await database;
    return await db.insert(tableName, account.toMap());
  }

  // Future<void> list() async {
  //   final db = await database;
  // }
}
