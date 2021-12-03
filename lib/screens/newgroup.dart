import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:greencycle/constants/Theme.dart';
import 'package:greencycle/model/Group.dart';
import 'package:greencycle/services/group_service.dart';
import 'package:greencycle/widgets/input.dart';
import 'package:greencycle/widgets/navbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NewGroup extends StatelessWidget {

  final _groupNameController = TextEditingController();
  final _prize1stController = TextEditingController();
  final _prize2ndController = TextEditingController();
  final _prize3rdController = TextEditingController();

  final List<String> usernames = [
    'Felo',
    'Herni',
    'Flor',
    'Male',
    'Nicky',
    'Azu'
  ];

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
    MultipleNotifier _myMultipleNotifier = Provider.of<MultipleNotifier>(context);
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
                                    controller: _groupNameController
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
                                          controller: _prize1stController,
                                          suffixIcon: Icon(Icons.emoji_events),
                                        ),
                                        SizedBox( height: 8.0),
                                        Input(
                                          placeholder: "2do Puesto",
                                          controller: _prize2ndController,
                                          suffixIcon: Icon(Icons.emoji_events),
                                        ),
                                        SizedBox( height: 8.0),
                                        Input(
                                          placeholder: "3er Puesto",
                                          controller: _prize3rdController,
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
                                        onPressed: () {
                                          _showUserListDialog(context);
                                          data = _myMultipleNotifier._selectedItems;
                                        }
                                    ),
                                  ],
                                ),
                                Flexible(
                                  child: ListView.builder(
                                      itemCount: data.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          leading: Icon(Icons.account_circle),
                                          title: Text(data[index],
                                            style: TextStyle(color: ArgonColors.azul, fontSize: 14),),
                                          trailing: Icon(Icons.close, color: ArgonColors.azul)
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
                                      onPressed: () async{
                                        if(_groupNameController.text.isNotEmpty && _prize1stController.text.isNotEmpty
                                        && _prize2ndController.text.isNotEmpty && _prize3rdController.text.isNotEmpty) {
                                          Group _group = Group(_groupNameController.text, _image.toString());
                                          GroupService _groupService = GroupService();
                                          _groupService.addGroup(_group);
                                          Navigator.pushReplacementNamed(context, '/home');
                                        }
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