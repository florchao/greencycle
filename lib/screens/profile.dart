import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:greencycle/constants/Theme.dart';
import 'package:greencycle/model/MyUser.dart';
import 'package:greencycle/services/user_service.dart';
import 'package:greencycle/widgets/card-xs.dart';
import 'package:greencycle/widgets/drawer.dart';

class Profile extends StatelessWidget {
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
        body: FutureBuilder<MyUser?>(
            future: UserService().getCurrentUser(),
            builder: (BuildContext context, AsyncSnapshot<MyUser?> snapshot) {
              if (snapshot.hasData) {
                return Stack(children: <Widget>[
                  SafeArea(
                    child: ListView(children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 74.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Stack(children: <Widget>[
                              Container(
                                width: size.width * 0.9,
                                height: size.height * 0.7,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Card(
                                    semanticContainer: true,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    elevation: .0,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0))),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 85.0, bottom: 20.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Align(
                                                        child: SizedBox(
                                                          width:
                                                              size.width * 0.85,
                                                          height: size.height *
                                                              0.05,
                                                          child: AutoSizeText(
                                                              snapshot.data!.name + " " + snapshot.data!.last_name,
                                                              maxLines: 2,
                                                              minFontSize: 8,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              maxFontSize: 28.0,
                                                              style: const TextStyle(
                                                                  color:
                                                                      ArgonColors
                                                                          .azul,
                                                                  fontSize:
                                                                      28.0)),
                                                        ),
                                                      ),
                                                    ]),
                                                SizedBox(
                                                    height:
                                                        size.height * 0.007),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 25.0,
                                                          left: 25.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text("Puntaje total:",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 19.0,
                                                              color: ArgonColors
                                                                  .azul)),
                                                      Text( (snapshot.data!.score.toString()) +
                                                        " puntos",
                                                        style: const TextStyle(
                                                            color: ArgonColors
                                                                .azul,
                                                            fontSize: 19.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        size.height * 0.007),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 25.0,
                                                          left: 25.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: const [
                                                      Text(
                                                        "Mis grupos:",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 19.0,
                                                            color: ArgonColors
                                                                .azul),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: size.height * 0.38,
                                                  child: GridView.count(
                                                      primary: false,
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                              horizontal: 24.0,
                                                              vertical: 15.0),
                                                      crossAxisSpacing: 10,
                                                      childAspectRatio:
                                                          (itemWidth /
                                                              itemHeight),
                                                      mainAxisSpacing: 10,
                                                      crossAxisCount: 3,
                                                      children: <Widget>[
                                                        //List.generate(
                                                        CardXs(
                                                          cta: "View article",
                                                          title:
                                                              "HOLA todo bien",
                                                          img:
                                                              "https://images.unsplash.com/photo-1543747579-795b9c2c3ada?fit=crop&w=240&q=80hoto-1501601983405-7c7cabaa1581?fit=crop&w=240&q=80",
                                                        ),
                                                        CardXs(
                                                          cta: "View article",
                                                          title: "HOLA",
                                                          img:
                                                              "https://images.unsplash.com/photo-1543747579-795b9c2c3ada?fit=crop&w=240&q=80hoto-1501601983405-7c7cabaa1581?fit=crop&w=240&q=80",
                                                        ),
                                                        CardXs(
                                                          cta: "View article",
                                                          title: "HOLA",
                                                          img:
                                                              "https://images.unsplash.com/photo-1543747579-795b9c2c3ada?fit=crop&w=240&q=80hoto-1501601983405-7c7cabaa1581?fit=crop&w=240&q=80",
                                                        ),
                                                        CardXs(
                                                          cta: "View article",
                                                          title: "HOLA",
                                                          img:
                                                              "https://images.unsplash.com/photo-1543747579-795b9c2c3ada?fit=crop&w=240&q=80hoto-1501601983405-7c7cabaa1581?fit=crop&w=240&q=80",
                                                        ),

                                                        CardXs(
                                                          cta: "View article",
                                                          title: "HOLA",
                                                          img:
                                                              "https://images.unsplash.com/photo-1543747579-795b9c2c3ada?fit=crop&w=240&q=80hoto-1501601983405-7c7cabaa1581?fit=crop&w=240&q=80",
                                                        ),
                                                        CardXs(
                                                          cta: "View article",
                                                          title: "HOLA",
                                                          img:
                                                              "https://images.unsplash.com/photo-1543747579-795b9c2c3ada?fit=crop&w=240&q=80hoto-1501601983405-7c7cabaa1581?fit=crop&w=240&q=80",
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
                                  translation: const Offset(0.0, -0.5),
                                  child: Align(
                                    child: CircleAvatar(
                                      // backgroundImage: AssetImage(
                                      //     "assets/img/profilepicsample.png"),
                                      backgroundImage: snapshot.data!.icon_url != null
                                          ? NetworkImage(snapshot.data!.icon_url!)
                                          : const AssetImage(
                                                  "assets/img/profilepicsample.png")
                                              as ImageProvider,
                                      // child: Image.network(_imgUrl!),
                                      radius: 65.0,
                                      // maxRadius: 200.0,
                                    ),
                                    alignment: const FractionalOffset(0.5, 0.0),
                                  ))
                            ]),
                          ],
                        ),
                      ),
                    ]),
                  )
                ]);
              }else {
                return Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 10.0),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    )
                );
              }

            }));
  }
}
