import 'package:expenses_accounting/widgets/new_transaction.dart';
import 'package:expenses_accounting/widgets/transacrion_list.dart';
import 'package:flutter/material.dart';

import './models/transactions.dart';
import './widgets/transacrion_list.dart';
import './widgets/chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown
  // ]
  // );
  runApp(MyApp());
}

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

  bool _showCart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((transaction) {
      return transaction.date!.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void addNewTransaction(String txTitle, double txAmount , DateTime chosenDate) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: chosenDate,
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction (String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
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
    final isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar =  AppBar(
        title: Text('Acoounting Expenses'),
        actions: [
          IconButton(
              onPressed: () => startAddNewTransaction(context),
              icon: Icon(Icons.add))
        ],
      );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            if(isLandScape) Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Show Chart'),
                Switch(value: _showCart, onChanged: (val){
                  setState(() {
                  _showCart = val;
                  });
                })
              ],
            ),
            if(!isLandScape) Container( 
              height: (MediaQuery.of(context).size.height) * 0.3 - 
                      appBar.preferredSize.height - 
                      MediaQuery.of(context).padding.top, 
              child: Chart(_recentTransactions),
            ),
            if(!isLandScape) Container(
              height: (MediaQuery.of(context).size.height) * 0.7 - 
                      appBar.preferredSize.height - 
                      MediaQuery.of(context).padding.top, 
              child: TransactionList(_userTransactions, _deleteTransaction)),
            if(isLandScape)_showCart ? Container( 
              height: (MediaQuery.of(context).size.height) * 0.7 - 
                      appBar.preferredSize.height - 
                      MediaQuery.of(context).padding.top, 
              child: Chart(_recentTransactions),
            ) :
            Container(
              height: (MediaQuery.of(context).size.height) * 0.7 - 
                      appBar.preferredSize.height - 
                      MediaQuery.of(context).padding.top, 
              child: TransactionList(_userTransactions, _deleteTransaction))
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
