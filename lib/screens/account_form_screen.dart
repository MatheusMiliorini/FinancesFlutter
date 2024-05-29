// ignore_for_file: use_build_context_synchronously

import 'package:finances/database/account_db.dart';
import 'package:finances/models/account.dart';
import 'package:finances/widgets/currency_input.dart';
import 'package:flutter/material.dart';

class AccountFormScreen extends StatefulWidget {
  final Account? editAccount;

  const AccountFormScreen({super.key, this.editAccount});

  @override
  State<StatefulWidget> createState() => _AccountFormScreenState();
}

class _AccountFormScreenState extends State<AccountFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form Controllers
  final _accountNameController = TextEditingController();
  int _balance = 0;
  final _currencyController = TextEditingController(text: 'EUR');

  @override
  void initState() {
    super.initState();

    if (widget.editAccount != null) {
      _accountNameController.text = widget.editAccount!.name;
      _balance = widget.editAccount!.balance;
      _currencyController.text = widget.editAccount!.currency;
    }
  }

  @override
  void dispose() {
    _accountNameController.dispose();
    _currencyController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text(widget.editAccount == null ? 'New Account' : 'Edit Account'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  autofocus: true,
                  controller: _accountNameController,
                  decoration: const InputDecoration(
                    labelText: 'Account Name',
                  ),
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the account name';
                    }
                    return null;
                  },
                ),
                CurrencyInputField(
                  onChange: (value) => setState(() {
                    _balance = int.parse(value.replaceAll('.', ''));
                  }),
                  label: 'Current Balance',
                  enabled: widget.editAccount == null,
                  initialValue: ((widget.editAccount?.balance ?? 0) / 100)
                      .toStringAsFixed(2),
                ),
                TextFormField(
                  controller: _currencyController,
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
                      if (_formKey.currentState!.validate()) {
                        if (widget.editAccount == null) {
                          Account account = Account(
                              null,
                              _accountNameController.text,
                              _balance,
                              _balance,
                              _currencyController.text);
                          account.id = await AccountDB().create(account);
                          if (account.id != null) {
                            Navigator.pop(context);
                          }
                          return;
                        }
                        final editAccount = widget.editAccount;
                        editAccount!.name = _accountNameController.text;
                        editAccount.currency = _currencyController.text;
                        await AccountDB().update(editAccount);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Submit'),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
