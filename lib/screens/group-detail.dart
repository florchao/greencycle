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
  Group? group = new Group('', '', '', '', '', '');
  int position = 1;
  final GroupService groupService = new GroupService();
  UserService userService = UserService();

  Future<Map<int, String>> load(String groupId) async {
    Group? group = await groupService.getGroupById(groupId);
    print("mi grupo");
    print(group);
    Map<String, dynamic> members = group!.members;
    print(members);
    // var keys = members.keys;
    // print(keys);
    List<String> keys = members.entries.map( (entry) => entry.key).toList();
    print(keys);
    for(int i=0; i < keys.length; i++) {
      String id = keys[i];
      var userScoreInGroup = members[id];
      MyUser? user = await userService.getUser(id);
      print("mi user");
      print(user);
      if (user != null) {
        print("ADENTRO");
        membersNamesByScore[i] = user.name;
      }
    }
    // var topThree = bestThree(membersNamesByScore);
    print("FINAL");
    print(membersNamesByScore);
    return membersNamesByScore;
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
      body: FutureBuilder<Map<int, String>>(
        future: load(groupId),
        builder: (BuildContext context, AsyncSnapshot<Map<int, String>> snapshot) {
          if (snapshot.hasData) {
            // membersScoreInAScendingOrder.sort((a, b) => a.compareTo(b));
            print("SNAP");
            print(snapshot);
            return Container(
                child: SafeArea(
                    child: Column(
                      children: <Widget>[
                        GroupDetailsTitleWidget(group!.name),
                        Divider(
                            height: 50,
                            thickness: 5,
                            color: ArgonColors.verdeOscuro
                        ),
                        ScoreTableWidget(),
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
        }));
    }

  Widget GroupDetailsTitleWidget(String title){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(padding: const EdgeInsets.only(left: 8.0, top: 32),
            child: Text('Grupo $title', style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 20))
        )
      ],
    );
  }

  Widget ScoreTableWidget(){
    return Column(
      children: [
        for (var score in membersScoreInAScendingOrder)
          if(position < 3)
            ScoreTableRowWidget(membersNamesByScore[score], score.toString(), position++)
      ],
    );
  }
  
  Widget ScoreTableRowWidget(String? name, String score, int position){
    Color? color = null;
    switch(position){
      case 1: color = Colors.orange; break;
      case 2: color = Colors.blueGrey; break;
      case 3: color = Colors.brown; break;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(Icons.stars, color: color, size: 30),
        Text(name!, style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 16)),
        Text(score + ' pts', style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 16)),
      ],
    );
  }

  Widget ParticipantsListWidget(){
    return Column(
      children: [
        Text(membersNamesByScore.length.toString() + ' Participantes:', style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 15)),
        for(var memberName in membersNamesByScore.values)
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

