
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:registration_admin/common/check.dart';
import 'package:registration_admin/config/const.dart';
import 'package:registration_admin/data/add_staff_repo.dart';
import 'package:registration_admin/data/branch_repo.dart';
import 'package:registration_admin/entity/user_entity.dart';

//部门管理部分 数据以及状态
class BranchStateModel extends ChangeNotifier{
  AddStaffRepo _addStaffRepo = AddStaffRepo();
  BranchRepo _branchRepo = BranchRepo();
  List<UserEntity> _allUsers = [];
  List<Department> _departments =[];
  HashMap<int,Set<UserEntity>> _hashDepartment = HashMap();

  bool _isModify = false;
  bool _open = true;


  bool _state = false;

  get departments => _departments;
  //get userList => _userList;
  get allUsers => _allUsers;
  get state => _state;
  get isModify => _isModify;
  get hashDepartment => _hashDepartment;
  get open => _open;

  Future init() async{
    try{
      _state = false;
      //获取部门
       await _addStaffRepo.getSecondDep().then((value) {
        if (listNoEmpty(value)) {
          _departments = [];
          for (int i = 0; i < value.length; i++) {
            Department ii = new Department();
            ii.id = value[i]["id"];
            ii.name = value[i]["secondDepName"];
            _departments.add(ii);
          }
        }
      });
       //减少请求次数 获取所有人员
       _allUsers = await _branchRepo.getStaff();
       int l = _departments.length;

       for(int i =0 ;i<l;i++){
         _hashDepartment[_departments[i].id] = new Set();
       }
       for(int i =0;i<_allUsers.length;i++){
         int depId = _allUsers[i].secondDepId;
         if(_hashDepartment[depId] == null){
           _hashDepartment[depId] = new Set();
         }
         _hashDepartment[depId].add(_allUsers[i]);
       }
       _state = true;

       notifyListeners();
    }catch(error){
      print("BranchStateModel init error："+error.toString());
      return Future.error(error);
    }
  }

  //删除人员
  Future delete(int id)async{
    try {
      await _branchRepo.deleteStaff(id);
      init();
      notifyListeners();
      return Future.value();
    } catch (error) {
      return Future.error(error);
    }
  }



  //部门编辑
  editDep(bool isModify){
    _isModify = isModify;
    notifyListeners();
  }
}