import 'package:flutter/material.dart';

import 'package:greencycle/constants/Theme.dart';
import 'package:greencycle/model/Group.dart';
import 'package:greencycle/model/MyAction.dart';
import 'package:greencycle/model/MyUser.dart';
import 'package:greencycle/services/action_service.dart';
import 'package:greencycle/services/group_service.dart';
import 'package:greencycle/services/user_service.dart';

import 'package:greencycle/widgets/card-small.dart';
import 'package:greencycle/widgets/drawer.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String groupId = 'pGy9z1cTLqQYTX76SM7D';
  final GroupService groupService = new GroupService();
  UserService userService = UserService();
  String? code;
  Future<List<Group>>? loading;
  final ActionService actionService = new ActionService();
  Future<List<MyAction>>? loading2;

  @override
  void initState() {
    super.initState();
    loading = load();
    loading2 = load2();
  }

  Future<List<Group>> getGroups(MyUser myUser) async {
    List<Group> homeCards = [];
    if (myUser.groups.isNotEmpty) {
      int length = myUser.groups.length;
      if(length>2) {
        await groupService.getGroupById(myUser.groups[length - 1]).then((
            value1) =>
        {
          if (value1 != null) {homeCards.add(value1)}
        });
        await groupService.getGroupById(myUser.groups[length - 2]).then((
            value1) =>
        {
          if (value1 != null) {homeCards.add(value1)}
        });
      }
      if(length == 1){
        await groupService.getGroupById(myUser.groups[length - 1]).then((
            value1) =>
        {
          if (value1 != null) {homeCards.add(value1)}
        });
      }
      print(myUser.groups[length-1]);

    }
    return homeCards;
  }

  Future<List<MyAction>> load2() async {
    late List<MyAction> homeCards;
    await userService.getCurrentUser().then((value) async => {
      homeCards = await getActions(value!),
    });
    print("LOAD2");
    print(homeCards);
    return homeCards;
  }

  Future<List<MyAction>> getActions(MyUser myUser) async {
    List<MyAction> homeCards = [];
    if (myUser.actions.isNotEmpty) {
      int length = myUser.actions.length;
      print(length);
      if(length>2) {
        await actionService.getAction(myUser.actions[length - 2]).then((
            value1) =>
        {
          if (value1 != null) {homeCards.add(value1)}
        });
        await actionService.getAction(myUser.actions[length - 1]).then((
            value1) =>
        {
          if (value1 != null) {homeCards.add(value1)}
        });
      }
      if(length == 1){
        await actionService.getAction(myUser.actions[length - 1]).then((
            value1) =>
        {
          if (value1 != null) {homeCards.add(value1)}
        });
      }
      print("ACCION");
      print(myUser.actions[length-1]);

    }
    return homeCards;
  }

  Future<List<Group>> load() async {
    late List<Group> homeCards;
    await userService.getCurrentUser().then((value) async => {
      homeCards = await getGroups(value!),
    });
    return homeCards;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menú"),
        backgroundColor: ArgonColors.verdeOscuro,
      ),
        backgroundColor: ArgonColors.verdeClaro,
        // key: _scaffoldKey,
        drawer: ArgonDrawer(currentPage: "Home"),
        body: Container(
          height: size.height*0.9,
          width: size.width,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                ),
                Row(
                  children: [
                  const Text(
                    'Mis grupos',
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
                      onPressed: () { Navigator.pushNamed(context, '/newgroup');},
                    )
                ]
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                ),
                const SizedBox(height: 8.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FutureBuilder<List<Group>>(
                        future: loading,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Group>> snapshot) {
                          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                            print(snapshot.data);
                            return SizedBox(
                              height: size.height * 0.3 ,
                              width: size.width * 0.8,
                              child: Row(
                                children: <Widget>[
                                  for (var group in snapshot.data!)
                                    CardSmall(
                                        cta: group.description,
                                        title: group.name,
                                        img: group.icon_url,
                                        tap: () {
                                          Navigator.pushNamed(
                                              context, '/group-detail');
                                        })
                                ],
                              ),
                            );
                          } else {
                            return Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(top: 30.0),
                              child: Text("No tienes grupos",
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 19.0,
                                      color: Colors.black45)),
                            );
                          }
                        })
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                ),
                Row(
                  children:[
                    const Text(
                      'Últimas acciones',
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
                  onPressed: () {
                  Navigator.pushNamed(context, '/create-action');},
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                ),
                SizedBox(height: 8.0),
                  ],
        ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FutureBuilder<List<MyAction>>(
                        future: loading2,
                        builder: (BuildContext context, AsyncSnapshot<List<MyAction>> snapshot) {
                          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                            print(snapshot.data);
                            return SizedBox(
                              height: size.height * 0.3 ,
                              width: size.width * 0.8,
                              child: Row(
                                children: <Widget>[
                                  for (var action in snapshot.data!)
                                    CardSmall(
                                        cta: action.description,
                                        title: action.name,
                                        img: action.icon_url,
                                        tap: () {
                                          Navigator.pushNamed(
                                              context, '/action-detail');
                                        })
                                ],
                              ),
                            );
                          } else {
                            return Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(top: 30.0),
                              child: Text("No tienes grupos",
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 19.0,
                                      color: Colors.black45)),
                            );
                          }
                        })
                  ],
                ),
              ],
            ),
          ),
    );
  }
}
