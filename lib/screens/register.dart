import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:greencycle/constants/Theme.dart';
import 'package:greencycle/model/MyUser.dart';
import 'package:greencycle/services/user_service.dart';
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

  String? get _errorTexEmail {
    // at any time, we can get the text from _controller.value.text
    final text = _emailController!.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'El mail es un campo obligatorio';
    }
    // return null if the text is valid
    return null;
  }

  String? get _errorTexFirstName {
    // at any time, we can get the text from _controller.value.text
    final text = _firstNameController!.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'El nombre es un campo obligatorio';
    }
    // return null if the text is valid
    return null;
  }
  String? get _errorTexLastName {
    // at any time, we can get the text from _controller.value.text
    final text = _lastNameController!.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'El nombre es un campo obligatorio';
    }
    // return null if the text is valid
    return null;
  }
  String? get _errorTexPassword {
    // at any time, we can get the text from _controller.value.text
    final text = _passwordController!.value.text;
    final text2 = _confirmPasswordController!.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'El mail es un campo obligatorio';
    }
    if(text != text2){
      return 'Las contraseñas deben coincidir';
    }
    // return null if the text is valid
    return null;
  }

  String? get _errorTexConfirmPassword {
    // at any time, we can get the text from _controller.value.text
    final text = _passwordController!.value.text;
    final text2 = _confirmPasswordController!.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text2.isEmpty) {
      return 'El mail es un campo obligatorio';
    }
    if(text != text2){
      return 'Las contraseñas deben coincidir';
    }
    // return null if the text is valid
    return null;
  }

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
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0),
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
                              height: MediaQuery.of(context).size.height * 0.77,
                              color: ArgonColors.verdeClaro,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                labelText: 'Nombre',
                                                border: OutlineInputBorder(),
                                                labelStyle: TextStyle(color: ArgonColors.azul),
                                                errorText: _errorTexFirstName,
                                              ),
                                              controller: _firstNameController,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                labelText: 'Apellido',
                                                border: OutlineInputBorder(),
                                                labelStyle: TextStyle(color: ArgonColors.azul),
                                                errorText: _errorTexLastName,
                                              ),
                                              controller: _lastNameController,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                labelText: 'Mail',
                                                  border: OutlineInputBorder(),
                                                labelStyle: TextStyle(color: ArgonColors.azul),
                                                errorText: _errorTexEmail,
                                              ),
                                              controller: _emailController,
                                              keyboardType: TextInputType.emailAddress,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                labelText: 'Contraseña',
                                                border: OutlineInputBorder(),
                                                labelStyle: TextStyle(color: ArgonColors.azul),
                                                errorText: _errorTexPassword,
                                              ),
                                                obscureText: true,
                                                controller: _passwordController,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                labelText: 'Confirmar contraseña',
                                                border: OutlineInputBorder(),
                                                labelStyle: TextStyle(color: ArgonColors.azul),
                                                errorText: _errorTexConfirmPassword,
                                              ),
                                              obscureText: true,
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
                                        padding: const EdgeInsets.only(top: 10),
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

                                              MyUser _myUser = MyUser(
                                                  _firstNameController!.text,
                                                  _lastNameController!.text,
                                                  FirebaseAuth.instance.currentUser!.uid,
                                                  FirebaseAuth.instance.currentUser!.photoURL,
                                                  _emailController!.text);

                                              UserService _userService = UserService();

                                              _userService.create(_myUser);

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
                                                    top: 10),
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
