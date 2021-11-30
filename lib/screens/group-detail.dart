import 'package:flutter/material.dart';
import 'package:greencycle/constants/Theme.dart';
import 'package:greencycle/widgets/navbar.dart';

class GroupDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle grupo"),
        backgroundColor: ArgonColors.verdeOscuro,
      ),
      backgroundColor: ArgonColors.verdeClaro,
      body: Container(
          child: SafeArea(
              child: Column(
                children: <Widget>[
                  GroupDetailsTitleWidget(),
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
                  ActionsOptionsWidget(),
                  Divider(
                      height: 50,
                      thickness: 5,
                      color: ArgonColors.verdeOscuro
                  ),
                  ParticipantsListWidget(),
                ],
              )
          )
      ),
    );
  }
  Widget GroupDetailsTitleWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(padding: const EdgeInsets.only(left: 8.0, top: 32),
            child: Text("Grupo myGroup", style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 20))
        )
      ],
    );
  }
  Widget ScoreTableWidget(){
    return Column(
      children: [
        ScoreTableRowWidget("Azul", "150 Pts", Colors.orange),
        ScoreTableRowWidget("Felipe", "120 Pts", Colors.blueGrey),
        ScoreTableRowWidget("Malena", "80 Pts", Colors.brown),
      ],
    );
  }
  Widget ScoreTableRowWidget(String name, String points, Color? color){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(Icons.stars, color: color, size: 30),
        Text(name, style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 16)),
        Text(points, style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 16)),
      ],
    );
  }
  Widget ActionsOptionsWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(padding: const EdgeInsets.only(left: 9.0),
            child: Text("Revisar Acciones", style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 18))
        ),
      ],
    );
  }
  Widget ParticipantsListWidget(){
    return Column(
      children: [
        Text('6 Participantes:', style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 15)),
        ParticipantsList("Hernán"),
        ParticipantsList("Malena"),
        ParticipantsList("Felipe"),
        ParticipantsList("Florencia"),
        ParticipantsList("Azul"),
        ParticipantsList("Nicole"),
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