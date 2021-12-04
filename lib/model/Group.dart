import 'package:flutter/cupertino.dart';

class Group{
  String name;
  String icon_url;
  int score;
  List<String> members;
  List<String> membersScore;

  static const String collection_id = 'Grupos';

  Group(this.name, this.icon_url)
      : this.score= 0,
        this.members = [],
        this.membersScore = [];

  Group.fromSnapshot(Map<String, dynamic> group)
    : name = group['name'],
      icon_url = group['icon_url'],
      score = group['score'],
      members = List.from(group['members']),
      membersScore = List.from(group['members_score']);

  Map<String, dynamic> toMap() => {
    'name': name,
    'icon_url': icon_url,
    'score': score,
    'members_score' : members,
    'members': membersScore,
  };

  @override
  String toString() {
    return '$name,$score,$members, icon_url:$icon_url, score: $score}';
  }
}