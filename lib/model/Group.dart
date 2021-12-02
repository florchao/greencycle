class Group{
  String name;
  String icon_url;
  int score;
  //String weekly_score;
  List<String> members;
  Map<String,int> membersScore;

  static const String collection_id = 'Grupos';

  Group(this.name, this.icon_url, this.members)
      : this.score= 0,
        this.membersScore = Map();
        //this.weekly_score = "";

  Group.fromSnapshot(String Id, Map<String, dynamic> group)
      : //Id = Id,
        name = group['name'],
        icon_url = group['icon_url'],
        score = group['score'],
        //weekly_score = group['weekly_score'],
        membersScore = group['members_score'],
        members = group['members'];

  Map<String, dynamic> toMap() => {
    'name': name,
    'icon_url': icon_url,
    'score': score,
    //'weekly_score': weekly_score,
    'members_score' : membersScore,
    'members': members,
  };

  @override
  String toString() {
    return '$name,$score,$members, icon_url:$icon_url, score: $score}';
  }
}