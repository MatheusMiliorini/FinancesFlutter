import 'package:finances/database/account_db.dart';
import 'package:finances/models/account.dart';
import 'package:finances/screens/account_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:finances/widgets/account_list_item.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  List<Account> accountList = [];

  Future<void> fetchAccountList() async {
    final list = await AccountDB().list();

    setState(() {
      accountList = list;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAccountList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts'),
      ),
      body: accountList.isNotEmpty
          ? ListView.builder(
              itemCount: accountList.length,
              itemBuilder: (context, index) {
                return AccountListItem(
                  account: accountList[index],
                  onDeleteOrUpdate: fetchAccountList,
                );
              },
            )
          : const Center(
              child: Text('No accounts created'),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AccountFormScreen()));
          fetchAccountList();
        },
        tooltip: 'Add Account',
        child: const Icon(Icons.add),
      ),
    );
  }
}
