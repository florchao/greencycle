import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:greencycle/constants/Theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_elegant_number_button/flutter_elegant_number_button.dart';

class CreateAction extends StatefulWidget{
  @override
  _CreateActionState createState() => _CreateActionState();
}

class _CreateActionState extends State<CreateAction> {
  List<String> categoryList = ["Reciclaje", "Transporte", "Planta", "Ecoproductos", "Factura de luz y gas", "Compost"];
  List<String> recycleList = ["Metales", "Plástico", "Papel y Cartón", "Vidrio"];
  List<String> transportList = ["Bicicleta", "Público"];
  List<num> counterRecycle = [0,0,0,0];
  List<num> counterTransport = [0,0];
  num countPlanta=0;
  num countProductos=0;
  num countCompost=0;
  String categoryChoose = '';
  String actionValue = '';
  String actionUnits = '';
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
        return RecycleList(recycleList);
      case 'Transporte':
        return TransporteList(transportList);
      case 'Planta':
         return Padding(
             padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
             child:Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Unidades de árboles", style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 18)),
                ElegantNumberButton(
                  initialValue: countPlanta,
                  minValue: 0,
                  maxValue: 100,
                  step: 1,
                  decimalPlaces: 0,
                  color: ArgonColors.verdeOscuro,
                  buttonSizeHeight: 30,
                  buttonSizeWidth: 30,
                  onChanged: (value){
                    setState(() {
                      countPlanta = value;
                    });
                  },
                )
              ],
            )
        ));
      case 'Ecoproductos':
        return Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
            child:Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Unidades de ecoproductos", style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 18)),
                ElegantNumberButton(
                  initialValue: countProductos,
                  minValue: 0,
                  maxValue: 100,
                  step: 1,
                  decimalPlaces: 0,
                  color: ArgonColors.verdeOscuro,
                  buttonSizeHeight: 30,
                  buttonSizeWidth: 30,
                  onChanged: (value){
                    setState(() {
                      countProductos = value;
                    });
                  },
                )
              ],
            )
        ));
      case 'Compost':
        return Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
            child:Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Kilos de compost ", style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 18)),
            ElegantNumberButton(
            initialValue: countCompost,
            minValue: 0,
            maxValue: 100,
            step: 0.1,
            decimalPlaces: 1,
            color: ArgonColors.verdeOscuro,
            buttonSizeHeight: 30,
            buttonSizeWidth: 30,
            onChanged: (value){
              setState(() {
                countCompost = value;
              });
            },
          )
            ],
          )
        ));
      case 'Factura de luz y gas':
        return UploadFileButton();
      default:
        return SizedBox.shrink();
    }
  }

  Widget UploadFileButton(){
    return SizedBox.shrink();
  }

  Widget MaterialCounterWidget(String units){
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: TextField(
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (val) => setState(() => actionUnits = val),
          ),
          ),
          Expanded(
              child: Text('$units', style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 18)))
        ]
    );
  }

  Widget RecycleList(List<String> l){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
          child:
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: l.length,
              itemBuilder: (BuildContext context, int index) {
                return new Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Unidades de " + recycleList[index], style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 18)),
                        ElegantNumberButton(
                          initialValue: counterRecycle[index],
                          minValue: 0,
                          maxValue: 100,
                          step: 1,
                          decimalPlaces: 0,
                          color: ArgonColors.verdeOscuro,
                          buttonSizeHeight: 30,
                          buttonSizeWidth: 30,
                          onChanged: (value){
                            setState(() {
                              counterRecycle[index] = value;
                            });
                          },
                        )
                      ],
                    )
                );
              },
            )
        ),
      ]
    );
  }

  Widget TransporteList(List<String> l){
    return Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
              child:
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: l.length,
                itemBuilder: (BuildContext context, int index) {
                  return new Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Unidades de " + transportList[index], style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 18)),
                          ElegantNumberButton(
                            initialValue: counterTransport[index],
                            minValue: 0,
                            maxValue: 100,
                            step: 1,
                            decimalPlaces: 0,
                            color: ArgonColors.verdeOscuro,
                            buttonSizeHeight: 30,
                            buttonSizeWidth: 30,
                            onChanged: (value){
                              setState(() {
                                counterTransport[index] = value;
                              });
                            },
                          )
                        ],
                      )
                  );
                },
              )
          ),
        ]
    );
  }

}

