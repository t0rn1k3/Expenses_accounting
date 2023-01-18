import 'package:expenses_accounting/widgets/new_transaction.dart';
import 'package:expenses_accounting/widgets/transacrion_list.dart';
import 'package:flutter/material.dart';

import './models/transactions.dart';
import './widgets/transacrion_list.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.amber,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? inputTitle;
  String? inputAmount;

  final List<Transaction> _userTransactions = [
    // Transaction(id: 'a1', title: 'books', amount: 12.60, date: DateTime.now()),
    // Transaction(id: 'a2', title: 'car', amount: 120.60, date: DateTime.now())
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((transaction) {
      return transaction.date!.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: DateTime.now(),
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acoounting Expenses'),
        actions: [
          IconButton(
              onPressed: () => startAddNewTransaction(context),
              icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_userTransactions)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
