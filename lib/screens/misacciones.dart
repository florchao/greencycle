import 'package:flutter/material.dart';

import 'package:greencycle/constants/Theme.dart';
import 'package:greencycle/model/MyAction.dart';
import 'package:greencycle/model/MyUser.dart';
import 'package:greencycle/screens/misgrupos.dart';
import 'package:greencycle/services/action_service.dart';
import 'package:greencycle/services/user_service.dart';
import 'package:greencycle/widgets/card-horizontal.dart';
import 'package:greencycle/widgets/drawer.dart';
import 'package:greencycle/widgets/navbar.dart';

class MisAcciones extends StatefulWidget {
  @override
  State<MisAcciones> createState()=>_MisAccionesState();
}
class _MisAccionesState extends State<MisAcciones>{

  final ActionService actionService = new ActionService();
  UserService userService = UserService();
  String? code;
  Future<List<MyAction>>? loading;

  @override
  void initState() {
    super.initState();
    loading = load();
  }

  Future<List<MyAction>> getActions(MyUser myUser) async {
    List<MyAction> homeCards = [];
    if (myUser.actions.isNotEmpty) {
      for (var actionsId in myUser.actions) {
        await actionService.getAction(actionsId).then((value1) => {
          if (value1 != null) {homeCards.add(value1)}
        });
      }
    }
    return homeCards;
  }

  Future<List<MyAction>> load() async {
    late List<MyAction> homeCards;
    await userService.getCurrentUser().then((value) async => {
      homeCards = await getActions(value!),
    });
    return homeCards;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Mis Acciones"),
          backgroundColor: ArgonColors.verdeOscuro,
        ),
        backgroundColor: ArgonColors.verdeClaro,
        drawer: ArgonDrawer(currentPage: "Mis Acciones"),
        body: Container(
            padding: EdgeInsets.only(right: 24, left: 24, bottom: 36),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 15),
                    child: Row(
                      children:[
                      const Text(
                      'Mis acciones',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 20),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          primary:  ArgonColors.azul
                      ),
                      child: Text(
                          '+',
                          style: TextStyle(fontSize: 24),
                        ),
                      onPressed: () { Navigator.pushNamed(context, '/create-action');},
                    ),
                  ]),
        ),FutureBuilder<List<MyAction>>(
                      future: loading,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<MyAction>> snapshot) {
                        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                          return SizedBox(
                            child: Column(
                              children: <Widget>[
                                for (var action in snapshot.data!)
                                  CardHorizontal(
                                      cta: "Ver acción",
                                      title: action.name,
                                      img: action.icon_url,
                                      tap: () {
                                        Navigator.pushNamed(
                                            context, '/action-detail', arguments: action.id);
                                      })
                              ],
                            ),
                          );
                        } else {
                          return Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Text("No tienes acciones",
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 19.0,
                                    color: Colors.black45)),
                          );
                        }
                      }),
                ],
              ),
            )));
  }
}
