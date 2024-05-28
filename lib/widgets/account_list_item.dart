import 'package:finances/database/account_db.dart';
import 'package:finances/models/account.dart';
import 'package:flutter/material.dart';

class AccountListItem extends StatelessWidget {
  final Account account;
  final Function onDelete;

  const AccountListItem({
    super.key,
    required this.account,
    required this.onDelete,
  });

  void editAccount() {}

  void deleteAccount(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext builder) => AlertDialog(
        title: const Text('Remove Account'),
        content: const Text('Are you sure you want to remove this account?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              AccountDB().delete(account);
              Navigator.pop(context);
              onDelete();
            },
            child: const Text('Confirm'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          title: Text(account.name),
          subtitle: Text(
              '${account.currency} ${(account.balance / 100).toStringAsFixed(2)}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: editAccount,
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () => deleteAccount(context),
                icon: const Icon(Icons.delete),
              )
            ],
          )),
    );
  }
}
