import 'package:finances/database/account_db.dart';
import 'package:finances/models/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AccountFormScreen extends StatelessWidget {
  const AccountFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Account Form'),
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: AccountForm(),
        ));
  }
}

class AccountForm extends StatefulWidget {
  const AccountForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return AccountFormState();
  }
}

class AccountFormState extends State<AccountForm> {
  final formKey = GlobalKey<FormState>();

  // Form Controllers
  final accountNameController = TextEditingController();
  final balanceController = TextEditingController();
  final currencyController = TextEditingController(text: 'EUR');

  @override
  void dispose() {
    accountNameController.dispose();
    balanceController.dispose();
    currencyController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: accountNameController,
            decoration: const InputDecoration(
              labelText: 'Account Name',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the account name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: balanceController,
            decoration: const InputDecoration(
              labelText: 'Current Balance',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the current balance';
              }
              return null;
            },
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
          TextFormField(
            controller: currencyController,
            decoration: const InputDecoration(
              labelText: 'Currency',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the currency';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  Account account = Account(
                      null,
                      accountNameController.text,
                      int.parse(balanceController.text),
                      int.parse(balanceController.text),
                      currencyController.text);
                  AccountDB().create(account);
                }
              },
              child: const Text('Submit'),
            ),
          )
        ],
      ),
    );
  }
}
