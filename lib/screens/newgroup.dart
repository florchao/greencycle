import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:greencycle/constants/Theme.dart';
import 'package:greencycle/model/Group.dart';
import 'package:greencycle/model/MyUser.dart';
import 'package:greencycle/services/user_service.dart';
import 'package:greencycle/services/group_service.dart';
import 'package:greencycle/widgets/input.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NewGroup extends StatefulWidget {

  @override
  State<NewGroup> createState() => _NewGroupState();
}

class _NewGroupState extends State<NewGroup> {
  final _groupNameController = TextEditingController();

  final _groupDescriptionController = TextEditingController();

  final _prize1stController = TextEditingController();

  final _prize2ndController = TextEditingController();

  final _prize3rdController = TextEditingController();

  final _searchController = TextEditingController();

  final List<String> usernames = [
    'Felo',
    'Herni',
    'Flor',
    'Male',
    'Nicky',
    'Azu'
  ];

  List<MyUser> usersList = [];

  List<String> data = [];

  var _image = null;

  Future getImageFromCamera() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);

    _image = image as File;
  }

  Future getImageFromGallery() async {
    final picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery
    );

    _image = image as File;
  }

  @override
  Widget build(BuildContext context) {
    // MultipleNotifier _myMultipleNotifier = Provider.of<MultipleNotifier>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Nuevo Grupo"),
          backgroundColor: ArgonColors.verdeOscuro,
        ),
        backgroundColor: ArgonColors.verdeClaro,
        body: Stack(
          children: [
            SafeArea(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 16, left: 24.0, right: 24.0, bottom: 16),
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height,
                            color: ArgonColors.verdeClaro,
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: ListView(
                                    scrollDirection: Axis.vertical,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Input(
                                            placeholder: "Nombre",
                                            controller: _groupNameController
                                        ),
                                      ),
                                      SizedBox(height: 8.0),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                            cursorColor: ArgonColors.black,
                                            controller: _groupDescriptionController,
                                            autofocus: false,
                                            maxLines: null,
                                            style:
                                            const TextStyle(height: 0.85,
                                                fontSize: 14.0,
                                                color: ArgonColors.verdeOscuro),
                                            textAlignVertical: TextAlignVertical(
                                                y: 0.6),
                                            decoration: InputDecoration(
                                                filled: true,
                                                fillColor: ArgonColors.white,
                                                hintStyle: const TextStyle(
                                                  color: ArgonColors.azul,
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(4.0),
                                                    borderSide: const BorderSide(
                                                        color: ArgonColors
                                                            .verdeOscuro,
                                                        width: 1.0,
                                                        style: BorderStyle
                                                            .solid)),
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(4.0),
                                                    borderSide: const BorderSide(
                                                        color: ArgonColors
                                                            .verdeOscuro,
                                                        width: 1.0,
                                                        style: BorderStyle
                                                            .solid)),
                                                hintText: "Descripción"
                                            )),
                                      ),
                                      SizedBox(height: 8.0),
                                      Center(
                                          child: _image == null ? const Text(
                                              "Agregar una imagen",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: ArgonColors.azul,
                                                  fontSize: 15)) : Image.file(
                                              _image)
                                      ),
                                      // Image.network("https://images.unsplash.com/photo-1516559828984-fb3b99548b21?ixlib=rb-1.2.1&auto=format&fit=crop&w=2100&q=80"),
                                      const SizedBox(height: 8.0),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceEvenly,
                                        children: <Widget>[
                                          FloatingActionButton(
                                              onPressed: getImageFromCamera,
                                              child: Icon(Icons.add_a_photo)
                                          ),
                                          FloatingActionButton(
                                            onPressed: getImageFromGallery,
                                            child: Icon(Icons.camera_alt),
                                          )
                                        ],
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              const Align(
                                                  alignment: Alignment
                                                      .centerLeft,
                                                  child: Text('Premios',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          color: ArgonColors
                                                              .azul,
                                                          fontSize: 20)
                                                  )
                                              ),
                                              SizedBox(height: 8.0),
                                              Input(
                                                placeholder: "1er Puesto",
                                                controller: _prize1stController,
                                                suffixIcon: Icon(
                                                    Icons.emoji_events),
                                              ),
                                              SizedBox(height: 8.0),
                                              Input(
                                                placeholder: "2do Puesto",
                                                controller: _prize2ndController,
                                                suffixIcon: Icon(
                                                    Icons.emoji_events),
                                              ),
                                              SizedBox(height: 8.0),
                                              Input(
                                                placeholder: "3er Puesto",
                                                controller: _prize3rdController,
                                                suffixIcon: Icon(
                                                    Icons.emoji_events),
                                              )
                                            ],
                                          )
                                      ),
                                      SizedBox(height: 8.0),
                                      Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 8.0, top: 8.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text('Integrantes',
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: ArgonColors.azul,
                                                      fontSize: 20)),
                                            ),
                                          ),
                                          FloatingActionButton.small(
                                              tooltip: 'Agregar',
                                              child: const Icon(Icons.add),
                                              backgroundColor: ArgonColors.azul,
                                              onPressed: () {
                                                _showUserListDialog(context).then((value) => setState((){}));
                                                setState(() {
                                                });
                                                print(usersList);
                                                }
                                                // data = _myMultipleNotifier._selectedItems;
                                          ),
                                        ],
                                      ),
                                      Flexible(
                                          child: ListView.builder(
                                              itemCount: data.length,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return ListTile(
                                                    leading: const Icon(
                                                        Icons.account_circle),
                                                    title: Text(usersList[index].name,
                                                      style: const TextStyle(
                                                          color: ArgonColors
                                                              .azul,
                                                          fontSize: 14),),
                                                    subtitle: Text(usersList[index].email),
                                                    trailing: const Icon(
                                                        Icons.close,
                                                        color: ArgonColors.azul)
                                                );
                                              })
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: FlatButton(
                                            textColor: ArgonColors.white,
                                            color: ArgonColors.verdeOscuro,
                                            onPressed: () async {
                                              if (_groupNameController.text
                                                  .isNotEmpty &&
                                                  _prize1stController.text
                                                      .isNotEmpty
                                                  && _prize2ndController.text
                                                      .isNotEmpty &&
                                                  _prize3rdController.text
                                                      .isNotEmpty) {
                                                // Group _group = Group(_groupNameController.text, _image.toString(), []);
                                                GroupService _groupService = GroupService();
                                                // _groupService.addGroup(_group);
                                                Navigator.pushReplacementNamed(
                                                    context, '/home');
                                              }
                                            },
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius
                                                  .circular(4.0),
                                            ),
                                            child: const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 16.0,
                                                    right: 16.0,
                                                    top: 12,
                                                    bottom: 10),
                                                child: Text("GUARDAR GRUPO",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .w600,
                                                        fontSize: 18.0))),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            ),
                          )
                        ],
                      ),
                    ),

                  ],)
            ),

          ],
        )
    );
  }
  Future<MyUser?> _showUserListDialog(BuildContext context) {
    bool userVisibility = false;
    return showDialog(
        context: context,
        builder: (context) {
          MyUser? _userToAdd;
          return StatefulBuilder(
            builder: (context, StateSetter dialogState) {
              return AlertDialog(
                title: const Text('Selecciona los usuarios a agregar',
                    style: TextStyle(fontWeight: FontWeight.bold,
                        color: ArgonColors.azul,
                        fontSize: 20)),
                content: SingleChildScrollView(
                    child: Container(
                        width: double.infinity,
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Input(
                                placeholder: "Buscar",
                                suffixIcon: Icon(Icons.search_outlined),
                                controller: _searchController,
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              TextButton(
                                  onPressed: () async {
                                    if (_searchController.text.isNotEmpty) {
                                      UserService _userService = new UserService();
                                      // print(_searchController.text);
                                      List<MyUser> _userList = await _userService
                                          .getAllUser(_searchController.text, 1);
                                      // print(_userList);
                                      _userToAdd = _userList[0] as MyUser;
                                      print(_userList);
                                      print(_userToAdd);
                                      print(_userToAdd!.name);
                                      if(_userToAdd != null) {
                                        dialogState(() {
                                          userVisibility = true;
                                        });
                                        //   print(_userToAdd!.name);
                                        //   ListTile(
                                        //       onTap: ()
                                        //       {},
                                        //       title: Text(_userToAdd!.name),
                                        //       subtitle: Text(_userToAdd!.email),
                                        //       trailing: const Icon(Icons.chat, color: ArgonColors.azul)
                                        //   ); } else {
                                        //   Container(); }
                                      }
                                    }
                                    setState(() {});
                                  },
                                  child: const Text("BUSCAR", style: TextStyle(color: ArgonColors.azul),)
                              ),
                              Visibility(
                                visible: userVisibility,
                                  child: Column(
                                    children: [
                                      if(_userToAdd != null)
                                        ListTile(
                                          leading: Icon(Icons.account_circle),
                                            onTap: () {
                                            print(_userToAdd);
                                            usersList.add(_userToAdd!);
                                            setState(() {});
                                            dialogState(() {});
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text(_userToAdd!.name + ' added',
                                                style: TextStyle(color: ArgonColors.white),)
                                              )
                                            );
                                            userVisibility = false;
                                            },
                                            title: Text(_userToAdd!.name),
                                            subtitle: Text(_userToAdd!.email),
                                            trailing: const Icon(Icons.add, color: ArgonColors.azul)
                                        ),
                                    ],
                                  )
                              )
                            ]
                        )
                    )
                ),
                actions: [
                  TextButton(
                      child: const Text('CERRAR',
                          style: TextStyle(color: ArgonColors.azul)),
                      onPressed: () {
                        Navigator.of(context).pop(_userToAdd);
                        setState(() {

                        });
                      }
                  ),
                ],
              );
            }
          );
        });
  }

}


// class MultipleNotifier extends ChangeNotifier {
//   List<String> _selectedItems;
//
//   MultipleNotifier(this._selectedItems);
//   List<String> get selectedItems => _selectedItems;
//
//   bool isInList(String value) => _selectedItems.contains(value);
//
//   addItem(String value) {
//     if (!isInList(value)) {
//       _selectedItems.add(value);
//       notifyListeners();
//     }
//   }
//
//   removeItem(String value) {
//     if(isInList(value)) {
//       _selectedItems.remove(value);
//       notifyListeners();
//     }
//   }
//
// }