class Group{
  String name;
  String icon_url;
  int score;
  String weekly_score;
  List<String> members;
  String date;
  Map<String,int> membersScore;

  static const String collection_id = 'Grupos';

  Group(this.name, this.icon_url, this.members)
      : this.score= 0,
        this.date = "poner fecha",  //TODO: poder fecha
        this.membersScore = Map(),
        this.weekly_score = "";

  Group.fromSnapshot(String Id, Map<String, dynamic> group)
      : //Id = Id,
        name = group['name'],
        icon_url = group['icon_url'],
        score = group['score'],
        weekly_score = group['weekly_score'],
        membersScore = group['members_score'],
        date = group['date'],
        members = group['members'];

  Map<String, dynamic> toMap() => {
    'name': name,
    'icon_url': icon_url,
    'score': score,
    'weekly_score': weekly_score,
    'members_score' : membersScore,
    'date' : date,
    'members': members,
  };

  @override
  String toString() {
    return '$name,$score,$members, icon_url:$icon_url, score: $score}';
  }
}