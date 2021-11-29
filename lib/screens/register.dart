import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:greencycle/constants/Theme.dart';
import 'package:greencycle/widgets/input.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final double height = window.physicalSize.height;

  final TextEditingController? _firstNameController = TextEditingController();
  final TextEditingController? _lastNameController = TextEditingController();
  final TextEditingController? _emailController = TextEditingController();
  final TextEditingController? _passwordController = TextEditingController();
  final TextEditingController? _confirmPasswordController = TextEditingController();

  // Podria hacerlo con Regex pero soy vago
  bool validEmail(TextEditingController? controller) {
    if (controller == null) return false;
    if (!controller.text.contains('@') || !controller.text.contains('.')) return false;
    return true;
  }

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
                          Container(
                              height: MediaQuery.of(context).size.height * 0.15,
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
                                          // width: 0,
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(context, '/onboarding');
                                            },
                                            child: Image.asset('assets/img/logoVerde.png', scale: 6),
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
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Input(
                                              placeholder: "Nombre",
                                              controller: _firstNameController,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Input(
                                              placeholder: "Apellido",
                                              controller: _lastNameController,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Input(
                                                placeholder: "Email",
                                              controller: _emailController,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Input(
                                                placeholder: "Contraseña",
                                                controller: _passwordController,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Input(
                                              placeholder: "Confirmar contraseña",
                                              controller: _confirmPasswordController,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 24.0),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 16),
                                        child: Center(
                                          child: FlatButton(
                                            textColor: ArgonColors.white,
                                            color: ArgonColors.verdeOscuro,
                                            onPressed: () async {

                                              User? user = FirebaseAuth.instance.currentUser;

                                              if (_firstNameController == null || _lastNameController == null) {
                                                // TODO habria que meter un feedback en rojo algo asi
                                                return;
                                              }

                                              if (!validEmail(_emailController)) {
                                                // TODO habria que meter un feedback en rojo algo asi
                                                return;
                                              }

                                              if (_passwordController == null || _confirmPasswordController == null) {
                                                // TODO habria que meter un feedback en rojo algo asi
                                                return;
                                              }

                                              if (_passwordController!.text != _confirmPasswordController!.text) {
                                                // TODO habria que meter un feedback en rojo algo asi
                                                return;
                                              }

                                              await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                                  email: _emailController!.text,
                                                  password: _passwordController!.text,
                                              );
                                              FirebaseAuth.instance.currentUser!.updateDisplayName(_firstNameController!.text+" "+_lastNameController!.text);
                                              setState(() {});

                                              Navigator.pushNamed(context, '/home');
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
                                                child: Text("REGISTRARSE",
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
