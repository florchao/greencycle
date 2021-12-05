import 'package:firebase_auth/firebase_auth.dart';

class MyAction{
  String name;
  String icon_url;
  String description;
  int score;
  DateTime date;
  String owner;
  Map<String, dynamic> transport;
  Map<String, dynamic> recycling;
  int compost;
  int ecoProducts;
  int plants;
  String id;

  static const String collection_id = 'Acciones';

  MyAction(this.name, this.icon_url, this.description, this.transport, this.recycling, this.compost,
      this.ecoProducts, this.plants)
    : score = 0,
      date = DateTime.now(),
      id = "",
      owner = FirebaseAuth.instance.currentUser!.uid;

  MyAction.fromSnapshot(Map<String, dynamic> action)
      : name = action['name'],
        icon_url = action['icon_url'],
        description = action['description'],
        score = action['score'],
        date = action['date'],
        owner = action['owner'],
        transport = action['transport'],
        recycling = action['recycling'],
        compost = action['compost'],
        ecoProducts = action['ecoProducts'],
        plants = action['plants'],
        id = action['id'];

  Map<String, dynamic> toMap() => {
    'name': name,
    'icon_url': icon_url,
    'description': description,
    'score': score,
    'date': date,
    'owner': owner,
    'transport': transport,
    'recycling': recycling,
    'compost': compost,
    'ecoProducts': ecoProducts,
    'plants': plants,
    'id' : id,
  };

  @override
  String toString() {
    return 'user{nombres: $name, valor: $score}';
  }

}