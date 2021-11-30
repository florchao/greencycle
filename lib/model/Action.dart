class Action{
  String name;
  String score;
  String id;
  static const String collection_id = 'Acciones';

  Action(this.name, this.score, this.id);

  Action.fromSnapshot(Map<String, dynamic> action)
      : id = action['id'],
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