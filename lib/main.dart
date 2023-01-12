// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:expense_app/widgets/new_transaction.dart';
import 'package:flutter/material.dart';

import './models/transaction.dart';
import './widgets/transaction_list.dart';
import 'widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expenses App',
      home: HomeScreen(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        textTheme: Theme.of(context).primaryTextTheme.copyWith(
              titleLarge: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              bodyLarge: TextStyle(
                fontSize: 17.5,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              bodyMedium: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              bodySmall: TextStyle(
                fontSize: 12.5,
                color: Colors.grey[600],
                fontWeight: FontWeight.w600,
              ),
              titleMedium: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
        fontFamily: 'Quicksand',
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _userTransactions = <Transaction>[
    Transaction(
      id: 't1',
      title: 'New shoes',
      amount: 89.69,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Groceries',
      amount: 21.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'New shoes',
      amount: 89.69,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'Groceries',
      amount: 21.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't5',
      title: 'New shoes',
      amount: 89.69,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't6',
      title: 'Groceries',
      amount: 21.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't7',
      title: 'New shoes',
      amount: 89.69,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't8',
      title: 'Groceries',
      amount: 21.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't9',
      title: 'New shoes',
      amount: 89.69,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't10',
      title: 'Groceries',
      amount: 21.99,
      date: DateTime.now(),
    )
  ];

  var switchVal = false;

  void _startAddTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(
          addTx: _addTransaction,
        );
      },
    );
  }

  void _addTransaction(String txTitle, double txAmount, DateTime chosenTime) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: chosenTime,
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Expenses App'),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            onPressed: () => _startAddTransaction(context),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(transactions: _userTransactions),
            TransactionList(
                transactions: _userTransactions, deleteTx: _deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
