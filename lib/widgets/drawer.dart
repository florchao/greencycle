import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:greencycle/constants/Theme.dart';

import 'package:greencycle/widgets/drawer-tile.dart';

class ArgonDrawer extends StatelessWidget {
  final String currentPage;

  ArgonDrawer({required this.currentPage});

  _launchURL() async {
    const url = 'https://creative-tim.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: ArgonColors.verdeOscuro,
      child: Column(children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.85,
            child: SafeArea(
              bottom: false,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 32),
                  // TODO meter imagen del logo de greencycle
                  child: Image.asset("assets/img/fondoVerdeOscuro.jpeg"),
                ),
              ),
            )),
        Expanded(
          flex: 3,
          child: ListView(
            padding: EdgeInsets.only(top: 24, left: 16, right: 16),
            children: [
              ListTile(
                title: const Text("Home"),

                leading: Icon(Icons.home),
                tileColor: Colors.white,
                selectedTileColor: Colors.red,
                  onTap: () {
                    if (currentPage != "Home")
                      Navigator.pushNamed(context, '/home');
                  },
              ),
              ListTile(
                title: const Text("Perfil"),
                leading: Icon(Icons.person),
                tileColor: Colors.white,
                selectedTileColor: Colors.red,
                onTap: () {
                  if (currentPage != "Profile")
                    Navigator.pushNamed(context, '/profile');
                },
              ),
              ListTile(
                title: const Text("Mis Grupos"),
                leading: Icon(Icons.people),
                tileColor: Colors.white,
                selectedTileColor: Colors.red,
                onTap: () {
                  if (currentPage != "MisGrupos")
                    Navigator.pushNamed(context, '/misgrupos');
                },
              ),
              ListTile(
                title: const Text("Mis Acciones"),
                leading: Icon(Icons.category),
                tileColor: Colors.white,
                selectedTileColor: Colors.red,
                onTap: () {
                  if (currentPage != "MisAcciones")
                    Navigator.pushNamed(context, '/misacciones');
                },
              ),
              ListTile(
                title: const Text("Configuracion"),
                leading: Icon(Icons.settings),
                tileColor: Colors.white,
                selectedTileColor: Colors.red,
                onTap: () {
                  if (currentPage != "Settings")
                    Navigator.pushNamed(context, '/settings');
                },
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
              padding: EdgeInsets.only(left: 8, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(height: 4, thickness: 0, color: ArgonColors.azul),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16.0, left: 16, bottom: 8),
                    child: Text("DOCUMENTATION",
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          fontSize: 15,
                        )),
                  ),
                  DrawerTile(
                      icon: Icons.airplanemode_active,
                      onTap: _launchURL,
                      iconColor: ArgonColors.azul,
                      title: "Getting Started",
                      isSelected:
                          currentPage == "Getting started" ? true : false),
                ],
              )),
        ),
      ]),
    ));
  }
}
