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
  double compost;
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
    'score': getScore(),
    'date': date,
    'owner': owner,
    'transport': transport,
    'recycling': recycling,
    'compost': compost,
    'ecoProducts': ecoProducts,
    'plants': plants,
  };

  int getScore(){
    double aux = 0;
    if(_score != 0){
      return _score;
    }
    if(transport.isNotEmpty) {
      aux += (transport['bike'] as double) * 5;
      aux += (transport['publicTransport'] as double) * 3;
    }
    if(recycling.isNotEmpty) {
      aux += (recycling['glass'] as int) * 15;
      aux += (recycling['plastic'] as int) * 10;
      aux += (recycling['aluminum'] as int) * 5;
      aux += (recycling['Peper'] as int) * 2;
    }
    if(compost !=0)
    aux += (compost * 10);

    if(ecoProducts !=0)
    aux += ecoProducts * 7;
    if (plants!=0)
    aux += plants * 7;
    _score = aux.toInt();
    return _score;
  }

  @override
  String toString() {
    return 'user{nombres: $name, valor: $_score}';
  }

}