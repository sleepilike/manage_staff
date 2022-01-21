import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:registration_admin/common/check.dart';
import 'package:registration_admin/config/const.dart';
import 'package:registration_admin/data/add_staff_repo.dart';
import 'package:registration_admin/entity/add_staff_entity.dart';

class AddStateModel extends ChangeNotifier{


  AddStaffRepo _addStaffRepo = AddStaffRepo();
  AddStaffEntity _addStaffEntity = new AddStaffEntity();
  //部门
  List<Department> _departments = [];
  //一级职位
  List<FirstPos> _firstPosList = [];
  HashMap<int,String> _firstPosHash = HashMap();
  //选择一级职位对应的二级职位
  List<SecondPos> _secondPosList = [];
  //所有二级职位
  HashMap<int,String> _allSecondPosHash = HashMap();

  bool _state = false;


  AddStaffEntity get addStaffEntity => _addStaffEntity;
  List<Department> get departments =>_departments;
  List<FirstPos> get firstPosLis => _firstPosList;
  HashMap<int,String> get firstPosHash => _firstPosHash;
  List<SecondPos> get secondPosList => _secondPosList;
  HashMap<int,String> get allSecondPosHash => _allSecondPosHash;
  bool get state => _state;

  Future init () async {
    try {
      _state = false;
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


      await _addStaffRepo.getSecondPositionList(3).then((value) {
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
    } catch(error) {
      print("AddStaffModel init error:"+error.toString());
      return Future.error(error);
    }
  }

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
      print("AddStaffModel getSecondPos error:"+error.toString());
      return Future.error(error);
    }
  }




}