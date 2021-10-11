import 'package:flutter/material.dart';
import 'package:greencycle/constants/Theme.dart';

class CardXs extends StatelessWidget {
  CardXs(
      {this.title = "Placeholder Title",
        this.cta = "",
        this.img = "https://via.placeholder.com/200",
        });

  final String cta;
  final String img;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Container(
          height: 150,
            child: GestureDetector(
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
                              top: 8.0, bottom: 8.0, left: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(title,
                                  style: TextStyle(
                                      color: ArgonColors.azul, fontSize: 13)),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(cta,
                                    style: TextStyle(
                                        color: ArgonColors.azul,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600)),
                              )
                            ],
                          ),
                        ))
                  ],
                )),
          ),
        ),
        );
  }
}
