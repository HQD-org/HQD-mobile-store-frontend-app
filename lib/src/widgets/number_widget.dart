import 'package:flutter/material.dart';

class NumberWidget extends StatelessWidget {
  Widget buildButton(BuildContext context, String value, String title) {
    return MaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.symmetric(vertical: 4),
      onPressed: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget buildDivider() {
    return Container(
      height: 24,
      child: VerticalDivider(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildButton(context, "4.8", "Ranking"),
        buildDivider(),
        buildButton(context, "11", "Hóa đơn"),
        buildDivider(),
        buildButton(context, "3", "Yêu thích"),
      ],
    );
  }
}
