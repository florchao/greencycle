import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:greencycle/constants/Theme.dart';
import 'package:greencycle/model/Group.dart';
import 'package:greencycle/model/MyUser.dart';
import 'package:greencycle/services/group_service.dart';
import 'package:greencycle/services/user_service.dart';

class GroupDetail extends StatefulWidget{
  @override
  _CreateGroupDetailState createState() => _CreateGroupDetailState();
}

class _CreateGroupDetailState extends State<GroupDetail> {
  var groupId;
  @override
  void initState(){
    super.initState();
  }

  List<String> names = [];
  List<dynamic> scores = [];
  var membersScoreInAScendingOrder = [];
  late Group group;
  int position = 1;
  List<String> userNamesOrderedByScore = [];
  final GroupService groupService = new GroupService();
  UserService userService = UserService();

  // Future<Group> load(String groupId) async {
  //   await groupService.getGroupById(groupId).then((value) => group = value!);
  //   Map<String, dynamic> membersByScore = order(group.members);
  //   List<String> membersIds = membersByScore.keys.toList();
  //   await getUser(membersIds);
  //   return group;
  // }

  LinkedHashMap<String, dynamic> order(Map<String, dynamic> members) {

    // lista de ids ordenados x score
    var membersIdsSortedByScoreList = members.keys.toList(growable:false)
      ..sort((k1, k2) => members[k2].compareTo(members[k1]));
    // mapa id:score usando el orden de la lista
    LinkedHashMap<String, dynamic> scoresByIdMap = new LinkedHashMap.fromIterable(membersIdsSortedByScoreList, key: (k) => k, value: (k) => members[k]);
    // Map<String, int> map = new Map<String, int>();
    // List membersIdsSortedByScoreList2 = scoresByIdMap.keys.toList();
    // for(var index=0; index < membersIdsSortedByScoreList2.length; index ++){
    //   map[membersIdsSortedByScoreList2[index]] = scoresByIdMap[membersIdsSortedByScoreList2[index]];
    // }
    return scoresByIdMap;
  }

  Future<List<MyUser>> getUser(List<String> list) async {
    List<MyUser> usersByScore = [];
    for(int i=0; i < await list.length; i++) {
     MyUser user =  (await userService.getUser(list[i]))!;
     usersByScore.add(await user);
    }
    return usersByScore;
  }

  Future<Map<String, int>> fetchData(String groupId) async {
    Map<String, int> members = new Map<String, int>();
    await groupService.getGroupById(groupId).then((value) => group = value!);
    LinkedHashMap<String, dynamic> scoresByIdMap = order(group.members);
    List<String> membersIds = scoresByIdMap.keys.toList();
    List<MyUser> usersByScore = [];
    await getUser(membersIds).then((response) =>
        usersByScore = response
    ).whenComplete(() {
        for(int i=0; i<usersByScore.length; i++) {
          members.putIfAbsent(usersByScore[i].name + " " + usersByScore[i].last_name, ()=> scoresByIdMap[usersByScore[i].Id]);
        }
      });
    return members;
  }

  @override
  Widget build(BuildContext context) {
    dynamic arguments = ModalRoute.of(context)!.settings.arguments;
    groupId = arguments["id"];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle grupo"),
        backgroundColor: ArgonColors.verdeOscuro,
      ),
      backgroundColor: ArgonColors.verdeClaro,
      body: Container(
    padding: EdgeInsets.only(right: 24, left: 24, bottom: 36),
    child: SingleChildScrollView(
    child: Column(
    children: [
      FutureBuilder<Map<String, int>>(
        future: fetchData(groupId),
        builder: (BuildContext context, AsyncSnapshot<Map<String, int>> snapshot) {
          if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
            names = snapshot.data!.keys.toList();
            scores = snapshot.data!.values.toList();
            position = 1;
            return Container(
                child: SafeArea(
                    child: Column(
                      children:[
                      Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(padding: const EdgeInsets.only(left: 8.0, top: 32),
                            child: Text('Grupo ' + group.name, style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 20))
                        )
                      ],
                    ),
                        Padding(padding: const EdgeInsets.only(left: 8.0, top: 10, bottom: 10),
                            child: Text(group.description, style: TextStyle(color: ArgonColors.azul, fontSize: 15))
                        ),
                        Image.network(group.icon_url),
                        Divider(
                            height: 50,
                            thickness: 5,
                            color: ArgonColors.verdeOscuro
                        ),
                    Column(
                      children: [
                        for (int i=0; i<3 || i< names.length; i++)
                         ScoreTableRowWidget(i)
                      ],
                    ),
                        Divider(
                            height: 50,
                            thickness: 5,
                            color: ArgonColors.verdeOscuro
                        ),
                        ParticipantsListWidget(),
                      ],
                    )
                )
            );
          } else {
            return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 10.0),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                )
            );
          }
        }
        )
          ]
    ),
    )));
    }
  
  Widget ScoreTableRowWidget(int position){
    Color? color = null;
    if(position < 3) {
      switch (position) {
        case 0:
          color = Colors.orange;
          break;
        case 1:
          color = Colors.blueGrey;
          break;
        case 2:
          color = Colors.brown;
          break;
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.stars, color: color, size: 30),
          Text(names[position], style: TextStyle(fontWeight: FontWeight.bold,
              color: ArgonColors.azul,
              fontSize: 16)),
          Text(scores[position].toString() + ' pts', style: TextStyle(
              fontWeight: FontWeight.bold,
              color: ArgonColors.azul,
              fontSize: 16)),
        ],
      );
    }
    return Row();
  }

  Widget ParticipantsListWidget(){
    return Column(
      children: [
        Text(names.length.toString() + ' Participantes:', style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 15)),
        for(var memberName in names)
          ParticipantsList(memberName),
      ],
    );
  }
  Widget ParticipantsList(String name){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(Icons.person, size:40),
        Text(name, style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 16)),
      ],
    );
  }
}

