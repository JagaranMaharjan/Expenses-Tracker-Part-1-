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
        for (int i = 0; i < recentTransacton.length; i++) {
          //per day transaction history
          if (recentTransacton[i].date.day == weekDay.day &&
              recentTransacton[i].date.month == weekDay.month &&
              recentTransacton[i].date.year == weekDay.year) {
            totalSum +=
                recentTransacton[i].amount; //total sum of per day transaction
          }
        }
        return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
      },
    ).reversed.toList();
  }

  final List<Transaction> recentTransacton;

  double get totalSpentAmount {
    return groupedExpenses.fold(
      0.0,
      (sum, item) {
        return sum + item['amount'];
      },
    );
  }

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
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    day: tx['day'],
                    spendAmount: tx['amount'],
                    spendPercent: totalSpentAmount == 0.0
                        ? 0.0
                        : (tx['amount'] as double) / totalSpentAmount,
                  ),
                );
              },
            ).toList()),
      ),
    );
  }
}
