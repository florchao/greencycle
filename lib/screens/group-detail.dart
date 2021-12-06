import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:greencycle/constants/Theme.dart';
import 'package:greencycle/model/Group.dart';
import 'package:greencycle/model/MyUser.dart';
import 'package:greencycle/services/group_service.dart';
import 'package:greencycle/services/user_service.dart';
import 'package:greencycle/widgets/drawer.dart';

SplayTreeMap<String, String> membersByScore = SplayTreeMap<String, String>();
Group? group = new Group('', '', '');
int position = 1;

class GroupDetail extends StatefulWidget{
  @override
  _CreateGroupDetailState createState() => _CreateGroupDetailState();
}

class _CreateGroupDetailState extends State<GroupDetail> {
  final GroupService groupService = new GroupService();
  UserService userService = UserService();

  Future<SplayTreeMap<String, String>> load(String groupId) async {
    await groupService.getGroupById(groupId).then((value) => group = value);
    Map<String, dynamic> members = group!.members;
    for (var id in members.keys){
      print(id);
      var userScoreInGroup = members[id];
      print(userScoreInGroup);
      MyUser? user = await userService.getUser(id);
      if(user!=null){
        membersByScore[userScoreInGroup] = user.name;
      }
    }
    return membersByScore;
  }

  @override
  Widget build(BuildContext context) {
    final String groupId = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Detalle grupo"),
        backgroundColor: ArgonColors.verdeOscuro,
      ),
      backgroundColor: ArgonColors.verdeClaro,
      body: FutureBuilder<SplayTreeMap<String, String>>(
        future: load(groupId),
        builder: (BuildContext context, AsyncSnapshot<SplayTreeMap<String, String>> snapshot) {
          if (snapshot.hasData) {
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
        for (var score in membersByScore.keys)
          if(position < 3)
            ScoreTableRowWidget(membersByScore[score], score.toString(), position++)
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
        Text(membersByScore.length.toString() + ' Participantes:', style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 15)),
        for(var memberName in membersByScore.values)
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
