
import 'dart:core';
import 'package:greencycle/model/Group.dart';

class MyUser{
  String name;
  String last_name;
  String Id;
  String? icon_url;
  String email;
  String score;
  //String weekly_score;
  Map<String,dynamic> groups;
  static const String collection_id = 'Usuario';

  MyUser(this.name, this.last_name, this.Id, this.icon_url, this.email,)
      : this.groups = Map(),
        //this.weekly_score = " ",
        this.score = " ";


  MyUser.fromSnapshot(String Id, Map<String, dynamic> user)
      : Id = Id,
        name = user['name'],
        last_name = user['last_name'],
        email = user['email'],
        icon_url = user['icon_url'],
        groups = user['groups'],
        //weekly_score = user['weekly_score'],
        score = user['score'];

  Map<String, dynamic> toMap() => {
    'name': name,
    'last_name': last_name,
    'email': email,
    'iconURL': icon_url,
    'groups': groups,
    //'weekly_score': weekly_score,
    'score': score,
  };

  @override
  String toString() {
    return 'user{id: $Id, nombres: $name, apellidos: $last_name, email: $email, iconURL:$icon_url}';
  }


}