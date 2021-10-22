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
                children: [
                Padding(
                  padding: const EdgeInsets.only(
                        top: 16, left: 24.0, right: 24.0, bottom: 32),
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
                        height: MediaQuery.of(context).size.height * 0.63,
                        color: ArgonColors.verdeClaro,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                // mainAxisAlignment:
                                // MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Input(
                                        placeholder: "Nombre",
                                      ),
                                    ),
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
                                            onPressed: null)
                                      ],
                                    ),

                                  ],
                                )
                              ],
                            ),
                          )
                        ),
                      )
                    ],
                  ),)
              ],))
        ],
      )
    );
  }

}