import 'package:finances/models/account.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AccountCard extends StatelessWidget {
  final Account account;

  const AccountCard({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat.currency(
      name: account.currency,
      symbol: '',
    );
    return Card(
        shape: const BeveledRectangleBorder(),
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(account.name),
              Text(
                  '${account.currency} ${numberFormat.format(account.balance / 100)}'),
            ],
          ),
        ));
  }
}
