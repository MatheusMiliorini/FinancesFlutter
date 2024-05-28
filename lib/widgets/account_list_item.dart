import 'package:finances/database/account_db.dart';
import 'package:finances/models/account.dart';
import 'package:finances/screens/account_form_screen.dart';
import 'package:flutter/material.dart';

class AccountListItem extends StatelessWidget {
  final Account account;
  final Function onDeleteOrUpdate;

  const AccountListItem({
    super.key,
    required this.account,
    required this.onDeleteOrUpdate,
  });

  Future<void> editAccount(BuildContext context) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AccountFormScreen(editAccount: account)));
    onDeleteOrUpdate();
  }

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
              onDeleteOrUpdate();
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
                onPressed: () => editAccount(context),
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
