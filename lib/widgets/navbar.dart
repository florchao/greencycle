import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greencycle/constants/Theme.dart';


class Navbar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final String categoryOne;
  final String categoryTwo;
  final bool searchBar;
  final bool backButton;
  final bool transparent;
  final bool rightOptions;
  final List<String> tags;
  final Function? getCurrentPage;
  final bool isOnSearch;
  final bool noShadow;
  final Color bgColor;

  Navbar(
      {this.title = "Home",
      this.categoryOne = "",
      this.categoryTwo = "",
        required this.tags,
      this.transparent = false,
      this.rightOptions = true,
        this.getCurrentPage ,
      this.isOnSearch = false,
      this.backButton = false,
      this.noShadow = false,
      this.bgColor = ArgonColors.verdeOscuro,
      this.searchBar = false});

  final double _prefferedHeight = 50.0;

  @override
  _NavbarState createState() => _NavbarState();

  @override
  Size get preferredSize => Size.fromHeight(_prefferedHeight);
}

class _NavbarState extends State<Navbar> {
  late String activeTag;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: !widget.transparent ? widget.bgColor : Colors.transparent,
            boxShadow: [
              BoxShadow(
                  color: !widget.transparent && !widget.noShadow
                      ? ArgonColors.verdeOscuro
                      : Colors.transparent,
              )]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/home');
                            },
                    child: Image.asset('assets/img/VerdeOscuroLogo.jpeg', scale: 7),
                        ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/profile');
                            },
                            child: IconButton(
                                icon: Icon(Icons.account_circle,
                                    color: widget.title == 'Mi Perfil'
                                        ? ArgonColors.verdeClaro : ArgonColors.azul,
                                    size: 22.0),
                                onPressed: null),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/acciones');
                            },
                            child: IconButton(
                                icon: Icon(Icons.post_add,
                                    color: widget.title == 'Mis acciones'
                                        ? ArgonColors.verdeClaro : ArgonColors.azul,
                                    size: 22.0),
                                onPressed: null),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/grupos');
                            },
                            child: IconButton(
                                icon: Icon(Icons.groups,
                                    color: widget.title == 'Mis Grupos'
                                        ? ArgonColors.verdeClaro : ArgonColors.azul,
                                    size: 22.0),
                                onPressed: null),
                          ),
                        ],
                      ),
                  ],
                ),
                  ),
            ),
        );
  }
}
