import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_admin/common/check.dart';
import 'package:registration_admin/config/const.dart';
import 'package:registration_admin/data/branch_repo.dart';
import 'package:registration_admin/state/branch_state_model.dart';
import 'package:registration_admin/ui/branch/list_page.dart';
import 'package:registration_admin/ui/widget/auto_resize_widget.dart';
import 'package:smart_select/smart_select.dart';

class BranchPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return AutoResizeWidget(
      child: BranchPagea(),
    );
  }
}
class BranchPagea extends StatefulWidget {
  const BranchPagea({Key key}) : super(key: key);

  @override
  _BranchPageaState createState() => _BranchPageaState();
}

class _BranchPageaState extends State<BranchPagea> {
  bool isChange = false;

  TextEditingController _departmentController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    //注册部门列表状态管理器
    return ChangeNotifierProvider<BranchStateModel>(
      create: (BuildContext context) => BranchStateModel()..init(),
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          padding: EdgeInsets.all(10.0),
          color: Colors.white,
          width: double.infinity,
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.close),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Text('   ' +MANAGE_BRANCH,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 20,
                            )),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        isChange = !isChange;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: Text(isChange?"取消":"编辑",
                        style: TextStyle(fontSize: 16.0,color: Colors.grey),),
                    ),
                  )

                ],
              ),
              //部门列表
              Consumer<BranchStateModel>(builder: (BuildContext context,BranchStateModel value,Widget child){
                branchContext  = context;
                return Expanded(child: value.state?ListView(children: [ListPage(value)],):Container());
              }),
              //根据编辑按钮显示新增、删除部门按钮
              isChange?Container(
                width: double.infinity,
                decoration: BoxDecoration(color: Theme.of(context).primaryColor),
                child: ButtonBar(
                  children: [
                    RaisedButton(
                      elevation: 4,
                      child: Text('新增部门',style: Theme.of(context).textTheme.button,),
                      color: Color(0xFF087f23),
                      onPressed: () => showNewDialog(),
                    ),
                    Consumer<BranchStateModel>(builder: (BuildContext context,BranchStateModel value,Widget child){
                      branchContext  = context;
                      return RaisedButton(
                        elevation: 4,
                        child: Text('删除部门',style: Theme.of(context).textTheme.button,),
                        color: Color(0xFF087f23),
                        onPressed: () => showDeleteDialog(value),
                      );
                    }),
                  ],
                ),
              ):Container()

            ],
          ),
        ),
      ),
    );
  }

  //新增部门弹窗
  showNewDialog(){
    return showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text(
              '新增部门',
              style: TextStyle(color: Colors.green, fontSize: 20),
            ),
            //可滑动
            content: new SingleChildScrollView(
                child: TextFormField(
                  enableInteractiveSelection: true,
                  style: TextStyle(fontSize: 16.0,color: Colors.grey),
                  controller: _departmentController,
                  decoration: InputDecoration(
                      labelText: '部门名称',
                      hintText: '部门名称',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),),
                ),),
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
                  onPressed: () => _handleNew(_departmentController.text)
              ),
            ],
          );
        });
  }

  _handleNew(String name){
    if(name == ""||name == null){
      BotToast.showText(text: "请输入名称~~~");
    }else{
      BranchRepo().addNewDepartment(name).then((value) {
        Provider.of<BranchStateModel>(branchContext, listen: false).init();
        //对lisrpage页面的展开列表调整
        open = true;
        BotToast.showText(text: '新增成功！');
        Navigator.pop(context);


      }).catchError((error){
        print(error);
        BotToast.showText(text: '新增部门失败：'+error.toString());
      });
    }
  }

  //删除部门弹窗
  showDeleteDialog(value){
    int depSelect = 1;
    //BranchStateModel value = Provider.of<BranchStateModel>(branchContext,listen: true);
    return showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return DeleteDialog(value);
        });
  }

}

class DeleteDialog extends StatefulWidget {
  var value;
  DeleteDialog(this.value);

  @override
  _DeleteDialogState createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  int depSelect = 1;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(
        '删除部门',
        style: TextStyle(color: Colors.green, fontSize: 20),
      ),
      //可滑动
      content: Container(
        height: 100.0,
        child: Column(
          children: [
            SmartSelect.single(
                modalType: SmartSelectModalType.bottomSheet,
                //leading: Icon(Icons.account_balance_outlined),
                value: depSelect,
                title: DEPARTMENT,
                options: SmartSelectOption.listFrom<int,
                    Department>(
                  source: widget.value.departments,
                  value: (index, item) => item.id,
                  title: (index, item) => item.name,
                ),
                onChange: (v) {
                  setState(() {
                    depSelect = v;
                  });
                }),
            Row(
              children: [
                Icon(Icons.warning_amber_sharp,color: Colors.yellow,size: 15.0,),
                Text('  只允许删除无人员的部门',style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0
                ),)
              ],
            )
          ],
        ),
      ),
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
          onPressed: () => _handleDelete(depSelect)
        ),
      ],
    );
  }
  _handleDelete(int id){
    BranchRepo().deleteDepartmenrt(id).then((value) {
      BotToast.showText(text: '删除成功！');
      open = true;
      Provider.of<BranchStateModel>(branchContext, listen: false).init();
      Navigator.pop(context);

    }).catchError((error){
      print(error);
      BotToast.showText(text: '请先转移部门下人员~~');
    });
  }
}


