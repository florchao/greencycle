import 'package:flutter/material.dart';

import 'package:greencycle/constants/Theme.dart';

//widgets
import 'package:greencycle/widgets/navbar.dart';
import 'package:greencycle/widgets/card-small.dart';
import 'package:greencycle/widgets/drawer.dart';

final Map<String, Map<String, String>> homeCards = {
  "Ice Cream": {
    "title": "Ice cream is made with carrageenan …",
    "image": "https://images.unsplash.com/photo-1516559828984-fb3b99548b21?ixlib=rb-1.2.1&auto=format&fit=crop&w=2100&q=80"
  },
  "Makeup": {
    "title": "Is makeup one of your daily esse …",
    "image": "https://images.unsplash.com/photo-1519368358672-25b03afee3bf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2004&q=80"
  },
  "Coffee": {
    "title": "Coffee is more than just a drink: It’s …",
    "image": "https://images.unsplash.com/photo-1500522144261-ea64433bbe27?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2102&q=80"
  },
  "Fashion": {
    "title": "Fashion is a popular style, especially in …",
    "image": "https://images.unsplash.com/photo-1487222477894-8943e31ef7b2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1326&q=80"
  },
  "Argon": {
    "title": "Argon is a great free UI packag …",
    "image": "https://images.unsplash.com/photo-1482686115713-0fbcaced6e28?fit=crop&w=1947&q=80"
  }
};

class Home extends StatefulWidget {
  // final GlobalKey _scaffoldKey = new GlobalKey();
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: Navbar(
        //   title: "",
        //   tags: [],
        // ),
      appBar: AppBar(
        title: const Text("Menú"),
        backgroundColor: ArgonColors.verdeOscuro,
      ),
        backgroundColor: ArgonColors.verdeClaro,
        // key: _scaffoldKey,
        drawer: ArgonDrawer(currentPage: "Home"),
        body: Container(
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                ),
                Row(
                  children:const [
                Text(
                  'Mis grupos',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 20),
                ),
                    Text(''),
                ]
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CardSmall(
                        cta: "View article",
                        title: homeCards['Makeup']!['title'] ?? "",
                        img: homeCards["Makeup"]!['image'] ?? "",
                        tap: () {
                        }),
                    CardSmall(
                        cta: "View article",
                        title: homeCards["Coffee"]!['title'] ?? "",
                        img: homeCards["Coffee"]!['image'] ?? "",
                        tap: () {}
                        )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  onPressed: () { Navigator.pushNamed(context, '/create-action');},
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                ),
                SizedBox(height: 8.0),
                  ],
        ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CardSmall(
                        cta: "View article",
                        title: homeCards['Makeup']!['title'] ?? "",
                        img: homeCards["Makeup"]!['image'] ?? "",
                        tap: () {
                          Navigator.pushNamed(context, '/pro');
                        }),
                    CardSmall(
                        cta: "View article",
                        title: homeCards["Coffee"]!['title'] ?? "",
                        img: homeCards["Coffee"]!['image'] ?? "",
                        tap: () {
                          Navigator.pushNamed(context, '/pro');
                        })
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }
}
