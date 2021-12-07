import 'dart:io';
import 'dart:ui';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  final groupNameKey = GlobalKey<FormState>();
  final _groupDescriptionController = TextEditingController();
  final groupDescriptionKey = GlobalKey<FormState>();
  final _prize1stController = TextEditingController();
  final prize1stKey = GlobalKey<FormState>();
  final _prize2ndController = TextEditingController();
  final prize2ndKey = GlobalKey<FormState>();
  final _prize3rdController = TextEditingController();
  final prize3rdKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();
  final searchKey = GlobalKey<FormState>();
  List<MyUser?> usersList = [];

  late FToast fToast;

  @override
  void initState(){
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  void showToast(String message) {
    Widget toast = Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Color.fromRGBO(244, 67, 54, 0.5019607843137255)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message),
        ],
      ),
    );
    if(groupNameKey.currentState!.validate() && groupDescriptionKey.currentState!.validate()) {
      fToast.showToast(
        child: toast,
        gravity: ToastGravity.SNACKBAR,
      );
    }
  }

  var _image = null;
  File? groupImage = null;

  Future getImageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;

    final imageTemporary = File(image.path);
    setState(() {
      this.groupImage = imageTemporary;
    });
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) return;

    final imageTemporary = File(image.path);
    setState(() {
      this.groupImage = imageTemporary;
    });
  }

  void uploadFileToStorage() {
    if (groupImage == null) {
      print("no tenes foto seleccionada");
      return;
    }
    final fileName = groupImage!.path;
    final destination = 'GroupImages/' + fileName;

    final ref = FirebaseStorage.instance.ref(destination);

    UploadTask uploadTask = ref.putFile(groupImage!);
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
                                        child: Form(
                                          key: groupNameKey,
                                          child: TextFormField(
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
                                                  hintText: "Nombre"
                                              ),
                                            onSaved: (value){
                                              _groupNameController.text = value!;
                                            },
                                            validator: (value) {
                                              RegExp regex = new RegExp(r'^.{1,}$');
                                              if (value == null || value.isEmpty) {
                                                return "El nombre es un campo requerido";
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Form(
                                          key: groupDescriptionKey,
                                          child: TextFormField(
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
                                            ),
                                            onSaved: (value){
                                      _groupDescriptionController.text = value!;
                                      },
                                        validator: (value) {
                                          RegExp regex = new RegExp(r'^.{1,}$');
                                          if (value == null || value.isEmpty) {
                                            return "La descripción es un campo requerido";
                                          }
                                          return null;
                                        },
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
                                      groupImage != null ? new Stack(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(24.0),
                                          child: Image.file(
                                            groupImage!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        FloatingActionButton.small(
                                            child: Icon(Icons.delete, color: ArgonColors.white),
                                            backgroundColor: Colors.red,
                                            onPressed: () {
                                              groupImage = null;
                                              setState(() {});
                                            }),
                                      ] ): SizedBox.shrink(),
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
                                              Form(
                                          key: prize1stKey,
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                                filled: true,
                                                fillColor: ArgonColors.white,
                                                suffixIcon: const Icon(
                                                    Icons.emoji_events),
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
                                                hintText: "1er Puesto"
                                            ),
                                            onSaved: (value){
                                              _prize1stController.text = value!;
                                            },
                                          ),
                                        ),
                                              const SizedBox(height: 8.0),
                                              Form(
                                                key: prize2ndKey,
                                                child: TextFormField(
                                                  decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor: ArgonColors.white,
                                                      suffixIcon: const Icon(
                                                          Icons.emoji_events),
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
                                                      hintText: "2do Puesto"
                                                  ),
                                                  onSaved: (value){
                                                    _prize2ndController.text = value!;
                                                  },
                                                ),
                                              ),
                                              const SizedBox(height: 8.0),
                                              Form(
                                                key: prize3rdKey,
                                                child: TextFormField(
                                                  decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor: ArgonColors.white,
                                                      suffixIcon: const Icon(
                                                          Icons.emoji_events),
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
                                                      hintText: "3er Puesto"
                                                  ),
                                                  onSaved: (value){
                                                    _prize3rdController.text = value!;
                                                  },
                                                ),
                                              ),
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
                                              }
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
                                              uploadFileToStorage();
                                              groupNameKey.currentState!.save();
                                              groupNameKey.currentState!.validate();
                                              groupDescriptionKey.currentState!.save();
                                              groupDescriptionKey.currentState!.validate();
                                              prize1stKey.currentState!.save();
                                              prize2ndKey.currentState!.save();
                                              prize3rdKey.currentState!.save();
                                              if (usersList.isEmpty){
                                                showToast("El grupo debe tener integrantes");
                                              }
                                              else if (_groupNameController.text.isNotEmpty &&
                                                  _groupDescriptionController.text.isNotEmpty &&
                                                  usersList.isNotEmpty) {
                                                late Group _group;
                                                UserService _userService = UserService();
                                                GroupService _groupService = GroupService();
                                                if (groupImage == null) {
                                                  // Todo aca habria que crear al group con alguno de los iconos predeterminados
                                                     _group= Group(_groupNameController.text, "Icono predeterminado", _groupDescriptionController.text, _prize1stController.text, _prize2ndController.text, _prize3rdController.text);
                                                } else {
                                                  _group = Group(_groupNameController.text, groupImage!.path, _groupDescriptionController.text, _prize1stController.text, _prize2ndController.text, _prize3rdController.text);
                                                }
                                                String _groupId = await _userService.addGroup(_group);
                                                for(int i = 0; i < usersList.length; i++) {
                                                  await _groupService.addMember(_groupId, usersList[i]!.Id);
                                                }

                                                _myMultipleNotifier._selectedItems = [];

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
                                          List<MyUser> _userList = await _userService
                                              .getAllUser(
                                              _searchController.text, 1);
                                          _userToAdd = _userList[0] as MyUser;
                                          if (_userToAdd != null) {
                                            dialogState(() {
                                              userVisibility = true;
                                            });
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