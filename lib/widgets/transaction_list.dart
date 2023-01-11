// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(
      {super.key, required this.transactions, required this.deleteTx});
  final Function deleteTx;
  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 650,
      child: transactions.isEmpty
          ? Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'No recent transaction',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 300,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          child: Text(
                              '\$${transactions[index].amount.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.titleMedium),
                        ),
                        Flexible(
                          flex: 7,
                          fit: FlexFit.tight,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(transactions[index].title,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  DateFormat.yMMMMd()
                                      .format(transactions[index].date),
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.grey.withOpacity(.8),
                            ),
                            onPressed: () => deleteTx(transactions[index].id),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
