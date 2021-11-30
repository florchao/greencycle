class User{
  String name;
  String last_name;
  String Id;
  String icon_url;
  String email;
  String score;
  String weekly_score;
  String groups;
  static const String collection_id = 'usuarios';

  User(this.name, this.last_name, this.Id, this.icon_url, this.email,)
      : this.groups = " ",
        this.weekly_score = " ",
        this.score = " ";


  User.fromSnapshot(String Id,Map<String, dynamic> user)
      : Id = Id,
        name = user['name'],
        last_name = user['last_name'],
        email = user['email'],
        icon_url = user['icon_url'],
        groups = user['groups'],
        weekly_score = user['weekly_score'],
        score = user['score'];



  Map<String, dynamic> toMap() => {
    'name': name,
    'last_name': last_name,
    'email': email,
    'iconURL': icon_url,
    'groups': groups,
    'weekly_score': weekly_score,
    'score': score,
  };

  @override
  String toString() {
    return 'user{id: $Id, nombres: $name, apellidos: $last_name, email: $email, iconURL:$icon_url}';
  }


}