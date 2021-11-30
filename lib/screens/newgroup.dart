import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:greencycle/constants/Theme.dart';
import 'package:greencycle/widgets/input.dart';
import 'package:greencycle/widgets/navbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NewGroup extends StatelessWidget {

  final List<String> usernames = [
    'Felo',
    'Herni',
    'Flor',
    'Male',
    'Nicky',
    'Azu'
  ];
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
    return Scaffold(
        appBar: AppBar(
          title: const Text("Nuevo Grupo"),
          backgroundColor: ArgonColors.verdeOscuro,
        ),
      backgroundColor: ArgonColors.verdeClaro,
      body:Stack(
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
                        height: MediaQuery.of(context).size.height,
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
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Center(
                                  child: _image == null ? Text("Agregar una imagen",
                                      style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 15)) : Image.file(_image)
                                ),
                                // Image.network("https://images.unsplash.com/photo-1516559828984-fb3b99548b21?ixlib=rb-1.2.1&auto=format&fit=crop&w=2100&q=80"),
                                SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text('Premios',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 20)
                                          )
                                        ),
                                        SizedBox( height: 8.0),
                                        Input(
                                          placeholder: "1er Puesto",
                                          suffixIcon: Icon(Icons.emoji_events),
                                        ),
                                        SizedBox( height: 8.0),
                                        Input(
                                          placeholder: "2do Puesto",
                                          suffixIcon: Icon(Icons.emoji_events),
                                        ),
                                        SizedBox( height: 8.0),
                                        Input(
                                          placeholder: "3er Puesto",
                                          suffixIcon: Icon(Icons.emoji_events),
                                        )
                                      ],
                                    )
                                ),
                                SizedBox(height: 8.0),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text('Integrantes',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 20)),
                                      ),
                                    ),
                                    FloatingActionButton.small(
                                        tooltip: 'Agregar',
                                        child: const Icon(Icons.add),
                                        backgroundColor: ArgonColors.azul,
                                        onPressed: () => _showUserListDialog(context)
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: FlatButton(
                                      textColor: ArgonColors.white,
                                      color: ArgonColors.verdeOscuro,
                                      onPressed: () {
                                        Navigator.pushReplacementNamed(context, '/home');
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4.0),
                                      ),
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 16.0, right: 16.0, top: 12, bottom: 10),
                                          child: Text("GUARDAR GRUPO",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
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

  _showUserListDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
        final _multipleNotifier = Provider.of<MultipleNotifier>(context);
        return AlertDialog(
          title: Text('Selecciona los usuarios a agregar',
              style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 20)),
          content: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: usernames.map((e) => CheckboxListTile(
                    title: Text(e),
                    onChanged: (value) {
                      value! ? _multipleNotifier.addItem(e) : _multipleNotifier.removeItem(e);
                    },
                  value: _multipleNotifier.isInList(e),
                )).toList()
              )
            )
          ),
          actions: [
            TextButton(
              child: Text('CANCELAR'),
                onPressed: () => Navigator.of(context).pop()
            ),
            TextButton(
              child: const Text('AGREGAR'),
              onPressed: () => Navigator.of(context).pop()
            )
          ],
        );
      });

}

class MultipleNotifier extends ChangeNotifier {
  List<String> _selectedItems;

  MultipleNotifier(this._selectedItems);
  List<String> get selectedItems => _selectedItems;

  bool isInList(String value) => _selectedItems.contains(value);

  addItem(String value) {
    if (!isInList(value)) {
      _selectedItems.add(value);
      notifyListeners();
    }
  }

  removeItem(String value) {
    if(isInList(value)) {
      _selectedItems.remove(value);
      notifyListeners();
    }
  }

}