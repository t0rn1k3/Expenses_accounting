import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfAmount;

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfAmount);

  @override
  Widget build(BuildContext context) {
    print("spendingPctOfAmount: $spendingPctOfAmount");
    return LayoutBuilder(
      builder: (context, constraints){
        return Column(
      children: [
        Container(
          height: constraints.maxHeight * 0.15,
          child: Text('\$${spendingAmount.toStringAsFixed(0)}')),
        SizedBox(height: constraints.maxHeight * 0.05),
        Container(
          height: constraints.maxHeight * 0.6,
          width: 10,
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                color: Color.fromRGBO(220, 220, 220, 1),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            FractionallySizedBox(
              heightFactor: spendingPctOfAmount ,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            )
          ]),
        ),
        SizedBox(height: constraints.maxHeight * 0.05),
        Container(
          height: constraints.maxHeight * 0.15,
          child: FittedBox(
            child: Text(label)))
      ],
    );
    });
    
  }
}
