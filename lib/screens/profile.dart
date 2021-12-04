import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:greencycle/constants/Theme.dart';
import 'package:greencycle/widgets/card-xs.dart';
import 'package:greencycle/widgets/drawer.dart';

class Profile extends StatelessWidget {

  final String? _userName = FirebaseAuth.instance.currentUser!.displayName;
  final String? _imgUrl = FirebaseAuth.instance.currentUser!.photoURL;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = size.height / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Mi Perfil"),
          backgroundColor: ArgonColors.verdeOscuro,
        ),
        backgroundColor: ArgonColors.verdeClaro,
        drawer: ArgonDrawer(currentPage: "Profile"),
        body: Stack(children: <Widget>[
          SafeArea(
            child: ListView(children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 74.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(children: <Widget>[

                      Container(
                        width: size.width*0.9,
                        height: size.height*0.7,
                        decoration: BoxDecoration(
                          boxShadow: [BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),],
                        ),
                        child: Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: .0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 85.0, bottom: 20.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                        children:[
                                          Align(
                                              child: SizedBox(
                                                width: size.width*0.85,
                                                height: size.height*0.05,
                                                child: AutoSizeText( _userName!,
                                                           maxLines: 2,
                                                           minFontSize: 8,
                                                           textAlign: TextAlign.center,
                                                           maxFontSize: 28.0,
                                                           style: TextStyle(color: ArgonColors.azul, fontSize: 28.0)),
                                          ),),
                                        ]),
                                        SizedBox(height: size.height*0.007),
                                        Padding(padding: const EdgeInsets.only(
                                            right: 25.0, left: 25.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Puntaje total:",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 19.0,
                                                      color: ArgonColors.azul)),
                                              Text(
                                                "800000 puntos", //getCurrentUser().score
                                                style: TextStyle(
                                                    color: ArgonColors.azul,
                                                    fontSize: 19.0,
                                                    fontWeight:
                                                    FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height:  size.height*0.007),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 25.0, left: 25.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Mis grupos:",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 19.0,
                                                    color: ArgonColors.azul),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: size.height*0.38,
                                          child: GridView.count(
                                              primary: false,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 24.0,
                                                  vertical: 15.0),
                                              crossAxisSpacing: 10,
                                              childAspectRatio: (itemWidth / itemHeight),
                                              mainAxisSpacing: 10,
                                              crossAxisCount: 3,
                                              children: <Widget>[ //List.generate(
                                                CardXs(
                                                      cta: "View article",
                                                      title:  "HOLA todo bien",
                                                      img:"https://images.unsplash.com/photo-1543747579-795b9c2c3ada?fit=crop&w=240&q=80hoto-1501601983405-7c7cabaa1581?fit=crop&w=240&q=80",
                                                  ),
                                                CardXs(
                                                    cta: "View article",
                                                    title:  "HOLA",
                                                    img:"https://images.unsplash.com/photo-1543747579-795b9c2c3ada?fit=crop&w=240&q=80hoto-1501601983405-7c7cabaa1581?fit=crop&w=240&q=80",
                                                ),
                                                CardXs(
                                                    cta: "View article",
                                                    title:  "HOLA",
                                                    img:"https://images.unsplash.com/photo-1543747579-795b9c2c3ada?fit=crop&w=240&q=80hoto-1501601983405-7c7cabaa1581?fit=crop&w=240&q=80",
                                                ),
                                                CardXs(
                                                    cta: "View article",
                                                    title:  "HOLA",
                                                    img:"https://images.unsplash.com/photo-1543747579-795b9c2c3ada?fit=crop&w=240&q=80hoto-1501601983405-7c7cabaa1581?fit=crop&w=240&q=80",
                                                ),

                                                CardXs(
                                                    cta: "View article",
                                                    title:  "HOLA",
                                                    img:"https://images.unsplash.com/photo-1543747579-795b9c2c3ada?fit=crop&w=240&q=80hoto-1501601983405-7c7cabaa1581?fit=crop&w=240&q=80",
                                                ),
                                                CardXs(
                                                    cta: "View article",
                                                    title:  "HOLA",
                                                    img:"https://images.unsplash.com/photo-1543747579-795b9c2c3ada?fit=crop&w=240&q=80hoto-1501601983405-7c7cabaa1581?fit=crop&w=240&q=80",
                                                ),
    ]),
                                              ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                      FractionalTranslation(
                          translation: Offset(0.0, -0.5),
                          child: Align(
                            child: CircleAvatar(
                              // backgroundImage: AssetImage(
                              //     "assets/img/profilepicsample.png"),
                              backgroundImage: _imgUrl != null ?
                                NetworkImage(_imgUrl!) : AssetImage("assets/img/profilepicsample.png") as ImageProvider,
                              // child: Image.network(_imgUrl!),
                              radius: 65.0,
                              // maxRadius: 200.0,
                            ),
                            alignment: FractionalOffset(0.5, 0.0),
                          ))
                    ]),
                  ],
                ),
              ),
            ]),
          )
        ]));
  }
}
