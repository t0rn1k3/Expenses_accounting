import 'package:expenses_accounting/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transactions.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);
  List<Map<String, Object>> get groupTransactionValues {
    return List.generate(7, (index) {
      var weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date!.day == weekDay.day &&
            recentTransactions[i].date!.month == weekDay.month &&
            recentTransactions[i].date!.year == weekDay.year) {
          totalSum += recentTransactions[recentTransactions.length - 1].amount as double;
          // recentTransactions[i].amount as double;
        }
      }
      double? lastValue= 0;
      if(recentTransactions.isNotEmpty){
     lastValue =   recentTransactions.last.amount;

      }
      print("lastValue : $lastValue");
      return {'day': DateFormat.E().format(weekDay), 'amount': lastValue ?? 0};
    });
  }

  double get totalSpending {
    return recentTransactions.fold(0.0, (sum, item) {
      return sum + item.amount!.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Row(
        children: groupTransactionValues.map((data) {
           double totalValue = 0;
           print("totalSpending");
          if(totalSpending != 0){
     totalValue =  (data['amount'] as double) /  totalSpending;

          }
          return ChartBar(
              (data['day'] as String),
              (data['amount'] as double),
              totalValue);
        }).toList(),
      ),
    );
  }
}
