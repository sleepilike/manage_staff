import 'dart:collection';
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:registration_admin/common/check.dart';
import 'package:registration_admin/config/const.dart';
import 'package:registration_admin/data/add_staff_repo.dart';
import 'package:registration_admin/data/branch_repo.dart';
import 'package:registration_admin/entity/user_entity.dart';

import 'branch_state_model.dart';

//个人详情页面 编辑页面
class DetailStateModel extends ChangeNotifier{

  bool _state = false;
  bool _isModify = false;
  UserEntity _user;
  AddStaffRepo _addStaffRepo = AddStaffRepo();

  //部门
  List<Department> _departments = [];
  HashMap<int,String > _departmentsHash = HashMap();
  //一级职位
  List<FirstPos> _firstPosList = [];
  HashMap<int,String> _firstPosHash = HashMap();
  //选择一级职位对应的二级职位
  List<SecondPos> _secondPosList = [];
  //所有二级职位
  HashMap<int,String> _allSecondPosHash = HashMap();

  get state =>_state;
  get isModify => _isModify;
  get userEntity => _user;
  get department => _departments;
  get firstPosList => _firstPosList;
  get firstPosHash => _firstPosHash;
  get secondPosList => _secondPosList;
  get allSecondPosHash => _allSecondPosHash;
  get departmentsHash => _departmentsHash;

  //set userEntity(value) => _user = value;

  Future init(UserEntity userEntity) async{
    try{
      _state = false;
      _user = userEntity;
      //获取所有部门
      await _addStaffRepo.getSecondDep().then((value) {
        if (listNoEmpty(value)) {
          _departments = [];
          for (int i = 0; i < value.length; i++) {
            Department ii = new Department();
            ii.id = value[i]["id"];
            ii.name = value[i]["secondDepName"];
            _departments.add(ii);
            _departmentsHash[ii.id] = ii.name;
          }
        }
      });
      //获取一级职位
      await _addStaffRepo.getFirstPositionList().then((value) {
        if (listNoEmpty(value)) {
          _firstPosList = [];
          for (int i = 0; i < value.length; i++) {
            FirstPos ii = new FirstPos();
            ii.id = value[i]["id"];
            ii.name = value[i]["positionName"];
            _firstPosList.add(ii);
            _firstPosHash[ii.id] = ii.name;
          }
        }
      });
      //获取当前用户一级职位对应的二级职位
      await _addStaffRepo.getSecondPositionList(_user.firstPositionId).then((value) {
        if (listNoEmpty(value)) {
          _secondPosList = [];
          for (int i = 0; i < value.length; i++) {
            SecondPos ii = new SecondPos();
            ii.id = value[i]["id"];
            ii.name = value[i]["secondPositionName"];
            _secondPosList.add(ii);
          }
        }
      });
      //获取所有二级部门
      for(int i=0;i<3;i++){
        await _addStaffRepo.getSecondPositionList(i+1).then((value) {
          if (listNoEmpty(value)) {
            for (int i = 0; i < value.length; i++) {
              SecondPos ii = new SecondPos();
              ii.id = value[i]["id"];
              ii.name = value[i]["secondPositionName"];
              _allSecondPosHash[ii.id] = ii.name;
            }
          }
        });
      }
      _state = true;
      notifyListeners();
      return Future.value();
    }catch(error){
      print("DetailStateModel init error:"+error.toString());
      return Future.error(error);
    }

  }

  //用户修改一级职位 所对应的二级职位
  Future getSecondPos(int firstId)async{
    try{
      await _addStaffRepo.getSecondPositionList(firstId).then((value) {
        _secondPosList = [];
        if (listNoEmpty(value)) {
          for (int i = 0; i < value.length; i++) {
            SecondPos ii = new SecondPos();
            ii.id = value[i]["id"];
            ii.name = value[i]["secondPositionName"];
            _secondPosList.add(ii);
          }
        }
      });
      notifyListeners();
    }catch(error){
      print("DetailModel getSecondPos error:"+error.toString());
      return Future.error(error);
    }
  }

  //修改用户信息
  Future modify(UserEntity userEntity)async{
    try {
      await BranchRepo().modifyStaff(userEntity);
      _user = userEntity;
      notifyListeners();
      return Future.value();
    } catch (error) {
      return Future.error(error);
    }

  }
}