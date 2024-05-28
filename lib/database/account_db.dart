import 'package:finances/database/database_helper.dart';
import 'package:finances/models/account.dart';

class AccountDB extends DatabaseHelper {
  final String tableName = 'accounts';

  Future<int> create(Account account) async {
    final db = await database;
    return await db.insert(tableName, account.toMap());
  }

  Future<List<Account>> list() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'deleted = false',
    );
    return List.generate(
        maps.length,
        (i) => Account(
              maps[i]['id'],
              maps[i]['name'],
              maps[i]['initialBalance'],
              maps[i]['balance'],
              maps[i]['currency'],
            ));
  }

  Future<int> delete(Account account) async {
    final db = await database;
    return await db.update(
      tableName,
      {'deleted': true},
      where: 'id = ?',
      whereArgs: [account.id],
    );
  }
}
