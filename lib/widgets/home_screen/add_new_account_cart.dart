import 'package:flutter/material.dart';

class AddNewAccountCart extends StatelessWidget {
  final VoidCallback onTap;

  const AddNewAccountCart({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: const Card(
          shape: BeveledRectangleBorder(),
          elevation: 2.0,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Create New'),
                  Icon(Icons.add),
                ],
              )),
        ));
  }
}
