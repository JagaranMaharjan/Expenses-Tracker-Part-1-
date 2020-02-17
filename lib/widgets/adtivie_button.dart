import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AditiveButton extends StatelessWidget {
  final Function onPress;
  AditiveButton({this.onPress});
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              "Choose a date",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            onPressed: onPress,
          )
        : FlatButton(
            child: Text(
              "Choose a date",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            onPressed: onPress,
          );
  }
}
