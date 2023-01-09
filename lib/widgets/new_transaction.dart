import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({super.key, required this.addTx});

  final Function addTx;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitted() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) return;

    widget.addTx(
      enteredTitle,
      enteredAmount,
    );

    Navigator.of(context).pop();
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
              controller: titleController,
              decoration: const InputDecoration(hintText: 'Title'),
              onSubmitted: (_) => submitted(),
            ),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(hintText: 'Amount'),
              onSubmitted: (_) => submitted(),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            TextButton(
              onPressed: () => submitted(),
              child: const Text(
                'Add Transaction',
                style: TextStyle(color: Colors.purple),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
