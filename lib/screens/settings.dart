import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
    GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['profile']);
    return Scaffold(
        backgroundColor: ArgonColors.verdeClaro,
        // appBar: Navbar(
        //   title: "Configuración",
        //   bgColor: ArgonColors.verdeOscuro, tags: [],
        // ),
        appBar: AppBar(
          title: const Text("GreenCycle"),
          backgroundColor: ArgonColors.verdeOscuro,
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
                        Navigator.pushNamed(context, '/profile');
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
                              onPressed: () async {

                                // Habria que hacer un checkeo para que se fije si inicie sesino con google o no
                                await _googleSignIn.signOut();
                                FirebaseAuth.instance.signOut();
                                setState(() {}); // Esto es para forzar un refresh nadamas
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
