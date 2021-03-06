import 'package:bill_tracker_6/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTransactions;
  TransactionList(this.transaction, this.deleteTransactions);

  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: <Widget>[
                Container(
                  height: constraints.maxHeight * 0.25,
                  child: Text(
                    "No Transaction Has Been Added",
                    style: Theme.of(context).textTheme.title.copyWith(
                        color: Colors.deepOrangeAccent,
                        fontFamily: "font1",
                        fontSize: 25),
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.05,
                ),
                Image.asset(
                  "assets/images/box.png",
                  height: constraints.maxHeight * 0.7,
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).accentColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Text(
                          "\$ " + transaction[index].amount.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .title
                              .copyWith(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    transaction[index].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMEd()
                        .add_jms()
                        .format(transaction[index].date),
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(color: Colors.grey, fontSize: 12),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete_forever,
                      color: Theme.of(context).accentColor,
                    ),
                    iconSize: 40,
                    splashColor: Colors.blue,
                    onPressed: () {
                      deleteTransactions(transaction[index].id);
                    },
                  ),
                ),
              );
            },
            itemCount: transaction.length,
          );
  }
}

/*Row(
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
                  )*/
