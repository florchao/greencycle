import 'package:flutter/material.dart';

import 'package:greencycle/constants/Theme.dart';
import 'package:greencycle/model/Group.dart';
import 'package:greencycle/model/MyUser.dart';
import 'package:greencycle/services/group_service.dart';
import 'package:greencycle/services/user_service.dart';
import 'package:greencycle/widgets/card-horizontal.dart';
import 'package:greencycle/widgets/drawer.dart';
import 'package:greencycle/widgets/navbar.dart';

final Map<String, Map<String, dynamic>> articlesCards = {
  "Ice Cream": {
    "title": "Ice cream is made with carrageenan …",
    "image":
        "https://images.unsplash.com/photo-1516559828984-fb3b99548b21?ixlib=rb-1.2.1&auto=format&fit=crop&w=2100&q=80"
  },
  "Makeup": {
    "title": "Is makeup one of your daily esse …",
    "image":
        "https://images.unsplash.com/photo-1519368358672-25b03afee3bf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2004&q=80"
  },
  "Coffee": {
    "title": "Coffee is more than just a drink: It’s …",
    "image":
        "https://images.unsplash.com/photo-1500522144261-ea64433bbe27?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2102&q=80"
  },
  "Fashion": {
    "title": "Fashion is a popular style, especially in …",
    "image":
        "https://images.unsplash.com/photo-1487222477894-8943e31ef7b2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1326&q=80"
  },
  "Argon": {
    "title": "Argon is a great free UI packag …",
    "image":
        "https://images.unsplash.com/photo-1482686115713-0fbcaced6e28?fit=crop&w=1947&q=80"
  },
  "Music": {
    "title": "View article",
    "image":
        "https://images.unsplash.com/photo-1501084817091-a4f3d1d19e07?fit=crop&w=2700&q=80",
    "products": [
      {
        "img":
            "https://images.unsplash.com/photo-1501084817091-a4f3d1d19e07?fit=crop&w=2700&q=80",
        "title": "Painting Studio",
        "description":
            "You need a creative space ready for your art? We got that covered.",
        "price": "\$125",
      },
      {
        "img":
            "https://images.unsplash.com/photo-1500628550463-c8881a54d4d4?fit=crop&w=2698&q=80",
        "title": "Art Gallery",
        "description":
            "Don't forget to visit one of the coolest art galleries in town.",
        "price": "\$200",
      },
      {
        "img":
            "https://images.unsplash.com/photo-1496680392913-a0417ec1a0ad?fit=crop&w=2700&q=80",
        "title": "Video Services",
        "description":
            "Some of the best music video services someone could have for the lowest prices.",
        "price": "\$300",
      },
    ],
    "suggestions": [
      {
        "img":
            "https://images.unsplash.com/photo-1511379938547-c1f69419868d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2700&q=80",
        "title": "Music studio for real..."
      },
      {
        "img":
            "https://images.unsplash.com/photo-1477233534935-f5e6fe7c1159?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2700&q=80",
        "title": "Music equipment to borrow..."
      },
    ]
  }
};

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
