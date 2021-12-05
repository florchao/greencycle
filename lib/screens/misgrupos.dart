import 'package:flutter/material.dart';

import 'package:greencycle/constants/Theme.dart';
import 'package:greencycle/model/Group.dart';
import 'package:greencycle/model/MyUser.dart';
import 'package:greencycle/services/group_service.dart';
import 'package:greencycle/services/user_service.dart';
import 'package:greencycle/widgets/card-horizontal.dart';
import 'package:greencycle/widgets/drawer.dart';
import 'package:greencycle/widgets/navbar.dart';

class MisGrupos extends StatefulWidget {
  @override
  State<MisGrupos> createState() => _MisGruposState();
}

class _MisGruposState extends State<MisGrupos> {
  final GroupService groupService = new GroupService();
  UserService userService = UserService();
  String? code;
  Future<List<Group>>? loading;

  @override
  void initState() {
    super.initState();
    loading = load();
  }

  Future<List<Group>> getGroups(MyUser myUser) async {
    List<Group> homeCards = [];
    if (myUser.groups.isNotEmpty) {
      for (var groupId in myUser.groups) {
        await groupService.getGroupById(groupId).then((value1) => {
              if (value1 != null) {homeCards.add(value1)}
            });
      }
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
          title: const Text("Mis Grupos"),
          backgroundColor: ArgonColors.verdeOscuro,
        ),
        backgroundColor: ArgonColors.verdeClaro,
        drawer: ArgonDrawer(currentPage: "Mis Grupos"),
        body: Container(
            padding: EdgeInsets.only(right: 24, left: 24, bottom: 36),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 15),
                    child: Row(children: [
                      const Text(
                        'Mis grupos',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ArgonColors.azul,
                            fontSize: 20),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            primary: ArgonColors.azul),
                        child: Text(
                          '+',
                          style: TextStyle(fontSize: 24),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/newgroup');
                        },
                      ),
                    ]),
                  ),
                  FutureBuilder<List<Group>>(
                      future: loading,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Group>> snapshot) {
                        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                          return SizedBox(
                            height: size.height * 0.9,
                            child: Column(
                              children: <Widget>[
                                for (var group in snapshot.data!)
                                  CardHorizontal(
                                      cta: "Ver grupo",
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
            )));
  }
}
