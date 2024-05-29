import 'package:finances/models/account.dart';
import 'package:flutter/material.dart';

class AccountCard extends StatelessWidget {
  final Account account;

  const AccountCard({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
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
                  '${(account.balance / 100).toStringAsFixed(2)} ${account.currency}')
            ],
          ),
        ));
  }
}
