
import 'dart:core';

class MyUser{
  String name;
  String last_name;
  String Id;
  String? icon_url;
  String email;
  int score;
  List<String> groups;
  List<String> actions;
  static const String collection_id = 'Usuario';

  MyUser(this.name, this.last_name, this.Id, this.icon_url, this.email,)
      : this.groups = [],
        this.actions = [],
        //this.weekly_score = " ",
        this.score = 0;


  MyUser.fromSnapshot(String Id, Map<String, dynamic> user)
      : Id = Id,
        name = user['name'],
        last_name = user['last_name'],
        email = user['email'],
        icon_url = user['icon_url'],
        groups = List.from(user['groups']),
        actions = List.from(user['actions']),
        score = user['score'];

  Map<String, dynamic> toMap() => {
    'name': name,
    'last_name': last_name,
    'email': email,
    'icon_url': icon_url,
    'groups': groups,
    'actions' : actions,
    'score': score,
  };

  @override
  String toString() {
    return 'user{id: $Id, nombres: $name, apellidos: $last_name, email: $email, iconURL:$icon_url, score: $score, groups: $groups}';
  }


}