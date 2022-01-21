import 'package:registration_admin/common/req_model.dart';
import 'package:registration_admin/config/api.dart';
import 'package:registration_admin/entity/add_staff_entity.dart';

//添加人员部分 一些数据请求
class AddStaffRepo{


  //获取一级职位列表 所领导、部门负责人、普通职工...
  Future getFirstPositionList() async{
    try{
      List<dynamic> res = await ReqModel.get(API.GET_FIRST_POSITIONLIST, null);
      return Future.value(res);
    }catch (error) {
      print('getFirstPositionList: '+ error.toString());
      return Future.error(error);
    }
  }

  //获取(二级）机构列表 办公室、科技科、技术合作与推广中心...
  //一级机构列表为"广东省农业科学院农业经济与信息研究所"、“测试”，所以此处直接传入一级机构列表id=1
  Future getSecondDep() async{
    try{
      List<dynamic> res = await ReqModel.get(API.GET_SECOND_DEP, {"firstDepId":1});
      return Future.value(res);
    }catch (error) {
      print('getFirstPositionList: '+ error.toString());
      return Future.error(error);
    }
  }

  //传入一级职位id获取对应二级职位列表
  Future getSecondPositionList(int firstPositionId)async{
    try{
      List<dynamic> res = await ReqModel.get(API.GET_SECOND_POSITION_LIST, {"firstPositionId":firstPositionId});
      return Future.value(res);
    }catch (error) {
      print('getFirstPositionList: '+ error.toString());
      return Future.error(error);
    }
  }


  //添加人员
  Future addStaff(AddStaffEntity addStaffEntity)async{
    try{
      var res = await ReqModel.post(API.ADD_USER, addStaffEntity.toJson());
      return Future.value(res);
    }catch (error) {
      print('addStaff error: '+ error.toString());
      return Future.error(error);
    }
  }


}