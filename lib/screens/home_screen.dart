import 'package:finances/database/account_db.dart';
import 'package:finances/models/account.dart';
import 'package:finances/screens/account_form_screen.dart';
import 'package:finances/widgets/home_screen/account_card.dart';
import 'package:finances/widgets/home_screen/add_new_account_cart.dart';
import 'package:finances/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Account> _accounts = [];
  Map<String, int> _currencyBalance = {};

  Future<void> fetchAccounts() async {
    var accounts = await AccountDB().list();
    var currencyBalance = await AccountDB().balanceByCurrency();

    setState(() {
      _accounts = accounts;
      _currencyBalance = currencyBalance;
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
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ACCOUNTS',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: _accounts.length + 1,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3,
                  ),
                  itemBuilder: (context, index) {
                    if (index < _accounts.length) {
                      return AccountCard(account: _accounts[index]);
                    } else {
                      return AddNewAccountCart(onTap: addNewAccountTap);
                    }
                  },
                ),
              ),
              const Text(
                'TOTAL BALANCE BY CURRENCY',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: _currencyBalance.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1 / .05,
                  ),
                  itemBuilder: (context, index) {
                    final String currency =
                        _currencyBalance.keys.elementAt(index);

                    final NumberFormat numberFormat = NumberFormat.currency(
                      name: currency,
                      decimalDigits: 2,
                      symbol: '',
                    );

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(currency),
                          Text(numberFormat
                              .format(_currencyBalance[currency]! / 100)),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}
