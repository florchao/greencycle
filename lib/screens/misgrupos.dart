import 'package:flutter/material.dart';

import 'package:greencycle/constants/Theme.dart';
import 'package:greencycle/widgets/card-horizontal.dart';
import 'package:greencycle/widgets/navbar.dart';

final Map<String, Map<String, dynamic>> articlesCards = {
  "Ice Cream": {
    "title": "Ice cream is made with carrageenan …",
    "image":
    "https://images.unsplash.com/photo-1516559828984-fb3b99548b21?ixlib=rb-1.2.1&auto=format&fit=crop&w=2100&q=80"
  },
  "Makeup": {
    "title": "Is makeup one of your daily esse …",
    "image":
    "https://images.unsplash.com/photo-1519368358672-25b03afee3bf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2004&q=80"
  },
  "Coffee": {
    "title": "Coffee is more than just a drink: It’s …",
    "image":
    "https://images.unsplash.com/photo-1500522144261-ea64433bbe27?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2102&q=80"
  },
  "Fashion": {
    "title": "Fashion is a popular style, especially in …",
    "image":
    "https://images.unsplash.com/photo-1487222477894-8943e31ef7b2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1326&q=80"
  },
  "Argon": {
    "title": "Argon is a great free UI packag …",
    "image":
    "https://images.unsplash.com/photo-1482686115713-0fbcaced6e28?fit=crop&w=1947&q=80"
  },
  "Music": {
    "title": "View article",
    "image":
    "https://images.unsplash.com/photo-1501084817091-a4f3d1d19e07?fit=crop&w=2700&q=80",
    "products": [
      {
        "img":
        "https://images.unsplash.com/photo-1501084817091-a4f3d1d19e07?fit=crop&w=2700&q=80",
        "title": "Painting Studio",
        "description":
        "You need a creative space ready for your art? We got that covered.",
        "price": "\$125",
      },
      {
        "img":
        "https://images.unsplash.com/photo-1500628550463-c8881a54d4d4?fit=crop&w=2698&q=80",
        "title": "Art Gallery",
        "description":
        "Don't forget to visit one of the coolest art galleries in town.",
        "price": "\$200",
      },
      {
        "img":
        "https://images.unsplash.com/photo-1496680392913-a0417ec1a0ad?fit=crop&w=2700&q=80",
        "title": "Video Services",
        "description":
        "Some of the best music video services someone could have for the lowest prices.",
        "price": "\$300",
      },
    ],
    "suggestions": [
      {
        "img":
        "https://images.unsplash.com/photo-1511379938547-c1f69419868d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2700&q=80",
        "title": "Music studio for real..."
      },
      {
        "img":
        "https://images.unsplash.com/photo-1477233534935-f5e6fe7c1159?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2700&q=80",
        "title": "Music equipment to borrow..."
      },
    ]
  }
};

class MisGrupos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: "MisGrupos",
          rightOptions: false, tags: [],
        ),
        backgroundColor: ArgonColors.verdeClaro,
        body: Container(
            padding: EdgeInsets.only(right: 24, left: 24, bottom: 36),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 32),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Mis grupos',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 20)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: CardHorizontal(
                        cta: "View article",
                        title: articlesCards["Ice Cream"]!['title'],
                        img: articlesCards["Ice Cream"]!['image'],
                        tap: () {
                          Navigator.pushNamed(context, '/group-detail');
                        }),
                  ),
                  SizedBox(height: 8.0),
                  CardHorizontal(
                      cta: "View article",
                      title: articlesCards["Fashion"]!['title'],
                      img: articlesCards["Fashion"]!['image'],
                      tap: () {
                        Navigator.pushNamed(context, '/group-detail');
                      }),
                ],
              ),
            )
        ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/newgroup');
            },
          child: const Icon(Icons.add),
          backgroundColor: ArgonColors.azul,
      ),
    );
  }
}