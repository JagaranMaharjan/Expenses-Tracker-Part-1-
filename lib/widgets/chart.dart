import 'package:bill_tracker_6/model/transaction.dart';
import 'package:bill_tracker_6/widgets/chartBar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  List<Map<String, Object>> get groupedExpenses {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index));
        double totalSum = 0.0;
        return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
      },
    );
  }

  final List<Transaction> recentTransacton;

  Chart(this.recentTransacton);
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedExpenses.map(
            (tx) {
              return ChartBar();
            },
          ).toList()),
    ));
  }
}
