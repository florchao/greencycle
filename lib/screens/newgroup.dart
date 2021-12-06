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

  List<MyUser?> usersList = [];

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
    MultipleNotifier _myMultipleNotifier = Provider.of<MultipleNotifier>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Nuevo Grupo"),
          backgroundColor: ArgonColors.verdeOscuro,
        ),
        backgroundColor: ArgonColors.verdeClaro,
        body: Stack(
          children: [
            SafeArea(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
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
                                      const SizedBox(height: 8.0),
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
                                            textAlignVertical: const TextAlignVertical(
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
                                      const SizedBox(height: 8.0),
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
                                              child: const Icon(Icons.add_a_photo)
                                          ),
                                          FloatingActionButton(
                                            onPressed: getImageFromGallery,
                                            child: const Icon(Icons.camera_alt),
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
                                              const SizedBox(height: 8.0),
                                              Input(
                                                placeholder: "1er Puesto",
                                                controller: _prize1stController,
                                                suffixIcon: const Icon(
                                                    Icons.emoji_events),
                                              ),
                                              const SizedBox(height: 8.0),
                                              Input(
                                                placeholder: "2do Puesto",
                                                controller: _prize2ndController,
                                                suffixIcon: const Icon(
                                                    Icons.emoji_events),
                                              ),
                                              const SizedBox(height: 8.0),
                                              Input(
                                                placeholder: "3er Puesto",
                                                controller: _prize3rdController,
                                                suffixIcon: const Icon(
                                                    Icons.emoji_events),
                                              )
                                            ],
                                          )
                                      ),
                                      const SizedBox(height: 8.0),
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
                                                _showUserListDialog(context);
                                                usersList = _myMultipleNotifier._selectedItems;
                                                print(usersList);
                                                print(usersList[0]);
                                              }
                                            // data = _myMultipleNotifier._selectedItems;
                                          ),
                                        ],
                                      ),
                                      SingleChildScrollView(
                                        child: Flexible(
                                            child: ListView.builder(
                                                itemCount: usersList.length,
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  return ListTile(
                                                    leading: const Icon(
                                                        Icons.account_circle),
                                                    title: Text(
                                                      usersList[index]!.name,
                                                      style: const TextStyle(
                                                          color: ArgonColors
                                                              .azul,
                                                          fontSize: 14),),
                                                    subtitle: Text(
                                                        usersList[index]!.email),
                                                    trailing: const Icon(
                                                        Icons.close,
                                                        color: ArgonColors.azul),
                                                    onTap: () {
                                                      _myMultipleNotifier.removeItem(usersList[index]!);
                                                    },
                                                  );
                                                })
                                        )
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: FlatButton(
                                            textColor: ArgonColors.white,
                                            color: ArgonColors.verdeOscuro,
                                            onPressed: () async {
                                              if (_groupNameController.text.isNotEmpty &&
                                                  _groupDescriptionController.text.isNotEmpty &&
                                                  usersList.isNotEmpty) {
                                                Group _group = Group(_groupNameController.text, '', _groupDescriptionController.text);
                                                GroupService _groupService = GroupService();
                                                String _groupId = await _groupService.create(_group);
                                                for(int i = 0; i < usersList.length; i++) {
                                                  await _groupService.addMember(_groupId, usersList[i]!.Id);
                                                }
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
                )
            ),

          ],
        )
    );
  }

  _showUserListDialog(BuildContext context) =>
      showDialog(
          context: context,
          builder: (context) {
            final _multipleNotifier = Provider.of<MultipleNotifier>(context);
            bool userVisibility = false;
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
                                    suffixIcon: const Icon(Icons.search_outlined),
                                    controller: _searchController,
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  TextButton(
                                      onPressed: () async {
                                        if (_searchController.text.isNotEmpty) {
                                          UserService _userService = UserService();
                                          print(_searchController.text);
                                          List<MyUser> _userList = await _userService
                                              .getAllUser(
                                              _searchController.text, 1);
                                          print(_userList);
                                          _userToAdd = _userList[0] as MyUser;
                                          print(_userList);
                                          print(_userToAdd);
                                          print(_userToAdd!.name);
                                          if (_userToAdd != null) {
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
                                      child: const Text(
                                        "BUSCAR", style: TextStyle(
                                          color: ArgonColors.azul),)
                                  ),
                                  Visibility(
                                      visible: userVisibility,
                                      child: Column(
                                        children: [
                                          if(_userToAdd != null)
                                            ListTile(
                                                leading: const Icon(
                                                    Icons.account_circle),
                                                onTap: () {
                                                  print(_userToAdd);
                                                  // usersList.add(_userToAdd!);
                                                  if(!_multipleNotifier.isInList(_userToAdd!)) {
                                                    _multipleNotifier.addItem(
                                                        _userToAdd!);

                                                    ScaffoldMessenger.of(
                                                        context)
                                                        .showSnackBar(
                                                        SnackBar(
                                                            content: Text(
                                                              _userToAdd!.name +
                                                                  ' agregado/a',
                                                              style: const TextStyle(
                                                                  color: ArgonColors
                                                                      .white),)
                                                        )
                                                    );
                                                    userVisibility = false;
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                        context)
                                                        .showSnackBar(
                                                        SnackBar(
                                                            content: Text(
                                                              _userToAdd!.name +
                                                                  ' ya está en el grupo',
                                                              style: const TextStyle(
                                                                  color: ArgonColors
                                                                      .white),)
                                                        )
                                                    );
                                                  }
                                                },
                                                title: Text(_userToAdd!.name),
                                                subtitle: Text(
                                                    _userToAdd!.email),
                                                trailing: const Icon(Icons.add,
                                                    color: ArgonColors.azul)
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
                            _searchController.clear();
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


class MultipleNotifier extends ChangeNotifier {
  List<MyUser> _selectedItems;

  MultipleNotifier(this._selectedItems);
  List<MyUser> get selectedItems => _selectedItems;

  bool isInList(MyUser value) {
    for(MyUser user in _selectedItems) {
      if(value.email == user.email) {
        return true;
      }
    }
    return false;
  }

  addItem(MyUser value) {
    if (!isInList(value)) {
      _selectedItems.add(value);
      notifyListeners();
    }
  }

  removeItem(MyUser value) {
    if(isInList(value)) {
      _selectedItems.remove(value);
      notifyListeners();
    }
  }

}