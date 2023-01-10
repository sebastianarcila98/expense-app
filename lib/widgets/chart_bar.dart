// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar(
      {super.key, required this.amountSpent, required this.percentSpent});

  final double amountSpent;
  final double percentSpent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 10,
      child: Stack(
        children: [
          Container(
            height: 80,
            width: 10,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          FractionallySizedBox(
            heightFactor: percentSpent,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          )
        ],
      ),
    );
  }
}
