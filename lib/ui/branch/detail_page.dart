import 'package:auto_size_text/auto_size_text.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_admin/config/const.dart';
import 'package:registration_admin/data/branch_repo.dart';
import 'package:registration_admin/entity/user_entity.dart';
import 'package:registration_admin/state/add_state_model.dart';
import 'package:registration_admin/state/branch_state_model.dart';
import 'package:registration_admin/state/detail_state_model.dart';
import 'package:registration_admin/ui/branch/edit_page.dart';
import 'package:registration_admin/ui/widget/auto_resize_widget.dart';

//人员详情页面
class DetailPage extends StatefulWidget {
  UserEntity userEntity;
  BranchStateModel branchStateModel;
  DetailPage(this.userEntity,this.branchStateModel);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailStateModel>(
      create: (BuildContext context) => DetailStateModel()..init(widget.userEntity),
      child: Consumer<DetailStateModel>(
        builder: (BuildContext context,DetailStateModel value,Widget child){

          return AutoResizeWidget(child: Material(
            type: MaterialType.transparency,
            child: value.state?Container(
              padding: EdgeInsets.all(10.0),
              color: Colors.white,
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('   ' +STAFF_DETAIL,
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
                  Expanded(child: ListView(
                    shrinkWrap: true,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          info(Icons.person, NAME, value.userEntity.name),
                          info(Icons.person, ID_NUMBER, value.userEntity.indentityId),
                          info(Icons.phone, PHONE, value.userEntity.phoneNum),
                          value.state?info(Icons.local_fire_department_rounded, "所属部门",
                              value.userEntity.firstDepId == 1?
                              value.departmentsHash[value.userEntity.secondDepId]:"测试"):Container(),
                          value.state?info(Icons.work, "职位",
                              value.firstPosHash[value.userEntity.firstPositionId]+' | '
                                  +value.allSecondPosHash[value.userEntity.secondPositionId]):Container(),
                        ],
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
                          child: Text('编辑',style: Theme.of(context).textTheme.button,),
                          color: Color(0xFF087f23),
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EditPage(value.userEntity,value))),
                        ),
                        RaisedButton(
                          elevation: 4,
                          child: Text('删除',style: Theme.of(context).textTheme.button,),
                          color: Color(0xFF087f23),
                          onPressed: () => showAlertDialog(value.userEntity.id),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ):Container(),
          ),);
        },
      ),
    );
  }
  Widget info(IconData iconData,String title,String info){
    return Container(
      padding: EdgeInsets.all(10.0),
      height: 50.0,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              //Container(width: 10.0,),
              Container(width: 20.0,child: Icon(iconData,color: Colors.grey,size: 20,),),
              Container(width: 10.0,),
              Container(
                child: AutoSizeText('$title',),
              ),
            ],
          ),
          Container(
              width: 250.0,
              alignment: Alignment.centerRight,
              child:SelectableText("$info ",style: TextStyle(color: Colors.grey,fontSize: 18),maxLines: 2,)
          )
        ],
      ),
    );
  }
  //删除人员时弹出提示框
  showAlertDialog(int id) {
    return showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text(
              '删除人员',
              style: TextStyle(color: Colors.green, fontSize: 20),
            ),
            //可滑动
            content: new SingleChildScrollView(
                child: Text(
                  "确认删除？",
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
                  onPressed: () => _handleDelete(context, id)
              ),
            ],
          );
        });

  }
  _handleDelete(BuildContext context,int id)async{
    BotToast.showLoading();
    await widget.branchStateModel.delete(id)
        .then((value) {
          open = true;
      BotToast.closeAllLoading();
      BotToast.showText(text: '删除成功');
      Navigator.pop(context);
      Navigator.pop(context);
      Provider.of<BranchStateModel>(branchContext, listen: false).init();
    }).catchError((err) {
      BotToast.closeAllLoading();
      BotToast.showText(text: '删除失败！网络出错了~~~' );

    } );
  }

}
