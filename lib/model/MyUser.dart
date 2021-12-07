
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greencycle/model/Group.dart';
import 'package:greencycle/model/MyAction.dart';
import 'package:greencycle/services/action_service.dart';
import 'package:greencycle/services/group_service.dart';

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

  List<MyAction?>? getActions(){
    ActionService actionService = new ActionService();
    List<MyAction?>? auxActions;
    actions.forEach((element)  async {
      MyAction? action = await actionService.getAction(element);
      auxActions!.add(action);
    });
    return auxActions;
  }

  List<Group?>? getGroups(){
    GroupService groupService = new GroupService();
    List<Group?>? auxGroups;
    groups.forEach((element)  async {
      Group? group = await groupService.getGroupById(element);
      auxGroups!.add(group);
    });
    return auxGroups;
  }

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