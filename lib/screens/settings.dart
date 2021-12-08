import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:greencycle/constants/Theme.dart';
import 'package:greencycle/model/MyUser.dart';
import 'package:greencycle/services/user_service.dart';

//widgets
import 'package:greencycle/widgets/drawer.dart';
import 'package:image_picker/image_picker.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final lastName = GlobalKey<FormState>();
  final mail = GlobalKey<FormState>();
  final firstName = GlobalKey<FormState>();
  final image = GlobalKey<FormState>();
  final TextEditingController? _firstNameController = TextEditingController();
  final TextEditingController? _lastNameController = TextEditingController();
  final TextEditingController? _emailController = TextEditingController();
  final TextEditingController? _imageController = TextEditingController();

  void initState() {
    super.initState();
  }

  var _image = null;
  File? profileImage;
  late String photo_url;

  Future getImageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;

    final imageTemporary = File(image.path);
    setState(() {
      this.profileImage = imageTemporary;
    });

  }

  Future getImageFromGallery() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) return;

    final imageTemporary = File(image.path);
    setState(() {
      this.profileImage = imageTemporary;
    });
  }

  Future uploadFileToStorage() async {
    if (profileImage == null) {
      print("no tenes foto seleccionada");
      return;
    }
    final fileName = profileImage!.path;
    final destination = 'profileImages/' + fileName;
    final ref = await FirebaseStorage.instance.ref(destination);
    TaskSnapshot uploadTask = await ref.putFile(profileImage!);
    photo_url = await ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['profile']);
    return Scaffold(
        backgroundColor: ArgonColors.verdeClaro,
        appBar: AppBar(
          title: const Text("Configuración"),
          backgroundColor: ArgonColors.verdeOscuro,
        ),
        drawer: ArgonDrawer(currentPage: "Configuración"),
      body: Stack(
          children: [
      SafeArea(
      child: ListView(children: [
          Padding(
          padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                            key: firstName,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Modificar nombre",
                                border: OutlineInputBorder(),
                                labelStyle: TextStyle(color: ArgonColors.azul),
                              ),
                              onSaved: (value) {
                                _firstNameController!.text = value!;
                              },
                              validator: (value) {
                                RegExp regex = new RegExp(r'^.{3,}$');
                                if (value == null || value.isEmpty) {
                                  return null;
                                } else if (!regex.hasMatch(value)) {
                                  return "El nombre debe tener como mínimo 3 caracteres";
                                }
                                return null;
                              },
                            ))),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: lastName,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Modificar apellido",
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(color: ArgonColors.azul),
                          ),
                          onSaved: (value) {
                            _lastNameController!.text = value!;
                          },
                          validator: (value) {
                            RegExp regex = new RegExp(r'^.{3,}$');
                            if (value == null || value.isEmpty) {
                              return null;
                            } else if (!regex.hasMatch(value)) {
                              return "El nombre debe tener como mínimo 3 caracteres";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: mail,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Mail',
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(color: ArgonColors.azul),
                          ),
                          onSaved: (value) {
                            _emailController!.text = value!;
                          },
                          validator: (value) {
                            RegExp regex = new RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                            if (value == null || value.isEmpty) {
                              return null;
                            } else if (!regex.hasMatch(value)) {
                              return "El formato del mail no es válido";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Center(
                        child: _image == null ? const Text(
                            "Modificar imagen de perfil",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ArgonColors.azul,
                                fontSize: 15)) : Image.file(
                            _image)
                    ),
                    const SizedBox(height: 20.0),
                    if(profileImage == null) Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceEvenly,
                      children: <Widget>[
                        FloatingActionButton(
                            onPressed: getImageFromCamera,
                            child: const Icon(Icons.add_a_photo),
                          backgroundColor: ArgonColors.verdeOscuro
                        ),
                        FloatingActionButton(
                          onPressed: getImageFromGallery,
                          child: const Icon(Icons.add_photo_alternate_outlined),
                          backgroundColor: ArgonColors.verdeOscuro
                        )
                      ],
                    ),
                    profileImage != null ? Stack(children: [
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Image.file(
                          profileImage!,
                          fit: BoxFit.cover,
                        ),
                      ),
                      FloatingActionButton.small(
                          child: Icon(Icons.delete, color: ArgonColors.white),
                          backgroundColor: Colors.red,
                          onPressed: () {
                            profileImage = null;
                            setState(() {});
                          }),
                    ] ): SizedBox.shrink(),
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Center(
                        child: FlatButton(
                          textColor: ArgonColors.white,
                          color: ArgonColors.verdeOscuro,
                          minWidth: 190,
                          onPressed: () async {
                            mail.currentState!.save();
                            mail.currentState!.validate();
                            firstName.currentState!.save();
                            firstName.currentState!.validate();
                            lastName.currentState!.save();
                            lastName.currentState!.validate();
                            if(_firstNameController!.text != "" || _lastNameController!.text != "" || profileImage != null || _emailController!.text != "") {
                              late MyUser _myUser;
                              if(profileImage == null) {
                                _myUser = MyUser(
                                    _firstNameController!.text,
                                    _lastNameController!.text,
                                    "",
                                    "",
                                    _emailController!.text);
                              } else {
                                await uploadFileToStorage();
                                _myUser = MyUser(
                                    _firstNameController!.text,
                                    _lastNameController!.text,
                                    "",
                                    photo_url,
                                    _emailController!.text);
                              }
                              UserService _userService = UserService();
                              _userService.editCurrentUser(_myUser);
                              setState(() {});
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Se modifico tu usuario',
                                    style: const TextStyle(
                                    color: ArgonColors.white),
                              )));
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: 16.0, right: 16.0, top: 12, bottom: 12),
                              child: Text("GUARDAR",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0))),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Center(
                        child: FlatButton(
                          textColor: ArgonColors.white,
                          color: ArgonColors.verdeOscuro,
                          minWidth: 190,
                          onPressed: () async {
                            await _googleSignIn.signOut();
                            FirebaseAuth.instance.signOut();
                            setState(() {});
                            Navigator.pushNamedAndRemoveUntil(context, '/onboarding',(r) => false);

                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: 16.0, right: 16.0, top: 12, bottom: 12),
                              child: Text("CERRAR SESIÓN",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0))),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ])
    )]));
  }
}
