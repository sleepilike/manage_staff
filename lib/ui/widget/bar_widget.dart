import 'package:flutter/material.dart';

class BarWidget extends StatefulWidget {
  String title;
  BarWidget(this.title);

  @override
  _BarWidgetState createState() => _BarWidgetState();
}

class _BarWidgetState extends State<BarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('   ' +widget.title,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 18,
              )),
          IconButton(
            icon: Icon(Icons.close),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
