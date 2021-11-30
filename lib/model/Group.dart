class Group{
  String name;
  String Id;
  String icon_url;
  String score;
  String weekly_score;
  List members;

  static const String collection_id = 'Grupos';

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

  Map<String, dynamic> toMap() => {
    'name': name,
    'Id': Id,
    'icon_url': icon_url,
    'score': score,
    'weekly_score': weekly_score,
    'members': members,
  };

  @override
  String toString() {
    return 'user{id: $Id, nombres: $name, score: $score, members: $members, iconURL:$icon_url}';
  }
}