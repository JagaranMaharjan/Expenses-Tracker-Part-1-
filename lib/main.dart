import 'package:bill_tracker_6/model/transaction.dart';
import 'package:bill_tracker_6/widgets/chart.dart';
import 'package:bill_tracker_6/widgets/new_transaction.dart';
import 'package:bill_tracker_6/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

void main() {
  runApp(Expenses());

  //-----auto rotation is disabled-------
  /*WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(Expenses());
  });*/
}

class Expenses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
  bool _showChart = false;

  void _addTransaction(String title, double amount, DateTime dateTime) {
    final newTx = Transaction(
        title: title,
        amount: amount,
        date: dateTime,
        id: DateTime.now().toString());
    setState(
      () {
        _userTransaction.add(newTx);
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  void _showAddTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return NewTransaction(addTx: _addTransaction);
      },
    );
  }

  List<Transaction> _userTransaction = [];

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
    final mediaQuery = MediaQuery.of(context);
    bool isLandScape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text("Track your bills !"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          color: Colors.white,
          onPressed: () => _showAddTransaction(context),
        ),
      ],
    );

    final txListWidget = Container(
        height: (mediaQuery.size.height * 0.7) -
            appBar.preferredSize.height -
            mediaQuery.padding.top,
        child: TransactionList(_userTransaction, _deleteTransaction));

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            if (isLandScape) //sdk updated in pubspec.yaml as 2.2.3
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Show Chart",
                    style: Theme.of(context).textTheme.title.copyWith(
                        color: Theme.of(context).accentColor,
                        fontFamily: "font1",
                        fontSize: 25),
                  ),
                  Switch(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  )
                ],
              ),
            if (!isLandScape)
              Container(
                height: (mediaQuery.size.height * 0.3) -
                    appBar.preferredSize.height -
                    mediaQuery.padding.top,
                child: Chart(_recentTransactions),
              ),
            if (!isLandScape) txListWidget,
            if (isLandScape)
              _showChart
                  ? Container(
                      height: (mediaQuery.size.height * 0.7) -
                          appBar.preferredSize.height -
                          mediaQuery.padding.top,
                      child: Chart(_recentTransactions))
                  : TransactionList(_userTransaction, _deleteTransaction),
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
