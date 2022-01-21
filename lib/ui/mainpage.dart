

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_admin/config/const.dart';
import 'package:registration_admin/state/branch_state_model.dart';
import 'package:registration_admin/state/user_state_model.dart';
import 'package:registration_admin/ui/add_staff/addpage.dart';
import 'package:registration_admin/ui/branch/branch_page.dart';
import 'package:registration_admin/ui/widget/auto_resize_widget.dart';
import 'package:registration_admin/ui/widget/header.dart';

import 'loginpage/login.dart';
//主页面 部门管理 添加人员
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  TextStyle buttonText = TextStyle(
    fontSize: 16.0,
    color: Colors.white
  );
  @override
  Widget build(BuildContext context) {
    return AutoResizeWidget(
        child: Scaffold(
          body: Container(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Header(),
                Flexible(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(height: 80,width: 200,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(12)),
                          highlightColor: Colors.greenAccent,
                          color: Theme.of(context).primaryColor,
                          child: Text(ADD_STAFF,
                            style: buttonText),
                          onPressed: () => Navigator.push(
                              context, MaterialPageRoute(builder: (context) =>AddPage()))
                      ),),
                    Container(height: 50.0,),
                    Container(height: 80,width: 200,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(12)),
                        color: Theme.of(context).primaryColor,
                        child: Text(MANAGE_BRANCH,
                          style:  buttonText,),
                        onPressed: (){
                          open = true;
                          Navigator.push(context, MaterialPageRoute(builder: (context) => BranchPage()));
                        },
                      ),),
                  ],
                )),
                Flexible(
                  flex: 0,
                  child: Builder(builder: (context) {
                    return _buildButtonGroup(context);
                  }),
                )
              ],
            ),
          ),
        )
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
              child: Text(
                "退出登录",
                style: Theme.of(context).textTheme.button,
              ),
              color: Color(0xFF087f23),
              onPressed: () => handleLogout(context),
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ));
  }
  //登出
  handleLogout(BuildContext context) {
    Provider.of<UserStateModel>(context, listen: false).logout();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

}
