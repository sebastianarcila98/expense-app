// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({super.key, required this.addTx});

  final Function addTx;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  var _selectedDate;

  void _submitted() {
    final enteredTitle = _titleController.text;
    final enteredAmount = _amountController.text.isEmpty
        ? 0.0
        : double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0.0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _openDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then(
      (date) {
        if (date == null) {
          return;
        }
        setState(() => _selectedDate = date);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _titleController,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: const InputDecoration(hintText: 'Title'),
              onSubmitted: (_) => _submitted(),
            ),
            TextField(
              controller: _amountController,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: const InputDecoration(hintText: 'Amount'),
              onSubmitted: (_) => _submitted(),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _selectedDate == null
                    ? const Text('Date: No date selected')
                    : Text(
                        'Date: ${DateFormat.yMd().format(_selectedDate).toString()}'),
                TextButton(
                    onPressed: () => _openDatePicker(),
                    child: const Text('Select Date')),
              ],
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(bottom: 25),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () => _submitted(),
                    child: const Text('Add Transaction'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
