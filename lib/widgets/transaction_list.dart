import 'package:bill_tracker_6/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  TransactionList(this.transaction);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            child: Row(
              children: <Widget>[
                Container(
                  child: Text(
                    "\$ " + transaction[index].amount.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(color: Theme.of(context).accentColor),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).accentColor, width: 2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(5),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      transaction[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    Text(
                      DateFormat.yMMMEd()
                          .add_jms()
                          .format(transaction[index].date),
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .copyWith(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        itemCount: transaction.length,
      ),
    );
  }
}
