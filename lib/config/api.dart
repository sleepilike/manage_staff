class API {
  // 请求的url
  static const reqUrl = 'http://120.79.185.173:8080/check/';

  static const LOGIN = 'common/login';

  //机构和职位列表获取
  static const GET_FIRST_POSITIONLIST = 'department/getFirstPositionList';
  static const GET_SECOND_DEP = 'department/getSecondDep';
  static const GET_SECOND_POSITION_LIST = 'department/getSecondPositionList';

  //
  static const ADD_USER = 'admin/addUser';

  static const GET_USERS = 'admin/getUsers';
  static const DELETE_USER = 'admin/deleteUser';
  static const MODIFY_USER = 'admin/modifyUser';

  static const ADD_NEW_DEPARTMENT = 'admin/addNewDepartment';
  static const DELETE_DEPARTMENT = 'admin/deleteDepartment';

}

