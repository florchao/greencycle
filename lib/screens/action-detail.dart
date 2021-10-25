import 'package:flutter/material.dart';
import 'package:greencycle/constants/Theme.dart';
import 'package:greencycle/widgets/navbar.dart';


class ActionDetail extends StatelessWidget {
  String ? actionName;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: "MisAcciones",
        rightOptions: false, tags: [],
      ),
      backgroundColor: ArgonColors.verdeClaro,
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 40),
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: Offset(0, 3)
                          )
                        ]
                    ),
                    child: Card(
                        elevation: .0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0))
                        ),
                        child: Padding(
                            padding: const EdgeInsets.only(
                                top: 16, left: 24.0, right: 24.0, bottom: 32),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0, top: 32, bottom: 32),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text('Acción: Reciclaje',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 30)),
                                  ),
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget> [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget> [
                                          Text('Metales',
                                              style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 18)
                                          ),
                                          SizedBox(height: 10),
                                          Text('Papel y cartón',
                                              style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 18)
                                          ),
                                          SizedBox(height: 10),
                                          Text('Vidrio',
                                              style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 18)
                                          ),
                                          SizedBox(height: 10),
                                          Text('Plástico',
                                              style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 18)
                                          )
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget> [
                                          Text('10',
                                              style: TextStyle(color: ArgonColors.azul, fontSize: 18)
                                          ),
                                          SizedBox(height: 10),
                                          Text('0',
                                              style: TextStyle(color: ArgonColors.azul, fontSize: 18)
                                          ),
                                          SizedBox(height: 10),
                                          Text('3',
                                              style: TextStyle(color: ArgonColors.azul, fontSize: 18)
                                          ),
                                          SizedBox(height: 10),
                                          Text('5',
                                              style: TextStyle(color: ArgonColors.azul, fontSize: 18)
                                          )
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget> [
                                          Text('unidades',
                                              style: TextStyle(color: ArgonColors.azul, fontSize: 18)
                                          ),
                                          SizedBox(height: 10),
                                          Text('unidades',
                                              style: TextStyle(color: ArgonColors.azul, fontSize: 18)
                                          ),
                                          SizedBox(height: 10),
                                          Text('unidades',
                                              style: TextStyle(color: ArgonColors.azul, fontSize: 18)
                                          ),
                                          SizedBox(height: 10),
                                          Text('unidades',
                                              style: TextStyle(color: ArgonColors.azul, fontSize: 18)
                                          )
                                        ],
                                      )
                                    ]
                                ),
                                SizedBox(height: 20),
                                Image.network("https://images.unsplash.com/photo-1516559828984-fb3b99548b21?ixlib=rb-1.2.1&auto=format&fit=crop&w=2100&q=80"),
                                SizedBox(height: 20),
                                Text('Acá iría la descripcion',
                                    style: TextStyle(color: ArgonColors.azul, fontSize: 16))
                              ],
                            )
                        )
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }

}