import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:greencycle/constants/Theme.dart';
import 'package:greencycle/model/MyUser.dart';
import 'package:greencycle/services/user_service.dart';
import 'package:greencycle/widgets/input.dart';

//widgets
import 'package:greencycle/widgets/navbar.dart';

import 'package:greencycle/widgets/drawer.dart';

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



  @override
  Widget build(BuildContext context) {
    GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['profile']);
    return Scaffold(
        backgroundColor: ArgonColors.verdeClaro,
        appBar: AppBar(
          title: const Text("Configuración"),
          backgroundColor: ArgonColors.verdeOscuro,
        ),
        drawer: ArgonDrawer(currentPage: "Configuración"),
        body:  Container(
            color: ArgonColors.verdeClaro,
            child: Center(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  mainAxisAlignment:
                  MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                          key: firstName,
                          child:TextFormField(
                            decoration: const InputDecoration(
                              labelText: "Modificar nombre",
                              border: OutlineInputBorder(),
                              labelStyle: TextStyle(color: ArgonColors.azul),
                            ),
                            onSaved: (value){
                              _firstNameController!.text = value!;
                            },
                            validator: (value) {
                              RegExp regex = new RegExp(r'^.{3,}$');
                              if (value == null || value.isEmpty) {
                                return null;
                              }
                              else if(!regex.hasMatch(value)){
                                return "El nombre debe tener como mínimo 3 caracteres";
                              }
                              return null;
                            },
                          ))),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                            key: lastName,
                            child:TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Modificar apellido",
                                border: OutlineInputBorder(),
                                labelStyle: TextStyle(color: ArgonColors.azul),
                              ),
                              onSaved: (value){
                                _lastNameController!.text = value!;
                              },
                              validator: (value) {
                                RegExp regex = new RegExp(r'^.{3,}$');
                                if (value == null || value.isEmpty) {
                                  return null;
                                }
                                else if(!regex.hasMatch(value)){
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
                              validator: (value){
                                RegExp regex = new RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                                if(value == null || value.isEmpty){
                                  return null;
                                }
                                else if (!regex.hasMatch(value)){
                                  return "El formato del mail no es válido";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                            key: image,
                            child:TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Modificar imagen",
                                border: OutlineInputBorder(),
                                labelStyle: TextStyle(color: ArgonColors.azul),
                              ),
                              onSaved: (value){
                                _imageController!.text = value!;
                              },
                              validator: (value) {
                                RegExp regex = new RegExp(r'[(http(s)?):\/\/(www\.)?a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)$');
                                if (value == null || value.isEmpty) {
                                  return null;
                                }
                                else if(!regex.hasMatch(value)){
                                  return "La imagen debe ser una dirección URL";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24.0),
                        ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Center(
                    child: FlatButton(
                      textColor: ArgonColors.white,
                      color: ArgonColors.verdeOscuro,
                      onPressed: () async {
                        mail.currentState!.save();
                        mail.currentState!.validate();
                        image.currentState!.save();
                        image.currentState!.validate();
                        firstName.currentState!.save();
                        firstName.currentState!.validate();
                        lastName.currentState!.save();
                        lastName.currentState!.validate();
                        print(FirebaseAuth.instance.currentUser!);
                        MyUser _myUser = MyUser(_firstNameController!.text, _lastNameController!.text, FirebaseAuth.instance.currentUser!.uid, _imageController!.text, _emailController!.text);
                        UserService _userService = UserService();
                        _userService.editCurrentUser(_myUser);
                        setState(() {});
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(4.0),
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: 16.0,
                              right: 16.0,
                              top: 12,
                              bottom: 12),
                          child: Text("GUARDAR",
                              style: TextStyle(
                                  fontWeight:
                                  FontWeight.w600,
                                  fontSize: 16.0))),
                    ),
                  ),
                ),
                        Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: Center(
                            child: FlatButton(
                              textColor: ArgonColors.white,
                              color: ArgonColors.verdeOscuro,
                              onPressed: () async {
                                // Habria que hacer un checkeo para que se fije si inicie sesino con google o no
                                await _googleSignIn.signOut();
                                FirebaseAuth.instance.signOut();
                                setState(() {}); // Esto es para forzar un refresh nadamas
                                Navigator.pushReplacementNamed(
                                    context, '/onboarding');
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(4.0),
                              ),
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 16.0,
                                      right: 16.0,
                                      top: 12,
                                      bottom: 12),
                                  child: Text("CERRAR SESIÓN",
                                      style: TextStyle(
                                          fontWeight:
                                          FontWeight.w600,
                                          fontSize: 16.0))),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }
}
