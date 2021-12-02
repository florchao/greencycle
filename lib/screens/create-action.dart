import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:greencycle/constants/Theme.dart';
import 'package:image_picker/image_picker.dart';

class CreateAction extends StatefulWidget{
  @override
  _CreateActionState createState() => _CreateActionState();
}

class _CreateActionState extends State<CreateAction> {
  List<String> categoryList = ["Reciclaje", "Transporte", "Plantar", "Ecoproductos", "Factura de luz y gas", "Compost"];
  List<String> recycleList = ["Metales", "Plástico", "Papel y Cartón", "Vidrio"];
  List<String> transportList = ["Bicicleta", "Público"];
  String categoryChoose = '';
  String actionValue = '';
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
      appBar: AppBar(
        title: const Text("Nueva Acción"),
        backgroundColor: ArgonColors.verdeOscuro,
      ),
      backgroundColor: ArgonColors.verdeClaro,
      body: ListView(
        children: <Widget>[
          Padding(padding: const EdgeInsets.only(left: 8.0, top: 32, bottom: 5.0),
            child: Text("Categoría", style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 18)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
            child:
            //Dropdown
            DropdownButtonFormField(
              items: categoryList.map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text('$e'),
                );
              }).toList(),
              onChanged: (val) => setState(() => categoryChoose = val.toString()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 8.0),
            child:
            ShowActionOptions(categoryChoose),
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
          Padding(padding: const EdgeInsets.only(left: 8.0, top: 32, bottom: 5.0),
            child: Text("Comentarios", style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 18)),
          ),
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
                    child: Text("GUARDAR ACCIÓN",
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

  Widget ShowActionOptions(String material){
    switch(material){
      case 'Reciclaje':
        return ButtonList(recycleList);
      case 'Transporte':
        return ButtonList(transportList);
      case 'Plantar':
        return MaterialCounterWidget('árboles');
      case 'Ecoproductos':
        return MaterialCounterWidget('unidades');
      case 'Compost':
        return MaterialCounterWidget('kilos');
      case 'Factura de luz y gas':
        return UploadFileButton();
      default:
        return SizedBox.shrink();
    };
  }

  Widget UploadFileButton(){
    return SizedBox.shrink();
  }

  Widget MaterialCounterWidget(String units){
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: TextField(
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          ),
          Expanded(
              child: Text('$units', style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 18)))
        ]
    );
  }

  Widget ButtonList(List<String> l){
    return Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
        child:
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: l.length,
          itemBuilder: (BuildContext context, int index) {
            return new SizedBox(
              width: double.infinity,
              child: FlatButton(
                textColor: ArgonColors.white,
                color: l[index] == actionValue ? Colors.amber : ArgonColors.verdeOscuro,
                onPressed: () {
                  actionValue = l[index];
                  setState(() {});
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Padding(
                    padding: EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 12, bottom: 10),
                    child: Text(l[index],
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0))),
              ),
            );
          },
        )
    );
  }

}

