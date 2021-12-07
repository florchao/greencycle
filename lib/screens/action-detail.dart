import 'package:flutter/material.dart';
import 'package:greencycle/constants/Theme.dart';
import 'package:greencycle/model/MyAction.dart';
import 'package:greencycle/services/action_service.dart';


class ActionDetail extends StatefulWidget {
  @override
  State<ActionDetail> createState() => _ActionDetailState();
}

class _ActionDetailState extends State<ActionDetail> {
  String ? actionName;

  ActionService _actionService = ActionService();
  late MyAction _action;
  int _listCount = 0;
  List<String>? _actionFieldsList = [];
  late AsyncSnapshot<MyAction> _actionSnapshot;

  Future<MyAction>? loading;
  
  Future<MyAction> load(String actionId) async {
    await _actionService.getAction(actionId).then((value) => _action = value!);
    return _action;
  }

  MyAction _myAction = MyAction('Reciclaje', '', 'Descrip.',
      new Map<String, dynamic>(), new Map<String, dynamic>(),
      0, 0, 0);

  Map<String, List> _categories = new Map();

  List<String> _recycle = ['Papel y cartón', 'Metales', 'Vidrio', 'Plástico'];

  List<String> _transport = ['Bicicleta', 'Público'];

  List<String> _plant = ['Árboles'];

  List<String> _ecoProducts = ['Ecoproductos'];

  List<String> _lightGasBills = ['Consumo de luz y gas'];

  List<String> _compost = ['Compost'];

  Map<String, String> _fieldNames = new Map();

  Map<String, String> _units = new Map();

  @override
  Widget build(BuildContext context) {
    final String actionId = ModalRoute.of(context)!.settings.arguments as String;

    _categories['Reciclaje'] = _recycle;
    _categories['Transporte'] = _transport;
    _categories['Plantar'] = _plant;
    _categories['Ecoproductos'] = _ecoProducts;
    _categories['Factura de luz y gas'] = _lightGasBills;
    _categories['Compost'] = _compost;

    _units['Reciclaje'] = 'unidades';
    _units['Transporte'] = 'km';
    _units['Plantar'] = 'unidades';
    _units['Ecoproductos'] = 'unidades';
    _units['Factura de luz y gas'] = ' '; // TODO: fijarse que unidad de medida tomar
    _units['Compost'] = 'kg';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle acción"),
        backgroundColor: ArgonColors.verdeOscuro,
      ),
      backgroundColor: ArgonColors.verdeClaro,
      body: FutureBuilder<MyAction>(
        future:load(actionId),
        builder: (BuildContext context, AsyncSnapshot<MyAction> snapshot) {
          print('SNAPSHOT');
          print(snapshot);
          if(snapshot.hasData) {
            String actionName = snapshot.data!.name;
            print('NAME');
            print(actionName);
            _actionFieldsList = _categories[actionName]!.cast<String>();
            _actionSnapshot = snapshot;
            print(_actionFieldsList);
            return Stack(
              children: <Widget>[
                SafeArea(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 40),
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset: Offset(0, 3)
                                )
                              ]
                          ),
                          child: Card(
                              elevation: .0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0))
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16, left: 24.0, right: 24.0, bottom: 32),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0, top: 32, bottom: 32),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text('Acción: ' + snapshot.data!.name,
                                              textAlign: TextAlign.right,
                                              style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 30)),
                                        ),
                                      ),
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget> [
                                            ActionFieldsList(),

                                            if(actionName == 'Reciclaje')
                                              RecycleData(),

                                            if(actionName == 'Transporte')
                                              TransportData(),

                                            if(actionName == 'Plantar')
                                              PlantsData(),

                                            if(actionName == 'Ecoproductos')
                                              EcoProductsData(),

                                            if(actionName == 'Compost')
                                              CompostData(),
                                            // TODO: light and gas bills
                                            UnitsDisplay(actionName)
                                          ]
                                      ),
                                      SizedBox(height: 20),
                                      Image.network("https://images.unsplash.com/photo-1516559828984-fb3b99548b21?ixlib=rb-1.2.1&auto=format&fit=crop&w=2100&q=80"),
                                      SizedBox(height: 20),
                                      Text(snapshot.data!.description,
                                          style: TextStyle(color: ArgonColors.azul, fontSize: 16))
                                    ],
                                  )
                              )
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          } else {
            return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 10.0),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                )
            );
          }
        },
      )
    );
  }

  Widget ActionFieldsList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for(var field in _actionFieldsList!)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(field,
                style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 18)
            ),
          )
      ],
    );
  }

  Widget RecycleData() {
    List<int>? list = _actionSnapshot.data!.recycling.values.toList() as List<int>;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for(var field in list)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(field.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 18)
            ),
          )
      ],
    );
  }

  Widget TransportData() {
    Iterable list = _actionSnapshot.data!.transport.values;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for(var field in list!)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(field.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 18)
            ),
          )
      ],
    );
  }

  Widget PlantsData() {
    int plants = _actionSnapshot.data!.plants;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(plants.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 18)
          ),
        )
      ],
    );
  }

  Widget EcoProductsData() {
    int ecoProducts = _actionSnapshot.data!.ecoProducts;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(ecoProducts.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 18)
          ),
        )
      ],
    );
  }

  Widget CompostData() {
    int compost = _actionSnapshot.data!.compost;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(compost.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 18)
          ),
        )
      ],
    );
  }

  Widget UnitsDisplay(String name) {
    print(_units[name]);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for(var field in _actionFieldsList!)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(_units[name]!,
                style: TextStyle(fontWeight: FontWeight.bold, color: ArgonColors.azul, fontSize: 18)
            ),
          )
      ],
    );
  }

}