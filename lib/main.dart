import 'package:bill_tracker_6/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(Expenses());

class Expenses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Bill Tracker",
      home: BillPage(),
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

  void addTransaction(String title, double amount) {
    final newTx =
        Transaction(title: title, amount: amount, date: DateTime.now());
    setState(
      () {
        userTransaction.add(newTx);
      },
    );
  }

  List<Transaction> userTransaction = [
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Track your bills !"),
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                child: Text("Chart"),
              ),
            ),
            Card(
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
            ),
            Column(
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
            ),
          ],
        ),
      ),
    );
  }
}