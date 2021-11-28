import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:greencycle/constants/Theme.dart';
import 'package:greencycle/widgets/input.dart';
import 'package:sign_button/sign_button.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final double height = window.physicalSize.height;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['profile']);

  @override
  Widget build(BuildContext context) {

    GoogleSignInAccount? user = _googleSignIn.currentUser;


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
                        Column(
                            children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Column(
                                    children: [
                                      SignInButton(
                                          buttonType: ButtonType.google,
                                          buttonSize: ButtonSize.small,
                                          btnColor: ArgonColors.verdeOscuro,
                                          width: 225,
                                          btnText: "Iniciar Sesión con Google",
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(4.0),
                                          ),
                                          btnTextColor: ArgonColors.white,
                                          onPressed: () async {
                                            final googleUser = await _googleSignIn.signIn();

                                            if (googleUser == null) return;

                                            final googleAuth = await googleUser.authentication;
                                            final credential = GoogleAuthProvider.credential(
                                              accessToken: googleAuth.accessToken,
                                              idToken: googleAuth.idToken,
                                            );

                                            await FirebaseAuth.instance.signInWithCredential(credential);

                                            setState(() {});
                                            Navigator.pushNamed(context, '/home');

                                          } )]
                                ),
                              ),
                            )]
                        ),
                        const Padding(padding: EdgeInsets.all(16.0)),
                        Column(
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
                            ])),
                    ]));
  }
}
