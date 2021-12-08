import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:greencycle/constants/Theme.dart';

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
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double screenWidth = queryData.size.width;
    return Drawer(
        child: Container(
      color: ArgonColors.verdeOscuro,
      child: Column(children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.2 ,
            width: MediaQuery.of(context).size.width,
            child: SafeArea(
              bottom: false,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 32),
                  // Todo Hacer que la imagen este centrada
                  child: Image.asset("assets/img/VerdeOscuroLogo.jpeg",scale: 1, alignment: Alignment.center),
                ),
              ),
            )),
        Expanded(
          flex: 3,
          child: ListView(
            padding: EdgeInsets.only(top:16, left: 16, right: 16),
            children: [
              ListTile(
                title: Text("Menú", style: TextStyle(
                  letterSpacing: .3,
                  fontSize: 15,
                  color: ((currentPage == "Home") ? ArgonColors.azul: ArgonColors.white),
                )),
                leading: Icon(Icons.home, color: ((currentPage == "Home") ? ArgonColors.azul: ArgonColors.white),),
                  selected: (currentPage == "Home" ? true: false),
                  selectedTileColor: ArgonColors.verdeClaro,
                  onTap: () {
                    if (currentPage != "Home") {
                      Navigator.popAndPushNamed(context, '/home');
                    }
                    else {
                      Navigator.pop(context);
                    }
                  },
              ),
              ListTile(
                title: Text("Perfil", style: TextStyle(
                  letterSpacing: .3,
                  fontSize: 15,
                  color: ((currentPage == "Profile") ? ArgonColors.azul: ArgonColors.white),
                )),
                leading: Icon(Icons.person, color: ((currentPage == "Profile") ? ArgonColors.azul: ArgonColors.white),),
                // selected: ((currentPage == "Mi Perfil") ? true: false),
                selectedTileColor: ArgonColors.verdeClaro,
                onTap: () {
                  if (currentPage != "Profile")
                    Navigator.popAndPushNamed(context, '/profile');
                  else {
                    Navigator.pop(context);
                  }
                },
              ),
              ListTile(
                title: Text("Mis Grupos", style: TextStyle(
                  letterSpacing: .3,
                  fontSize: 15,
                  color: ((currentPage == "Mis Grupos") ? ArgonColors.azul: ArgonColors.white),
                )),
                leading: Icon(Icons.people, color: ((currentPage == "Mis Grupos") ? ArgonColors.azul: ArgonColors.white),),
                selected: ((currentPage == "Mis Grupos") ? true: false),
                selectedTileColor: ArgonColors.verdeClaro,
                onTap: () {
                  if (currentPage != "MisGrupos")
                    Navigator.popAndPushNamed(context, '/misgrupos');
                  else {
                    Navigator.pop(context);
                  }
                },
              ),
              ListTile(
                title: Text("Mis Acciones", style: TextStyle(
                  letterSpacing: .3,
                  fontSize: 15,
                  color: ((currentPage == "Mis Acciones") ? ArgonColors.azul: ArgonColors.white),
                )),
                leading: Icon(Icons.category, color: ((currentPage == "Mis Acciones") ? ArgonColors.azul: ArgonColors.white),),
                selected: ((currentPage == "Mis Acciones") ? true: false),
                selectedTileColor: ArgonColors.verdeClaro,
                onTap: () {
                  if (currentPage != "Mis Acciones")
                    Navigator.popAndPushNamed(context, '/misacciones');
                  else {
                    Navigator.pop(context);
                  }
                },
              ),
              ListTile(
                title: Text("Configuración", style: TextStyle(
                  letterSpacing: .3,
                  fontSize: 15,
                  color: ((currentPage == "Configuración") ? ArgonColors.azul: ArgonColors.white),
                )),
                leading: Icon(Icons.settings, color: ((currentPage == "Configuración") ? ArgonColors.azul: ArgonColors.white),),
                selected: ((currentPage == "Configuración") ? true: false),
                selectedTileColor: ArgonColors.verdeClaro,
                onTap: () {
                  print(currentPage);
                  if (currentPage != "Configuración")
                    Navigator.popAndPushNamed(context, '/settings');
                  else {
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
        /*Expanded(
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
        ),*/
      ]),
    ));
  }
}
