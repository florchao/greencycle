import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyAction{
  String name;
  String icon_url;
  String description;
  int _score;
  DateTime date;
  String owner;
  Map<String, dynamic> transport;
  Map<String, dynamic> recycling;
  int compost;
  int ecoProducts;
  int plants;
  String id;

  static const String collection_id = 'Actions';

  MyAction(this.name, this.icon_url, this.description, this.transport, this.recycling, this.compost,
      this.ecoProducts, this.plants)
    : _score = 0,
      date = DateTime.now(),
      id = "",
      owner = FirebaseAuth.instance.currentUser!.uid;

  MyAction.fromSnapshot(String id, Map<String, dynamic> action)
      : id = id,
        name = action['name'],
        icon_url = action['icon_url'],
        description = action['description'],
        _score = action['score'],
        date = action['date'].toDate(),
        owner = action['owner'],
        transport = action['transport'],
        recycling = action['recycling'],
        compost = action['compost'],
        ecoProducts = action['ecoProducts'],
        plants = action['plants'];
        //id = action['id'];

  Map<String, dynamic> toMap() => {
    'name': name,
    'icon_url': icon_url,
    'description': description,
    'score': _score,
    'date': date,
    'owner': owner,
    'transport': transport,
    'recycling': recycling,
    'compost': compost,
    'ecoProducts': ecoProducts,
    'plants': plants,
  };

  int getScore(){
    int aux = 0;
    if(_score != 0){
      return _score;
    }
    aux += (transport['bike'] as int) * 5;
    aux += (transport['publicTransport'] as int) * 3;
    aux += (recycling['glass'] as int) * 15;
    aux += (recycling['plastic'] as int) * 10;
    aux += (recycling['aluminum'] as int) * 5;
    aux += (recycling['Peper'] as int) * 2;
    aux += compost * 10;
    aux += ecoProducts * 7;
    aux += plants * 7;
    _score = aux;
    return _score;
  }

  @override
  String toString() {
    return 'user{nombres: $name, valor: $_score}';
  }

}