import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_admin/common/check.dart';
import 'package:registration_admin/config/const.dart';
import 'package:registration_admin/data/add_staff_repo.dart';
import 'package:registration_admin/state/add_state_model.dart';
import 'package:registration_admin/ui/widget/auto_resize_widget.dart';
import 'package:smart_select/smart_select.dart';

//添加人员

class AddPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return AutoResizeWidget(
      child: AddPagea(),
    );
  }
}
class AddPagea extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}


class _AddPageState extends State<AddPagea> {



  GlobalKey<FormState> _formKey = GlobalKey();
  int sexGroupValue = 1;
  //输入框
  TextEditingController _idController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  //选择器
  //一级职位 所领导 部门负责人 普通职工
  int firstPos = 3; //默认普通职工
  //二级部门
  int depSelect = 1;
  //二级职位
  int secondPso = 13;

  AddStateModel addStateModel = new AddStateModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<AddStateModel>(
        builder: (BuildContext context,AddStateModel value,Widget child){
          addStateModel = value;
          return Scaffold(
            //type: MaterialType.transparency,
            //color: Colors.white,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      color: Colors.white,
                      width: double.infinity,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('   ' +ADD_STAFF,
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 20,
                                      )),
                                  IconButton(
                                    icon: Icon(Icons.close),
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              ),
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    //姓名输入框
                                    TextFormField(
                                      enableInteractiveSelection: true,
                                      validator: (v) {
                                        return strNoEmpty(v) ? null : '请输入姓名';
                                      },
                                      controller: _nameController,
                                      decoration: InputDecoration(

                                          labelText: '姓名',
                                          hintText: '请输入添加人员姓名',
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13,
                                          ),
                                          prefixIcon: Container(
                                            padding: EdgeInsets.all(17.0),
                                            alignment: Alignment.centerLeft,
                                            child: Icon(Icons.person),
                                            width: 70,
                                            height: 50,
                                          )),
                                    ),
                                    //身份证号码输入框
                                    TextFormField(
                                      enableInteractiveSelection: true,
                                      validator: (v) {
                                        return isIdCard(v.trim()) ? null : '身份证号码格式错误';
                                      },
                                      controller: _idController,
                                      decoration: InputDecoration(
                                          labelText: '身份证',
                                          hintText: '请输入添加人员身份证号码',
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13,
                                          ),
                                          prefixIcon: Container(
                                            padding: EdgeInsets.all(17.0),
                                            alignment: Alignment.centerLeft,
                                            child: Icon(Icons.person),
                                            width: 70,
                                            height: 50,
                                          )),
                                    ),
                                    //手机号码输入框
                                    TextFormField(
                                      enableInteractiveSelection: true,
                                      validator: (v) {
                                        return isMobilePhoneNumber(v.trim()) ? null : '手机号码格式错误';
                                      },
                                      controller: _phoneController,
                                      decoration: InputDecoration(
                                          labelText: '手机号码',
                                          hintText: '请输入添加人员手机号码',
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13,
                                          ),
                                          prefixIcon: Container(
                                            padding: EdgeInsets.all(17.0),
                                            alignment: Alignment.centerLeft,
                                            child: Icon(Icons.phone),
                                            width: 70,
                                            height: 50,
                                          )),
                                    ),
                                    Container(height: 5.0,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        _buildRadioButton(1, "男"),
                                        _buildRadioButton(0, "女")
                                      ],
                                    ),
                                    Container(height: 5.0,),
                                    //选择器 部门
                                    SmartSelect.single(
                                        modalType: SmartSelectModalType.bottomSheet,
                                        leading: Icon(Icons.account_balance_outlined),
                                        value: depSelect,
                                        title: DEPARTMENT,
                                        options: SmartSelectOption.listFrom<int,
                                            Department>(
                                          source: value.departments,
                                          value: (index, item) => item.id,
                                          title: (index, item) => item.name,
                                        ),
                                        onChange: (v) {
                                          setState(() {
                                            depSelect = v;
                                          });
                                        }),
                                    Container(height: 1.0,color: Colors.grey,),
                                    //选择器 一级职位
                                    SmartSelect.single(
                                        modalType: SmartSelectModalType.bottomSheet,
                                        leading: Icon(Icons.water_damage),
                                        value: firstPos,
                                        title: FIRST_POS,
                                        options: SmartSelectOption.listFrom<int,
                                            FirstPos>(
                                          source: value.firstPosLis,
                                          value: (index, item) => item.id,
                                          title: (index, item) => item.name,
                                        ),
                                        onChange: (v) {
                                          setState((){
                                            firstPos = v;
                                            value.getSecondPos(firstPos);
                                          });
                                        }),
                                    //选择器 二级职位
                                    SmartSelect.single(
                                        modalType: SmartSelectModalType.bottomSheet,
                                        leading: Icon(Icons.assistant_navigation),
                                        value: secondPso,
                                        title: SECOND_POS,
                                        options: SmartSelectOption.listFrom<int,
                                            SecondPos>(
                                          source: value.secondPosList,
                                          value: (index, item) => item.id,
                                          title: (index, item) => item.name,
                                        ),
                                        onChange: (v) {
                                          setState(() {
                                            secondPso = v;
                                          });
                                        }),
                                  ],
                                ),

                              )
                            ],
                          )
                        ],
                      ),
                    )),
                Flexible(
                  flex: 0,
                  child: Builder(builder: (context) {
                    return _buildButtonGroup(context);
                  }),
                )
              ],
            ),
          );
        }
    );
  }
  _buildButtonGroup(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: ButtonBar(
          children: <Widget>[
            RaisedButton(
              elevation: 4,
              child: Text('取消',style: Theme.of(context).textTheme.button,),
              color: Color(0xFF087f23),
              onPressed: () => Navigator.pop(context),
            ),
            RaisedButton(
              elevation: 4,
              child: Text('添加',style: Theme.of(context).textTheme.button,),
              color: Color(0xFF087f23),
              onPressed: () => showAlertDialog(),
            )
          ],
        ));
  }
  //添加人员时弹出提示框
  showAlertDialog() {
    if((_formKey.currentState as FormState).validate())
    return showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text(
              '添加人员',
              style: TextStyle(color: Colors.green, fontSize: 20),
            ),
            //可滑动
            content: new SingleChildScrollView(
                child: Text(
                  "信息无误？\n是否确认添加人员？",
                  style: TextStyle(fontSize: 15),
                )),
            actions: <Widget>[
              new FlatButton(
                child: new Text(
                  '取消',
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text(
                  '确定',
                  style: TextStyle(color: Colors.green),
                ),
                onPressed: () => _handeAdd(context)
              ),
            ],
          );
        });
  }
  _handeAdd(BuildContext context){
    var model = addStateModel;
    model.addStaffEntity.firstDepId = 1;
    model.addStaffEntity.firstPositionId = firstPos;
    model.addStaffEntity.gender = sexGroupValue;
    model.addStaffEntity.indentityId = _idController.text;
    model.addStaffEntity.name = _nameController.text;
    model.addStaffEntity.phoneNum = _phoneController.text;
    model.addStaffEntity.roleId = (firstPos==3)? 3:2;
    model.addStaffEntity.secondDepId = depSelect;
    model.addStaffEntity.secondPositionId = secondPso;
    AddStaffRepo().addStaff(model.addStaffEntity).then((value) {
      BotToast.showText(text: '添加成功');
      Navigator.of(context).pop();
      Navigator.of(context).pop("刷新页面");
    }).catchError((error) {
      print(error);
      BotToast.showText(text: '添加人员失败：'+error.toString());
    });

  }
  _buildRadioButton(int value, String label) {
    return Row(
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: value,
          groupValue: sexGroupValue,
          onChanged: (v) => onRadioChange(v),
        ),
        SizedBox(
          width: 4,
        ),
        Text(label)
      ],
    );
  }
  onRadioChange(v) {
    setState(() {
      sexGroupValue = v;
    });
  }
}
