import 'package:flutter/material.dart';

var branchContext;
bool open = true; //部门列表
const appBarColor = Color(0xff4169e2);

const Color fixedColor = Colors.blue;

const bgColor = Color(0xfff7f7f7);

const mainSpace = 10.0;

const mainLineWidth = 0.3;

const lineColor = Colors.grey;

const mainTextColor = Color.fromRGBO(115, 115, 115, 1.0);

const String ADD_STAFF = "添加人员";
const String MANAGE_STAFF = "人员管理";
const String MANAGE_BRANCH = "部门管理";

const String STAFF_DETAIL = "人员详情";
const String STAFF_EDIT = '编辑信息';

const String NAME = "姓名";
const String ID_NUMBER = "身份证";
const String PHONE = "手机号码";
//添加人员
const String DEPARTMENT = "部门";
const String FIRST_POS = "一级职位";
const String SECOND_POS = "二级职位";

const TextStyle TEXT_STYLE_LABEL = TextStyle(
  color: Colors.black,
  fontSize: 18,
  fontWeight: FontWeight.w500
);

const TextStyle TEXT_STYLE_HINT = TextStyle(
  color: Colors.grey,
  fontSize: 13,
);

typedef DataCallback = void Function(String);

class Department{
  int id;
  String name;
}

class FirstPos{
  int id;
  String name;
}

class SecondPos{
  int id;
  String name;
}
