import 'package:flutter/material.dart';
class GenderRadio extends StatefulWidget {
  @override
  _GenderRadioState createState() => _GenderRadioState();
}

class _GenderRadioState extends State<GenderRadio> {
  ///默认选中的单选框的值
  int groupValue = 0;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Radio(
        ///此单选框绑定的值 必选参数
        value: 0,
        ///当前组中这选定的值  必选参数
        groupValue: groupValue,
        ///点击状态改变时的回调 必选参数
        onChanged: (v) {
          setState(() {
            this.groupValue = v;
          });
        },
      ),
      Radio(
        ///此单选框绑定的值 必选参数
        value: 1,
        ///当前组中这选定的值  必选参数
        groupValue: groupValue,
        ///点击状态改变时的回调 必选参数
        onChanged: (v) {
          setState(() {
            this.groupValue = v;
          });
        },
      ),
      Radio(
        ///此单选框绑定的值 必选参数
        value: 2,
        ///当前组中这选定的值  必选参数
        groupValue: groupValue,
        ///点击状态改变时的回调 必选参数
        onChanged: (v) {
          setState(() {
            this.groupValue = v;
          });
        },
      )
    ],);
  }
}

