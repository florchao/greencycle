import 'package:flutter/material.dart';

import 'package:greencycle/constants/Theme.dart';
import 'package:greencycle/widgets/input.dart';

//widgets
import 'package:greencycle/widgets/navbar.dart';

import 'package:greencycle/widgets/drawer.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ArgonColors.verdeClaro,
        appBar: Navbar(
          title: "Configuración",
          bgColor: ArgonColors.verdeOscuro, tags: [],
        ),
        body:  Container(
            color: ArgonColors.verdeClaro,
            child: Center(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  mainAxisAlignment:
                  MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 16.0,
                              right: 16.0,
                              top: 12,
                              bottom: 12),
                          child: Text('Configuración',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 20))),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Input(
                            placeholder: "Modificar nombre",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Input(
                            placeholder: "Modificar apellido",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Input(
                            placeholder: "Modificar mail",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24.0),
                        ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Center(
                    child: FlatButton(
                      textColor: ArgonColors.white,
                      color: ArgonColors.verdeOscuro,
                      onPressed: () {
                        // Respond to button press
                        Navigator.pushNamed(
                            context, '/profile');
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(4.0),
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: 16.0,
                              right: 16.0,
                              top: 12,
                              bottom: 12),
                          child: Text("GUARDAR",
                              style: TextStyle(
                                  fontWeight:
                                  FontWeight.w600,
                                  fontSize: 16.0))),
                    ),
                  ),
                ),
                        Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: Center(
                            child: FlatButton(
                              textColor: ArgonColors.white,
                              color: ArgonColors.verdeOscuro,
                              onPressed: () {
                                // Respond to button press
                                Navigator.pushNamed(
                                    context, '/onboarding');
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(4.0),
                              ),
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 16.0,
                                      right: 16.0,
                                      top: 12,
                                      bottom: 12),
                                  child: Text("CERRAR SESIÓN",
                                      style: TextStyle(
                                          fontWeight:
                                          FontWeight.w600,
                                          fontSize: 16.0))),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }
}
