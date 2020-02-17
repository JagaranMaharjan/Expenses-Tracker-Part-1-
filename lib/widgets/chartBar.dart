import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String day;
  final double spendAmount;
  final double spendPercent;

  ChartBar({this.day, this.spendAmount, this.spendPercent});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: <Widget>[
            Container(
                height: constraints.maxHeight * 0.15,
                child: FittedBox(
                    child: Text("\$${spendAmount.toStringAsFixed(0)}"))),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.6,
              width: 10,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendPercent,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(height: constraints.maxHeight * 0.15, child: Text(day)),
          ],
        );
      },
    );
  }
}
