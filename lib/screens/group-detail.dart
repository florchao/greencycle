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
  Map<int, String> membersNamesByScore = {};
  var membersScoreInAScendingOrder = [];
  late Group group;
  int position = 1;
  List<MyUser> names = [];
  final GroupService groupService = new GroupService();
  UserService userService = UserService();

  Future<Group> load(String groupId) async {
    await groupService.getGroupById(groupId).then((value) => group = value!);
    return group;
  }

  order(Map<String, dynamic> list){
    var sortedKeys = list.keys.toList(growable:false)
      ..sort((k1, k2) => list[k2].compareTo(list[k1]));
    LinkedHashMap sortedMap = new LinkedHashMap.fromIterable(sortedKeys, key: (k) => k, value: (k) => list[k]);
    Map<String, int> map = new Map<String, int>();
    List keysSortedMap = sortedMap.keys.toList();
    for(var index=0; index < keysSortedMap.length; index ++){
      map[keysSortedMap[index]] = sortedMap[keysSortedMap[index]];
    }
    return map;
  }

  getUser(List<String> list)async{
    for(int i=0; i < await list.length; i++) {
     MyUser user =  (await userService.getUser(list[i]))!;
     names.add(await user);
    }
    return names;
  }

  @override
  Widget build(BuildContext context) {
    final String groupId = ModalRoute.of(context)!.settings.arguments as String;
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
      FutureBuilder<Group>(
        future: load(groupId),
        builder: (BuildContext context, AsyncSnapshot<Group> snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> membersByScore = order(snapshot.data!.members);
            List<String> list = membersByScore.keys.toList();
            getUser(list);
            position =1;
            return Container(
                child: SafeArea(
                    child: Column(
                      children:[
                      Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(padding: const EdgeInsets.only(left: 8.0, top: 32),
                            child: Text('Grupo ' + snapshot.data!.name, style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 20))
                        )
                      ],
                    ),
                        Padding(padding: const EdgeInsets.only(left: 8.0, top: 10, bottom: 10),
                            child: Text(snapshot.data!.description, style: TextStyle(color: ArgonColors.azul, fontSize: 15))
                        ),
                        Image.network(snapshot.data!.icon_url),
                        Divider(
                            height: 50,
                            thickness: 5,
                            color: ArgonColors.verdeOscuro
                        ),
                    Column(
                      children: [
                         for (var index in names)
                             ScoreTableRowWidget(index.name, membersByScore[index.Id], position++)
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
  
  Widget ScoreTableRowWidget(String? name, int score, int position){
    print("ENTRA");
    print(position);
    Color? color = null;
    if(position <= 3) {
      switch (position) {
        case 1:
          color = Colors.orange;
          break;
        case 2:
          color = Colors.blueGrey;
          break;
        case 3:
          color = Colors.brown;
          break;
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.stars, color: color, size: 30),
          Text(name!, style: TextStyle(fontWeight: FontWeight.bold,
              color: ArgonColors.azul,
              fontSize: 16)),
          Text(score.toString() + ' pts', style: TextStyle(
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
          ParticipantsList(memberName.name + " " + memberName.last_name),
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

