import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:greencycle/constants/Theme.dart';

class CardXs extends StatelessWidget {
  CardXs(
      {this.title = "Placeholder Title",
        this.cta = "",
        this.img = "https://via.placeholder.com/200",
        this.tap = defaultFunc
        });

  final String cta;
  final String img;
  final VoidCallback tap;
  final String title;

  static void defaultFunc() {
    print("the function works!");
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
            child: GestureDetector(
              onTap: tap,
            child: Card(
              color: ArgonColors.verdeClaro,
                elevation: 0.4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                        flex: 1,
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6.0),
                                    topRight: Radius.circular(6.0)),
                                image: DecorationImage(
                                  image: NetworkImage(img),
                                  fit: BoxFit.cover,
                                )))),
                    Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 8.0, left: 8.0, right: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  width:
                                  size.width * 0.8,
                                  height: size.height *
                                      0.05,
                                  child: AutoSizeText(title,
                                      maxLines: 4,
                                      minFontSize: 11,
                                      textAlign:
                                      TextAlign
                                          .center,
                                      maxFontSize: 15.0,
                                      style: const TextStyle(
                                          color:
                                          ArgonColors
                                              .azul,
                                          fontWeight: FontWeight.w600,
                                          fontSize:
                                          15.0)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(cta,
                                    style: TextStyle(
                                        color: ArgonColors.verdeOscuro,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600, fontStyle: FontStyle.italic)),
                              )
                            ],
                          ),
                        ))
                  ],
                )),
          ),
        );
  }
}
