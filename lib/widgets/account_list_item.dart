import 'package:finances/models/account.dart';
import 'package:flutter/material.dart';

class AccountListItem extends StatelessWidget {
  final Account account;

  const AccountListItem({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(account.name),
        subtitle: Text(
            '${account.currency} ${(account.balance / 100).toStringAsFixed(2)}'),
      ),
    );
  }
}
