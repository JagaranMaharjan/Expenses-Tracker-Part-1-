import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'adtivie_button.dart';

class NewTransaction extends StatefulWidget {
  // String title;
  //double amount;

  final Function addTx;
  NewTransaction({this.addTx});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = new TextEditingController();

  final amountController = new TextEditingController();

  DateTime _selectDateTime;

  void _submitData() {
    String title = titleController.text;
    double amount = double.parse(amountController.text);
    if (title.isEmpty || amount <= 0 || _selectDateTime == null) {
      return;
    }
    widget.addTx(title, amount, _selectDateTime);
    Navigator.pop(context);
  }

  void _pickDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then(
      (pickDate) {
        setState(
          () {
            _selectDateTime = pickDate;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        margin: EdgeInsets.all(8),
        child: Container(
          padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: "Enter product name",
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
                /* onChanged: (value) {
                  title = value;
                },*/
                controller: titleController,
                onSubmitted: (_) {
                  _submitData();
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Enter product amount",
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
                /*onChanged: (value) {
                  amount = double.parse(value);
                },*/
                controller: amountController,
                onSubmitted: (_) {
                  _submitData();
                },
                keyboardType: TextInputType.number,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    _selectDateTime == null
                        ? "No date choosen"
                        : "Picked Date : ${DateFormat.yMd().format(_selectDateTime).toString()}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  AditiveButton(onPress: _pickDate),
                ],
              ),
              RaisedButton(
                colorBrightness: Brightness.dark,
                color: Theme.of(context).accentColor,
                child: Text(
                  "Add Product",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                /*onPressed: () {
                  //addTransaction(title, amount);
                  addTx(title, amount);
                },*/
                onPressed: _submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
