class MyAction{
  String name;
  int score;
  String id;
  static const String collection_id = 'Acciones';

  MyAction(this.name, this.score, this.id);

  MyAction.fromSnapshot(String Id, Map<String, dynamic> action)
      : id = Id,
        name = action['name'],
        score = action['score'];

  Map<String, dynamic> toMap() => {
    'name': name,
    'score': score,
    'id': id,
  };

  @override
  String toString() {
    return 'user{id: $id, nombres: $name, valor: $score}';
  }

}