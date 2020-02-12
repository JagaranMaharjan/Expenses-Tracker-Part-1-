import 'package:bill_tracker_6/model/transaction.dart';
import 'package:bill_tracker_6/widgets/chart.dart';
import 'package:bill_tracker_6/widgets/new_transaction.dart';
import 'package:bill_tracker_6/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(Expenses());

class Expenses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Bill Tracker",
      home: BillPage(),
      theme: ThemeData(
        primaryColor: Colors.deepOrangeAccent,
        accentColor: Colors.deepOrangeAccent,
        fontFamily: "font1",
        textTheme: TextTheme(
          title: TextStyle(
              fontFamily: "font2", fontSize: 20, fontWeight: FontWeight.bold),
        ),
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            title: TextStyle(
                fontFamily: "font1", fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class BillPage extends StatefulWidget {
  @override
  _BillPageState createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  String title;
  double amount;

  void _addTransaction(String title, double amount) {
    final newTx =
        Transaction(title: title, amount: amount, date: DateTime.now());
    setState(
      () {
        _userTransaction.add(newTx);
      },
    );
  }

  void _showAddTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return NewTransaction(addTx: _addTransaction);
      },
    );
  }

  List<Transaction> _userTransaction = [
    Transaction(
      title: "Watch",
      amount: 2000.0,
      date: DateTime.now(),
    ),
    Transaction(
      title: "Tv",
      amount: 20000.0,
      date: DateTime.now(),
    ),
    Transaction(
      title: "Laptop",
      amount: 200000.0,
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransaction.where(
      (tx) {
        return tx.date.isAfter(
          DateTime.now().subtract(
            Duration(days: 7),
          ),
        );
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Track your bills !"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            color: Colors.white,
            onPressed: () => _showAddTransaction(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Chart(_recentTransactions),
            /*Card(
              margin: EdgeInsets.all(10),
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Enter product name",
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onChanged: (value) {
                        title = value;
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Enter product amount",
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onChanged: (value) {
                        amount = double.parse(value);
                      },
                      keyboardType: TextInputType.number,
                    ),
                    RaisedButton(
                      colorBrightness: Brightness.dark,
                      color: Colors.green,
                      child: Text(
                        "Add Product",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      onPressed: () {
                        addTransaction(title, amount);
                      },
                    ),
                  ],
                ),
              ),
            ),*/
            // NewTransaction(addTx: _addTransaction),
            TransactionList(_userTransaction),
            /*Column(
              children: userTransaction.map(
                (tx) {
                  return Card(
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Text(
                            "\$ " + tx.amount.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green, width: 2),
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
                              tx.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                              DateFormat.yMMMEd().add_jms().format(tx.date),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ).toList(),
            ),*/
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showAddTransaction(context),
      ),
    );
  }
}
