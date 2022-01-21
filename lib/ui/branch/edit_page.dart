import 'package:bot_toast/bot_toast.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_admin/common/check.dart';
import 'package:registration_admin/config/const.dart';
import 'package:registration_admin/entity/user_entity.dart';
import 'package:registration_admin/state/add_state_model.dart';
import 'package:registration_admin/state/branch_state_model.dart';
import 'package:registration_admin/state/detail_state_model.dart';
import 'package:registration_admin/ui/widget/auto_resize_widget.dart';
import 'package:registration_admin/ui/widget/bar_widget.dart';
import 'package:smart_select/smart_select.dart';

//人员编辑页面
class EditPage extends StatefulWidget {
  UserEntity userEntity;
  DetailStateModel detailStateModel;
  EditPage(this.userEntity,this.detailStateModel);

  @override
  _EditPageState createState() => _EditPageState(userEntity.firstPositionId,userEntity.secondDepId,userEntity.secondPositionId,
      TextEditingController(text: userEntity.indentityId),TextEditingController(text:userEntity.phoneNum),TextEditingController(text: userEntity.name)
  );
}

class _EditPageState extends State<EditPage> {


  _EditPageState(this.firstPos,this.depSelect,this.secondPos,this._idController,this._phoneController,this._nameController);
  GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController _idController;
  TextEditingController _phoneController;
  TextEditingController _nameController;


  //选择器
  int firstPos;//一级职位
  int depSelect; //部门（二级
  int secondPos; //二级职位




  @override
  Widget build(BuildContext context) {
    /*
    _idController = new TextEditingController(text: widget.userEntity.indentityId);
    _phoneController = new TextEditingController(text: widget.userEntity.phoneNum);
    _nameController = new TextEditingController(text: widget.userEntity.name);
     */

    return AutoResizeWidget(
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          padding: EdgeInsets.all(10.0),
          color: Colors.white,
          width: double.infinity,
          child: Column(
            children: [
              BarWidget(STAFF_EDIT),
              Expanded(child: ListView(
                shrinkWrap: true,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        info(Icons.person,NAME, _nameController),
                        info(Icons.person, ID_NUMBER, _idController),
                        info(Icons.phone, PHONE, _phoneController),
                        SmartSelect.single(
                            modalType: SmartSelectModalType.bottomSheet,
                            leading: Icon(Icons.account_balance_outlined),
                            value: depSelect,
                            title: DEPARTMENT,
                            options: SmartSelectOption.listFrom<int,
                                Department>(
                              source: widget.detailStateModel.department,
                              value: (index, item) => item.id,
                              title: (index, item) => item.name,
                            ),
                            onChange: (v) {
                              setState(() {
                                depSelect = v;
                              });
                            }),
                        //选择器 一级职位
                        SmartSelect.single(
                            modalType: SmartSelectModalType.bottomSheet,
                            leading: Icon(Icons.water_damage),
                            value: firstPos,
                            title: FIRST_POS,
                            options: SmartSelectOption.listFrom<int,
                                FirstPos>(
                              source: widget.detailStateModel.firstPosList,
                              value: (index, item) => item.id,
                              title: (index, item) => item.name,
                            ),
                            onChange: (v) {
                              setState((){
                                firstPos = v;
                                widget.detailStateModel.getSecondPos(firstPos);
                              });
                            }),
                        //选择器 二级职位
                        SmartSelect.single(
                            modalType: SmartSelectModalType.bottomSheet,
                            leading: Icon(Icons.assistant_navigation),
                            value: secondPos,
                            title: SECOND_POS,
                            options: SmartSelectOption.listFrom<int,
                                SecondPos>(
                              source:widget.detailStateModel.secondPosList,
                              value: (index, item) => item.id,
                              title: (index, item) => item.name,
                            ),
                            onChange: (v) {
                              setState(() {
                                secondPos = v;
                              });
                            }),
                      ],
                    ),
                  )
                ],
              )),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(color: Theme.of(context).primaryColor),
                child: ButtonBar(
                  children: [
                    RaisedButton(
                      elevation: 4,
                      child: Text('取消',style: Theme.of(context).textTheme.button,),
                      color: Color(0xFF087f23),
                      onPressed: () => Navigator.pop(context)
                    ),
                    RaisedButton(
                      elevation: 4,
                      child: Text('确定',style: Theme.of(context).textTheme.button,),
                      color: Color(0xFF087f23),
                       onPressed: () => showAlertDialog(),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  //修改人员信息时弹出提示框
  showAlertDialog() {
    if((_formKey.currentState as FormState).validate())
      return showDialog<Null>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return new AlertDialog(
              title: new Text(
                '修改信息',
                style: TextStyle(color: Colors.green, fontSize: 20),
              ),
              //可滑动
              content: new SingleChildScrollView(
                  child: Text(
                    "信息无误？\n是否确认修改信息？",
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
                    onPressed: () => _handeModify(context)
                ),
              ],
            );
          });
  }
  Widget info(IconData iconData,String title,TextEditingController textEditingController){
    return Container(
      //padding: EdgeInsets.all(10.0),
      //height: 50.0,
      //width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(width: 15.0,),
              Container(width: 20.0,child: Icon(iconData,color: Colors.grey,size: 20,),),
              Container(width: 10.0,),
              Container(
                child: Text('$title',style: TextStyle(fontSize: 18),),
              ),
            ],
          ),
          Expanded(child: Container(
            transformAlignment: Alignment.centerRight,
            width: 250.0,
            //alignment: Alignment.centerRight,
            child: TextFormField(
              enableInteractiveSelection: true,
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 18.0,color: Colors.grey),
              controller: textEditingController,
              validator: title==NAME?(v) => strNoEmpty(v)?null:"请输入姓名":
              title == ID_NUMBER?(v) => isIdCard(v.trim()) ? null : '身份证号码格式错误':
                  (v) =>isMobilePhoneNumber(v.trim()) ? null : '手机号码格式错误',
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ))
        ],
      ),
    );
  }
  _handeModify(BuildContext context){

    widget.userEntity.name = _nameController.text;
    widget.userEntity.phoneNum = _phoneController.text;
    widget.userEntity.indentityId = _idController.text;
    widget.userEntity.firstPositionId = firstPos;
    widget.userEntity.roleId = (firstPos==3)? 3:2;
    widget.userEntity.secondDepId = depSelect;
    widget.userEntity.secondPositionId = secondPos;
   widget.detailStateModel.modify(widget.userEntity).then((value) {
      BotToast.showText(text: '修改成功');
      Navigator.of(context).pop();
      Navigator.of(context).pop("刷新页面");
      Provider.of<BranchStateModel>(branchContext, listen: false)..init();
    }).catchError((error) {
      print(error);
      BotToast.showText(text: '修改人员失败：'+error.toString());
    });

  }
}
