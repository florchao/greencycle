import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:greencycle/constants/Theme.dart';
import 'package:greencycle/widgets/input.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final double height = window.physicalSize.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ArgonColors.verdeClaro,
        body: Stack(
          children: [
            SafeArea(
              child: ListView(children: [
                Padding(
                    padding: const EdgeInsets.only(
                        top: 16, left: 24.0, right: 24.0, bottom: 32),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 40.0),
                        ),
                        Container(
                            decoration: BoxDecoration(
                              color: ArgonColors.verdeClaro,
                            ),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(context, '/onboarding');
                                        },
                                        child: Image.asset('assets/img/logoVerde.png', scale: 3),
                                      ),
                                    ],
                                  ),
                                ),
                                // Divider()
                              ],
                            )),
                        Container(
                            height: MediaQuery.of(context).size.height * 0.63,
                            color: ArgonColors.verdeClaro,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 16),
                                          child:Center(
                                            child: FlatButton(
                                              textColor: ArgonColors.white,
                                              color: ArgonColors.verdeOscuro,
                                              onPressed: () {
                                              },
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(4.0),
                                              ),
                                              child: Row(
                                                      children:[
                                                      Text("Iniciar Sesión con Google",
                                                          style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.w600,
                                                  fontSize: 16.0)),
                                                        RawMaterialButton(
                                                          onPressed: () {},
                                                          elevation: 0,
                                                          fillColor: ArgonColors.verdeOscuro,
                                                          child: Icon(FontAwesomeIcons.google,
                                                              size: 16.0, color: Colors.white),
                                                          padding: EdgeInsets.all(15.0),
                                                          shape: CircleBorder(),
                                                        ),])),
                                            ),
                                          ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Input(
                                            placeholder: "Email",
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Input(
                                            placeholder: "Contraseña",
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 24.0),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 1),
                                      child: Center(
                                        child: FlatButton(
                                          textColor: ArgonColors.white,
                                          color: ArgonColors.verdeOscuro,
                                          onPressed: () {
                                            // Respond to button press
                                            Navigator.pushNamed(
                                                context, '/home');
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
                                              child: Text("INICIAR SESIÓN",
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      fontSize: 16.0))),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ))
                      ],
                    )),
              ]),
            )
          ],
        ));
  }
}
