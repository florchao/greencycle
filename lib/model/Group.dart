
import 'package:firebase_auth/firebase_auth.dart';

class Group{
  String name;
  String icon_url;
  String description;
  int score;
  Map<String, dynamic> members;

  static const String collection_id = 'Grupos';

  Group(this.name, this.icon_url, this.description)
      : this.score= 0,
        this.members = {FirebaseAuth.instance.currentUser!.uid : 0};

  Group.fromSnapshot(Map<String, dynamic> group)
    : name = group['name'],
      icon_url = group['icon_url'],
      score = group['score'],
      description = group['description'],
      members = group['members'];

  Map<String, dynamic> toMap() => {
    'name': name,
    'icon_url': icon_url,
    'score': score,
    'members' : members,
    'description': description,
  };

  @override
  String toString() {
    return '$name,$score,$members, icon_url:$icon_url, score: $score}';
  }
}