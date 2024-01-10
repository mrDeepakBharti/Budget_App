import 'package:flutter/material.dart';

class UserBudget extends StatefulWidget {
  const UserBudget({Key? key}) : super(key: key);

  @override
  State<UserBudget> createState() => _UserBudgetState();
}

class _UserBudgetState extends State<UserBudget> {
  String? valueChoose;
  List options = [
    "10,000 \u20B9",
    "20,000 \u20B9",
    "30,000 \u20B9",
    "40,000 \u20B9",
    "50,000 \u20B9",
    "60,000 \u20B9",
    "70,000 \u20B9",
    "80,000 \u20B9",
    "90,000 \u20B9",
    "1,00,000 \u20B9"
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        value: valueChoose,
        iconEnabledColor: Colors.white,
        dropdownColor: Color(0xfff3C3C3C),
        onChanged: (newValue) {
          setState(() {
            valueChoose = newValue.toString();
          });
        },
        items: options.map((valueItem) {
          return DropdownMenuItem(
            value: valueItem,
            child: Text(
              valueItem,
              style: TextStyle(color: Colors.white),
            ),
          );
        }).toList(),
      ),
    );
  }
}
