import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_admin/config/const.dart';
import 'package:registration_admin/entity/user_entity.dart';
import 'package:registration_admin/state/branch_state_model.dart';
import 'package:registration_admin/ui/branch/detail_page.dart';
import 'package:registration_admin/ui/widget/no_data_widget.dart';


//部门列表
class ListPage extends StatefulWidget {
  BranchStateModel _branchStateModel;
   ListPage(this._branchStateModel);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  List<int> mList;
  List<ExpandStateBean> expandStateList;

  @override
  Widget build(BuildContext context) {
    //点击列表标题 展开或者收起
    _setCurrentIndex(int index,isExpand){
      setState(() {
        //遍历可展开状态列表
        expandStateList.forEach((item){
          if(item.index==index){
            open = false;
            item.isOpen=!isExpand;
          }
        });
      });
    }

    if(open&&Provider.of<BranchStateModel>(branchContext, listen: true).state){
      mList = [];
      expandStateList = [];

      //部门数量
      int numbs =Provider.of<BranchStateModel>(branchContext, listen: true).departments.length;
      for(int i=0;i<numbs;i++){
        mList.add(i);
        expandStateList.add(ExpandStateBean(i, false));
      }
    }
    return Consumer<BranchStateModel>(
        builder: (BuildContext context,BranchStateModel value,Widget child){
          //部门数量

      return value.state?ExpansionPanelList(
        expansionCallback: (index,bol){
          _setCurrentIndex(index, bol);
        },
        children: mList.map((index){
          //返回一个组成的ExpansionPanel
          return ExpansionPanel(
              headerBuilder: (context,isExpanded){
                return GestureDetector(
                  //标题
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Container(
                      child: ListTile(
                        title: Text(value.departments[index].name,
                          style: new TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700
                          ),),

                      ),
                    ),
                  ),
                  onTap: (){
                    //调用内部方法
                    print("点击展开！！");
                    _setCurrentIndex(index, expandStateList[index].isOpen);
                  },
                );
              },
              body:Container(
                child: staffList(context, value.departments[index].id),//value.hashDepartment[value.departments[index].id]
              ) ,
              isExpanded: expandStateList[index].isOpen
          );
        }).toList(),

      ):Container();
    });
  }

  //人员列表组件
  Widget staffList(BuildContext context,int depID){

    return Consumer<BranchStateModel>(
      builder: (BuildContext context,BranchStateModel value,Widget child){
        if(value.hashDepartment[depID] == null||value.hashDepartment[depID].length == 0){
          return NonDataWidget();
        }
        else{
          List<Widget> _list = new  List();
          for (var x in value.hashDepartment[depID]) {
            _list.add(Container(
              padding: EdgeInsets.only(left: 20.0,right: 10.0),
              child:staffOneWidget(context, x) ,
            ));
          }
          return ListView(
              physics: NeverScrollableScrollPhysics(),//两级/多级listview
              shrinkWrap: true ,
              children:_list
          );
        }
      },
    );
  }

  Widget staffOneWidget(BuildContext context,UserEntity userEntity){
    return InkWell(
      highlightColor: Theme.of(context).primaryColor,
      onTap: (){
        //点击人名跳转对应个人信息页面
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => DetailPage(userEntity,widget._branchStateModel)));
      },
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(5.0),
            height: 40.0,
            child: Text(userEntity.name,style: TextStyle(fontSize: 16.0),),
          ),
          Container(height: 1.0,color:Colors.grey[100],)
        ],
      ),

    );
  }
}

//list中item状态自定义类
class ExpandStateBean{
  var isOpen;   //item是否打开
  var index;    //item中的索引
  ExpandStateBean(this.index,this.isOpen);
}

