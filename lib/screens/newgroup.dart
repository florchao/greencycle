import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:greencycle/constants/Theme.dart';
import 'package:greencycle/widgets/input.dart';
import 'package:greencycle/widgets/navbar.dart';

class NewGroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: "MisGrupos",
          rightOptions: false, tags: [],
        ),
      backgroundColor: ArgonColors.verdeClaro,
      body:Stack(
        children: [
          SafeArea(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                Padding(
                  padding: const EdgeInsets.only(
                        top: 16, left: 24.0, right: 24.0, bottom: 16),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 32),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text('Nuevo grupo',
                              textAlign: TextAlign.right,
                              style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 30)),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        color: ArgonColors.verdeClaro,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: ListView(
                              scrollDirection: Axis.vertical,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Input(
                                    placeholder: "Nombre",
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Image.network("https://images.unsplash.com/photo-1516559828984-fb3b99548b21?ixlib=rb-1.2.1&auto=format&fit=crop&w=2100&q=80"),
                                SizedBox(height: 8.0),
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text('Premios',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 20)
                                          )
                                        ),
                                        SizedBox( height: 8.0),
                                        Input(
                                          placeholder: "1er Puesto",
                                          suffixIcon: Icon(Icons.emoji_events),
                                        ),
                                        SizedBox( height: 8.0),
                                        Input(
                                          placeholder: "2do Puesto",
                                          suffixIcon: Icon(Icons.emoji_events),
                                        ),
                                        SizedBox( height: 8.0),
                                        Input(
                                          placeholder: "3er Puesto",
                                          suffixIcon: Icon(Icons.emoji_events),
                                        )
                                      ],
                                    )
                                ),
                                SizedBox(height: 8.0),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text('Integrantes',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 20)),
                                      ),
                                    ),
                                    FloatingActionButton.small(
                                        tooltip: 'Agregar',
                                        child: const Icon(Icons.add),
                                        backgroundColor: ArgonColors.azul,
                                        onPressed: null
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ),
                      )
                    ],
                  ),
                )
              ],)
          )
        ],
      )
    );
  }

}