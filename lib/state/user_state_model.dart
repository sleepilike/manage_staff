
import 'package:flutter/material.dart';
import 'package:registration_admin/data/user_repo.dart';
import 'package:registration_admin/entity/user_entity.dart';

import 'branch_state_model.dart';

class UserStateModel extends ChangeNotifier {
  UserRepo _repository = UserRepo();
  UserEntity _user;
  bool _autoLogin = false;


  UserEntity get user => _user;

  bool get autoLogin => _autoLogin;

  bool get isLogin => _user != null;

  Future init () async {
    try {
      //BranchStateModel()..init();
      _user = await _repository.init();
      _autoLogin = true;
      notifyListeners();
      return Future.value();
    } catch(error) {
      // 无记录账号密码
    }
  }

  Future login(String identityID) async {
    try {
      _user = await _repository.login(identityID);
      notifyListeners();
      return Future.value();
    } catch (error) {
      return Future.error(error);
    }
  }

  void logout() {
    _repository.logout();
    _user = null;
    _autoLogin = false;
  }
}