import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:greencycle/constants/Theme.dart';

class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ArgonColors.verdeClaro,
        body: Stack(children: <Widget>[
      Padding(
        padding:
            const EdgeInsets.only(top: 73, left: 32, right: 32, bottom: 16),
        child: Container(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset("assets/img/logoVerde.png", scale: 1),
                Padding(
                  padding: const EdgeInsets.only(top: 1.0),
                  child: SizedBox(
                    width: double.infinity,
                    child:
                      FlatButton(
                        textColor: ArgonColors.white,
                        color: ArgonColors.verdeOscuro,
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/register');
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Padding(
                            padding: EdgeInsets.only(
                                left: 16.0, right: 16.0, top: 12, bottom: 10),
                            child: Text("REGISTRARSE",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.0))),
                      ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 1.0),
                  child: SizedBox(
                    width: double.infinity,
                    child:
                    FlatButton(
                      textColor: ArgonColors.white,
                      color: ArgonColors.verdeOscuro,
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 10, bottom: 10),
                          child: Text("INICIAR SESIÓN",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.0))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    ]));
  }
}
