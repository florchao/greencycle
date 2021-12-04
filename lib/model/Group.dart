<<<<<<< Updated upstream
=======
import 'package:firebase_auth/firebase_auth.dart';

>>>>>>> Stashed changes
class Group{
  String name;
  String Id;
  String icon_url;
<<<<<<< Updated upstream
  String score;
  String weekly_score;
  List members;

  Group(this.name, this.Id, this.icon_url, this.members)
      : this.score= "",
        this.weekly_score = "";

  Group.fromSnapshot(String Id, Map<String, dynamic> group)
      : Id = Id,
        name = group['name'],
        icon_url = group['icon_url'],
        score = group['score'],
        weekly_score = group['weekly_score'],
        members = group['members'];
=======
  int score;
  String description;
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
>>>>>>> Stashed changes

  Map<String, dynamic> toMap() => {
    'name': name,
    'Id': Id,
    'icon_url': icon_url,
    'score': score,
<<<<<<< Updated upstream
    'weekly_score': weekly_score,
    'members': members,
=======
    'members' : members,
    'description' : description,
>>>>>>> Stashed changes
  };

  @override
  String toString() {
    return 'user{id: $Id, nombres: $name, score: $score, members: $members, iconURL:$icon_url}';
  }
}