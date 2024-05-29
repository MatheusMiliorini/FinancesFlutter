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

  Future<int> update(Account account) async {
    final db = await database;
    return await db.update(
      tableName,
      account.toMap(),
      where: 'id = ?',
      whereArgs: [account.id],
    );
  }

  Future<Map<String, int>> balanceByCurrency() async {
    final db = await database;
    final Map<String, int> currencySum = {};

    final List<Map<String, dynamic>> res = await db.rawQuery(
        'SELECT currency, SUM(balance) AS sumBalance FROM $tableName GROUP BY currency;');

    for (var row in res) {
      currencySum[row['currency']] = row['sumBalance'];
    }

    return currencySum;
  }
}
