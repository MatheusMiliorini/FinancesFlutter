import 'package:flutter/material.dart';

class AddNewAccountCart extends StatelessWidget {
  final VoidCallback onTap;

  const AddNewAccountCart({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: const Card(
          shape: BeveledRectangleBorder(),
          color: Colors.blueAccent,
          elevation: 2.0,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Create New',
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ],
              )),
        ));
  }
}
