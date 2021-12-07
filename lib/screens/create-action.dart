import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:greencycle/constants/Theme.dart';
import 'package:greencycle/model/MyAction.dart';
import 'package:greencycle/model/MyUser.dart';
import 'package:greencycle/services/user_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_elegant_number_button/flutter_elegant_number_button.dart';

class CreateAction extends StatefulWidget{
  @override
  _CreateActionState createState() => _CreateActionState();
}

class _CreateActionState extends State<CreateAction> {
  List<String> categoryList = ["Reciclaje", "Transporte", "Plantar", "Ecoproductos", "Factura de luz y gas", "Compost"];
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
  File? groupImage = null;
  UserService userService = new UserService();

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
    final destination = 'ActionImages/' + fileName;

    final ref = FirebaseStorage.instance.ref(destination);

    UploadTask uploadTask = ref.putFile(groupImage!);
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
              ),
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
                backgroundColor: Colors.red,
                onPressed: () {
                  groupImage = null;
                  setState(() {});
                }),
          ] ): SizedBox.shrink(),
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

                  print(groupImage!.path);
                  if(categoryChoose == 'Reciclaje'){
                    if (_image == null){
                      _image = "";
                    }
                    MyAction action = new MyAction("Reciclaje", _image, comment, {},  {'glass': counterRecycle[3], 'plastic': counterRecycle[1], 'aluminum': counterRecycle[0], 'Peper': counterRecycle[2]}, 0, 0, 0);
                    userService.addAction(action);
                  }
                  else if(categoryChoose == 'Transporte'){
                    if (_image == null){
                      _image = "";
                    }
                    MyAction action = new MyAction("Transporte", _image, comment, {'bike': counterTransport[0], 'publicTransport': counterTransport[1]},  {}, 0, 0, 0);
                    userService.addAction(action);
                  }
                  else if(categoryChoose == 'Plantar'){
                    if (_image == null){
                      _image = "";
                    }
                    MyAction action = new MyAction("Plantar", _image, comment, {},  {}, 0, 0, countPlanta as int);
                    userService.addAction(action);
                  }
                  else if(categoryChoose == 'Ecoproductos'){
                    if (_image == null){
                      _image = "";
                    }
                    MyAction action = new MyAction("Ecoproductos", _image, comment, {},  {}, 0, countProductos as int, 0);
                    userService.addAction(action);
                  }
                  else if(categoryChoose == 'Compost'){
                    if (_image == null){
                      _image = "";
                    }
                    late MyAction action;
                    if (groupImage == null) {
                      // Todo hacer que se cargue una imagen random de las x ya precargadas
                      action = new MyAction("Compost", "Imagen_precargada", comment, {},  {}, countCompost as int, 0, 0);
                    } else {
                      action = new MyAction("Compost", groupImage!.path, comment, {},  {}, countCompost as int, 0, 0);
                    }
                    uploadFileToStorage();
                    userService.addAction(action);
                  }
                  if (_image == null){
                    _image = "";
                  }
                  else if(categoryChoose == 'Factura de luz y gas'){ //DESPUES HAY QUE VER COMO SE CARGAN LAS FOTOS
                    MyAction action = new MyAction("Factura de luz y gas", _image, comment, {},  {}, 0, 0, 0);
                    userService.addAction(action);
                  }
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
      case 'Plantar':
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
                          Text("Kilómetros en " + transportList[index], style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 18)),
                          ElegantNumberButton(
                            initialValue: counterTransport[index],
                            minValue: 0,
                            maxValue: 100,
                            step: 0.1,
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


