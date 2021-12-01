import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:greencycle/constants/Theme.dart';
import 'package:sign_button/sign_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final double height = window.physicalSize.height;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['profile']);
  late FToast fToast;
  final password = GlobalKey<FormState>();
  final mail = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();



  @override
  void initState(){
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  void showToast(String message) {
    Widget toast = Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Color.fromRGBO(244, 67, 54, 0.5019607843137255)
      ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message),
          ],
        ),
    );
    if(password.currentState!.validate() && mail.currentState!.validate()) {
      fToast.showToast(
        child: toast,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }


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
                                child: Form(
                                  key: mail,
                                  child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Mail',
                                    border: OutlineInputBorder(),
                                    labelStyle: TextStyle(color: ArgonColors.azul),
                                  ),
                                    onSaved: (value) {
                                      _emailController.text = value!;
                                    },
                                    validator: (value){
                                      RegExp regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                                      if(value == null || value.isEmpty){
                                        return "El mail es un campo requerido";
                                      }
                                      else if (!regex.hasMatch(value)){
                                        return "El formato del mail no es válido";
                                      }
                                      return null;
                                    },
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Form(
                                  key: password,
                                  child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Contraseña',
                                    border: OutlineInputBorder(),
                                    labelStyle: TextStyle(color: ArgonColors.azul),
                                  ),
                                  onSaved: (value) {
                                    _passwordController.text = value!;
                                  },
                                  validator: (value){
                                    RegExp regex = new RegExp(r'^.{6,}$');
                                    if(value == null || value.isEmpty){
                                      return "La contraseña es un campo requerido";
                                    }
                                    else if (!regex.hasMatch(value)){
                                      return "La contraseña debe tener como mínimo 6 caracteres";
                                    }
                                    return null;
                                  },
                                  obscureText: true,
                                ),
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
                                onPressed: () async{
                                  password.currentState!.save();
                                  password.currentState!.validate();
                                  mail.currentState!.save();
                                  mail.currentState!.validate();
                                  if(password.currentState!.validate() && mail.currentState!.validate()){
                                  try {
                                    UserCredential result = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    );
                                    setState(() {});
                                    Navigator.pushNamed(context, '/home');
                                  } on FirebaseAuthException catch (e) {
                                    switch (e.code) {
                                      case 'invalid-email':
                                        showToast("El formato del mail es inválido");
                                        break;
                                      case 'wrong-password':
                                        showToast("El usuario o contraseña son erróneos");
                                        break;
                                      case 'user-not-found':
                                        showToast("El usuario o contraseña son erróneos");
                                        break;
                                    }
                                    print('Failed with error code: ${e.code}');
                                    print(e.message);
                                  }
                                }},
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
