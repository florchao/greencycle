import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:greencycle/constants/Theme.dart';
import 'package:greencycle/provider/google_sign_in.dart';
import 'package:greencycle/screens/home.dart';
import 'package:greencycle/widgets/input.dart';
import 'package:provider/provider.dart';

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

        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            print("decime que estoy aca");
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              print("me meti?");
              return Home();
            } else if (snapshot.hasError) {
              return Center(child: Text("Something Went Wrong!"));
            } else {
              print("seguimo");
              return Stack(
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
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  onPrimary: Colors.black,
                                  minimumSize: Size(double.infinity, 50),
                                ),
                                child: Text("Sign in with google"),
                                onPressed: () {
                                  final provider = Provider.of<GoogleSignInProvider>(context, listen:false);
                                  provider.googleLogin();
                                },
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
                                            padding: const EdgeInsets.only(top: 16),
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
              );
            }
          },
        )

        );
  }
}
