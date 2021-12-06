import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:greencycle/constants/Theme.dart';
import 'package:greencycle/model/Group.dart';
import 'package:greencycle/model/MyUser.dart';
import 'package:greencycle/services/group_service.dart';
import 'package:greencycle/services/user_service.dart';
import 'package:greencycle/widgets/drawer.dart';
import 'package:greencycle/widgets/navbar.dart';

final SplayTreeMap<String, String> membersByScore = SplayTreeMap<String, String>();
int position = 1;

class GroupDetail extends StatefulWidget{
  @override
  _CreateGroupDetailState createState() => _CreateGroupDetailState();
}

class _CreateGroupDetailState extends State<GroupDetail> {
  @override
  Widget build(BuildContext context) {
    final String args = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Detalle grupo"),
        backgroundColor: ArgonColors.verdeOscuro,
      ),
      backgroundColor: ArgonColors.verdeClaro,
      drawer: ArgonDrawer(currentPage: "Detalle grupo"),
      body: FutureBuilder<Group?>(
        future: GroupService().getGroupById('pGy9z1cTLqQYTX76SM7D'),
        builder: (BuildContext context, AsyncSnapshot<Group?> snapshot) {
          if (snapshot.hasData) {
            Group? groupData = snapshot.data!;
            getMembersNames(groupData.members);
            print(membersByScore);
            return Container(
                child: SafeArea(
                    child: Column(
                      children: <Widget>[
                        GroupDetailsTitleWidget(groupData.name),
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

  void getMembersNames(Map<String, dynamic> members) async {
    for (var id in members.keys){
      var userScoreInGroup = members[id];
      MyUser? user = await UserService().getUser(id);
      setState(() {
        membersByScore[userScoreInGroup] = user!.name;
      });
    }
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
