import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:greencycle/constants/Theme.dart';
import 'package:greencycle/model/MyUser.dart';
import 'package:greencycle/services/user_service.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final double height = window.physicalSize.height;

  final TextEditingController? _firstNameController = TextEditingController();
  final TextEditingController? _lastNameController = TextEditingController();
  final TextEditingController? _emailController = TextEditingController();
  final TextEditingController? _passwordController = TextEditingController();
  final TextEditingController? _confirmPasswordController = TextEditingController();
  final confirmPassword = GlobalKey<FormState>();
  final firstName = GlobalKey<FormState>();
  final mail = GlobalKey<FormState>();
  final lastName = GlobalKey<FormState>();
  final password = GlobalKey<FormState>();
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
    if(password.currentState!.validate() && mail.currentState!.validate() && firstName.currentState!.validate() && lastName.currentState!.validate() && confirmPassword.currentState!.validate()) {
      fToast.showToast(
        child: toast,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ArgonColors.verdeClaro,
        body: Stack(
          children: [
            SafeArea(
              child: ListView(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                      child: Column(
                        children: [
                          Container(
                              height: MediaQuery.of(context).size.height * 0.15,
                              decoration: BoxDecoration(
                                  color: ArgonColors.verdeClaro,
                                  ),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                          // width: 0,
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(context, '/onboarding');
                                            },
                                            child: Image.asset('assets/img/logoVerde.png', scale: 6),
                                          ),
                                      ],
                                    ),
                                  ),
                                  // Divider()
                                ],
                              )),
                          Container(
                              height: MediaQuery.of(context).size.height * 0.77,
                              color: ArgonColors.verdeClaro,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Form(
                                              key: firstName,
                                              child: TextFormField(
                                              decoration: const InputDecoration(
                                                labelText: 'Nombre',
                                                border: OutlineInputBorder(),
                                                labelStyle: TextStyle(color: ArgonColors.azul),
                                              ),
                                              onSaved: (value){
                                                _firstNameController!.text = value!;
                                              },
                                                validator: (value) {
                                                  RegExp regex = new RegExp(r'^.{3,}$');
                                                  if (value == null || value.isEmpty) {
                                                    return "El nombre es un campo requerido";
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
                                              key: lastName,
                                              child: TextFormField(
                                              decoration: InputDecoration(
                                                labelText: 'Apellido',
                                                border: OutlineInputBorder(),
                                                labelStyle: TextStyle(color: ArgonColors.azul),
                                              ),
                                                onSaved: (value){
                                                  _lastNameController!.text = value!;
                                                },
                                                validator: (value) {
                                                  RegExp regex = new RegExp(r'^.{3,}$');
                                                  if (value == null || value.isEmpty) {
                                                    return "El apellido es un campo requerido";
                                                  }
                                                  else if(!regex.hasMatch(value)){
                                                    return "El apellido debe tener como mínimo 3 caracteres";
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
                                                RegExp regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                                                if(value == null || value.isEmpty){
                                                  return "El mail es un campo requerido";
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
                                              key:password,
                                              child: TextFormField(
                                              decoration: InputDecoration(
                                                labelText: 'Contraseña',
                                                border: OutlineInputBorder(),
                                                labelStyle: TextStyle(color: ArgonColors.azul),
                                              ),
                                                obscureText: true,
                                                onSaved: (value){
                                                _passwordController!.text = value!;
                                                },
                                                validator: (value){
                                                  RegExp regex = new RegExp(r'^.{6,}$');
                                                    if (value == null || value.isEmpty){
                                                      return "La contraseña es un campo requerido";
                                                    }
                                                    else if(!regex.hasMatch(value)){
                                                      return "La contraseña debe tener como mínimo 6 caracteres";
                                                    }
                                                    else if (_passwordController!.text != _confirmPasswordController!.text){
                                                      return "Las contraseñas deben coincidir";
                                                    }
                                                    return null;
                                                },
                                            ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Form(
                                              key: confirmPassword,
                                              child: TextFormField(
                                              decoration: const InputDecoration(
                                                labelText: 'Confirmar contraseña',
                                                border: OutlineInputBorder(),
                                                labelStyle: TextStyle(color: ArgonColors.azul),
                                              ),
                                              onSaved: (value){
                                                _confirmPasswordController!.text = value!;
                                              },
                                                validator: (value){
                                                if (_passwordController!.text != _confirmPasswordController!.text){
                                                      return "Las contraseñas deben coincidir";
                                                    }
                                                else if(value == null || value.isEmpty){
                                                  return "Confirmar contraseña es un campo requerido";
                                                  }
                                                    return null;
                                                },
                                              obscureText: true,
                                            ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 24.0),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Center(
                                          child: FlatButton(
                                            textColor: ArgonColors.white,
                                            color: ArgonColors.verdeOscuro,
                                            onPressed: () async {
                                              password.currentState!.save();
                                              password.currentState!.validate();
                                              mail.currentState!.save();
                                              mail.currentState!.validate();
                                              confirmPassword.currentState!.save();
                                              confirmPassword.currentState!.validate();
                                              firstName.currentState!.save();
                                              firstName.currentState!.validate();
                                              lastName.currentState!.save();
                                              lastName.currentState!.validate();
                                              User? user = FirebaseAuth.instance.currentUser;
                                              await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                                  email: _emailController!.text,
                                                  password: _passwordController!.text,
                                              );

                                              FirebaseAuth.instance.currentUser!.updateDisplayName(_firstNameController!.text+" "+_lastNameController!.text);
                                              MyUser _myUser = MyUser(_firstNameController!.text, _lastNameController!.text, FirebaseAuth.instance.currentUser!.uid, FirebaseAuth.instance.currentUser!.photoURL, _emailController!.text);
                                              UserService _userService = UserService();
                                              _userService.create(_myUser);
                                              setState(() {});
                                              Navigator.pushNamed(context, '/home');
                                            },
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(4.0),
                                            ),
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 16.0,
                                                    right: 16.0,
                                                    top: 10),
                                                child: Text("REGISTRARSE",
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        fontSize: 16.0))),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      )),
              ]),
            )
          ],
        ));
  }
}
