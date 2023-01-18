import 'package:flutter/material.dart';
import 'package:intl/intl.dart ';

import '../models/transactions.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: transactions.isEmpty
          ? Center(
              child: Text(
                'List of transactions is empty',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            )
          : ListView(
              children: transactions.map((transaction) {
                return Card(
                  child: Row(children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        '\$ ${transaction.amount}',
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontWeight: FontWeight.bold),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).primaryColorDark,
                              width: 2)),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transaction.title as String,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          DateFormat.yMMMd()
                              .format(transaction.date as DateTime),
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    )
                  ]),
                );
              }).toList(),
            ),
    );
  }
}
