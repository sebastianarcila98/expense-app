// ignore_for_file: sized_box_for_whitespace, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.transactions});

  final List<Transaction> transactions;

  List<Map<String, Object>> get _groupedTransactions {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));

      var totalSum = 0.0;
      for (var i = 0; i < transactions.length; i++) {
        if (transactions[i].date.day == weekday.day) {
          totalSum += transactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get _totalAmountSpent {
    var totalSum = 0.0;
    for (var i = 0; i < transactions.length; i++) {
      totalSum += transactions[i].amount;
    }
    return totalSum;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
      child: Card(
        elevation: 6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _groupedTransactions.map((e) {
            var currAmount = e['amount'] as double;
            return Flexible(
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    FittedBox(
                      child: Text(
                        (e['amount'] as double).toStringAsFixed(0),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    SizedBox(height: 4),
                    ChartBar(
                      amountSpent: currAmount,
                      percentSpent:
                          currAmount <= 0 ? 0 : currAmount / _totalAmountSpent,
                    ),
                    SizedBox(height: 4),
                    Text(
                      e['day'] as String,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
