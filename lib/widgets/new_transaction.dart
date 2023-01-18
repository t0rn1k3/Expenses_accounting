import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    widget.addTx(enteredTitle, enteredAmount);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            keyboardType: TextInputType.text,
            controller: titleController,
            onSubmitted: (_) => submitData,
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Amount'),
            keyboardType: TextInputType.number,
            controller: amountController,
            onSubmitted: (_) => submitData,
          ),
          TextButton(
            onPressed: submitData,
            style: TextButton.styleFrom(foregroundColor: Colors.purple),
            child: Text('Add Transaction'),
          )
        ]),
      ),
    );
  }
}
