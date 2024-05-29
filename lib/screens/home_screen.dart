import 'package:finances/database/account_db.dart';
import 'package:finances/models/account.dart';
import 'package:finances/screens/account_form_screen.dart';
import 'package:finances/widgets/home_screen/account_card.dart';
import 'package:finances/widgets/home_screen/add_new_account_cart.dart';
import 'package:finances/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<Account> _accounts = [];

  Future<void> fetchAccounts() async {
    var accounts = await AccountDB().list();

    setState(() {
      _accounts = accounts;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAccounts();
  }

  void addNewAccountTap() async {
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AccountFormScreen(),
        ));
    fetchAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
        ),
        drawer: const AppDrawer(),
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(10),
          child: GridView.builder(
            itemCount: _accounts.length + 1,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1 / .25,
            ),
            itemBuilder: (context, index) {
              if (index < _accounts.length) {
                return AccountCard(account: _accounts[index]);
              } else {
                return AddNewAccountCart(onTap: addNewAccountTap);
              }
            },
          ),
        ));
  }
}
