import 'package:registration_admin/common/req_model.dart';
import 'package:registration_admin/config/api.dart';
import 'package:registration_admin/entity/user_entity.dart';

class BranchRepo{


  //获取对应部门的人员
  Future getStaff()async{
    try{
      var res = await ReqModel.post(API.GET_USERS,{
        "additionalProp1": {},
        "additionalProp2": {},
        "additionalProp3": {}
      });
      print(" getStaff success");
      return Future.value(UserEntity.fromJsonList(res));
    }catch(error){
      print("getStaff error:"+error.toString());
      return Future.error(error);
    }
  }

  //删除人员
  Future deleteStaff(int id) async{
    try{
      var res = await ReqModel.get(API.DELETE_USER, {"userId":id});
      print("deleteStaff success");
      return Future.value(res);
    }catch(error){
      print("deleteStaff error:"+error.toString());
      return Future.error(error);
    }
  }

  //修改人员信息
  Future modifyStaff(UserEntity userEntity)async {
    try {
      var res = await ReqModel.post(API.MODIFY_USER, userEntity.toJson());
      print("modifyStaff success");
      return Future.value(res);
    } catch (error) {
      print("modifyStaff error:" + error.toString());
      return Future.error(error);
    }
  }
    
    //新增部门
    Future addNewDepartment(String name) async{
      try{
        var res = await ReqModel.get(API.ADD_NEW_DEPARTMENT, {"departmentName":name});
        print("addNewDepartment success");
        return Future.value(res );
      }catch(error){
        print("addNewDepartment error:"+error.toString());
        return Future.error(error);
      }
    }

    //删除部门
  Future deleteDepartmenrt(int id)async{
    try{
      var res = await ReqModel.get(API.DELETE_DEPARTMENT, {"secondDepId":id});
      print("deleteDepartment success");
      return Future.value(res);
    }catch(error){
      print("deleteDepartment error:"+error.toString());
      return Future.error(error);
    }
  }
}