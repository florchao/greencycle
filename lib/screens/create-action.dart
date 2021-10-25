import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:greencycle/constants/Theme.dart';
import 'package:greencycle/widgets/navbar.dart';
import 'package:image_picker/image_picker.dart';

class CreateAction extends StatefulWidget{
  @override
  _CreateActionState createState() => _CreateActionState();
}

class _CreateActionState extends State<CreateAction> {
  List<String> listItem = ["Reciclaje", "Reciclaje2", "Reciclaje3", "Reciclaje4", "Reciclaje5"];
  Object? _valueChoose;
  String comment = '';
  var _image = null;

  Future getImageFromCamera() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image as File;
    });
  }

  Future getImageFromGallery() async {
    final picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery
    );

    setState(() {
      _image = image as File;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: "CreateAction",
        rightOptions: false, tags: [],
      ),
      backgroundColor: ArgonColors.verdeClaro,
      body: ListView(
        children: <Widget>[
          Padding(padding: const EdgeInsets.only(left: 8.0, top: 32, bottom: 5.0),
              child: Text("Nueva Acción", style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 20))
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
            child:
            //Dropdown
            DropdownButtonFormField(
              items: listItem.map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text('$e'),
                );
              }).toList(),
              onChanged: (val) => setState(() => _valueChoose = val),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 8.0),
            child:
              MaterialCounterWidget("Metales"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 8.0),
            child:
            MaterialCounterWidget("Papel y cartón"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 8.0),
            child:
            MaterialCounterWidget("Vidrio"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 8.0),
            child:
            MaterialCounterWidget("Plástico"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100.0,
              child: Center(
                child: _image == null ? Text("Agregar una imagen", style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 15)) : Image.file(_image),
              )
            )
          ),
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
          // Comments
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
            child:
            //Comments
            TextFormField(
              onChanged: (val) => setState(() => comment = val),
            ),
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
                    child: Text("GURDAR ACCIÓN",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0))),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget MaterialCounterWidget(String material){
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text('$material', style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 15)),
        ),
        TextField(
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
        ),
      ]
    );
  }

}

