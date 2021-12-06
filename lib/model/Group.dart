
import 'package:firebase_auth/firebase_auth.dart';

class Group{
  String name;
  String icon_url;
  String description;
  String id;
  int score;
  Map<String, dynamic> members;
  List<String> actions;

  static const String collection_id = 'Grupos';

  Group(this.name, this.icon_url, this.description)
      : this.score= 0,
        this.id = "",
        this.actions = [],
        this.members = {FirebaseAuth.instance.currentUser!.uid : 0};

  Group.fromSnapshot(String id, Map<String, dynamic> group)
    : id = id,
      name = group['name'],
      icon_url = group['icon_url'],
      score = group['score'],
      description = group['description'],
      actions = List.from(group['actions']),
      members = group['members'];

  Map<String, dynamic> toMap() => {
    'name': name,
    'icon_url': icon_url,
    'score': score,
    'members' : members,
    'actions' : actions,
    'description': description,
  };

  @override
  String toString() {
    return '$name,$score,$members, icon_url:$icon_url, score: $score}';
  }
}