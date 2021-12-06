import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:greencycle/constants/Theme.dart';

class CardHorizontal extends StatelessWidget {
  CardHorizontal(
      {this.title = "Placeholder Title",
      this.cta = "",
        this.description = "",
      this.img = "https://via.placeholder.com/200",
      this.tap = defaultFunc});

  final String cta;
  final String img;
  final String description;
  final VoidCallback tap;
  final String title;

  static void defaultFunc() {
    print("the function works!");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 130,
        child: GestureDetector(
          onTap: tap,
          child: Card(
            elevation: 0.6,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6.0),
                              bottomLeft: Radius.circular(6.0)),
                          image: DecorationImage(
                            image: NetworkImage(img),
                            fit: BoxFit.cover,
                          ))),
                ),
                Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 50,
                            child: AutoSizeText(
                                title,
                                maxLines: 2,
                                minFontSize: 14,
                                textAlign: TextAlign.left,
                                maxFontSize: 18,
                                style: TextStyle(
                                    color: ArgonColors.azul, fontSize: 18)
                            ),
                          ),
                          SizedBox(
                            height: 30,
                            child: AutoSizeText(
                                description,
                                maxLines: 2,
                                minFontSize: 9,
                                textAlign: TextAlign.left,
                                maxFontSize: 13,
                                style: TextStyle(
                                    color: ArgonColors.azul, fontSize: 13)
                            ),
                          ),
                          Text(cta,
                              style: TextStyle(
                                  color: ArgonColors.azul,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600))
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
