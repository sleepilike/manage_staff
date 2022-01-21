class AddStaffEntity {
  int firstDepId;
  int firstPositionId;
  int gender;
  int id;
  String indentityId;
  String job;
  String name;
  String phoneNum;
  String regTime;
  int roleId;
  int secondDepId;
  int secondPositionId;
  int status;
  String username;
  String wechatAccount;
  String wechatId;
  String wokeCurAdd;

  AddStaffEntity(
      {this.firstDepId,
        this.firstPositionId,
        this.gender,
        this.id,
        this.indentityId,
        this.job,
        this.name,
        this.phoneNum,
        this.regTime,
        this.roleId,
        this.secondDepId,
        this.secondPositionId,
        this.status,
        this.username,
        this.wechatAccount,
        this.wechatId,
        this.wokeCurAdd
      });

  AddStaffEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gender = json['gender'];
    username = json['username'];
    name = json['name'];
    phoneNum = json['phoneNum'];
    wechatAccount = json['wechatAccount'];
    wechatId = json['wechatId'];
    regTime = json['regTime'];
    indentityId = json['indentityId'];
    job = json['job'];
    firstPositionId = json['firstPositionId'];
    secondPositionId = json['secondPositionId'];
    firstDepId = json['firstDepId'];
    secondDepId = json['secondDepId'];
    roleId = json['roleId'];
    wokeCurAdd = json['wokeCurAdd'];
    status = json['status'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gender'] = this.gender;
    data['username'] = this.username;
    data['name'] = this.name;
    data['phoneNum'] = this.phoneNum;
    data['wechatAccount'] = this.wechatAccount;
    data['wechatId'] = this.wechatId;
    data['regTime'] = this.regTime;
    data['indentityId'] = this.indentityId;
    data['job'] = this.job;
    data['firstPositionId'] = this.firstPositionId;
    data['secondPositionId'] = this.secondPositionId;
    data['firstDepId'] = this.firstDepId;
    data['secondDepId'] = this.secondDepId;
    data['roleId'] = this.roleId;
    data['wokeCurAdd'] = this.wokeCurAdd;
    data['status'] = this.status;
    return data;
  }
}