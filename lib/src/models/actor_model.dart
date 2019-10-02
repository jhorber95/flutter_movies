class Cast {
  List<Actor> actorList = new List();

  Cast();

  Cast.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach( (json)  {
      final actor = new Actor.fromJsonMap(json);
      actorList.add(actor);
    });
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJsonMap(Map<String, dynamic> json) {
    castId = json['cast_id'] / 1;
    character = json['character'];
    creditId = json['credit_id'];
    gender = json['gender'];
    id = json['id'] / 1;
    name = json['name'];
    order = json['order'] / 1;
    profilePath = json['profile_path'];
  }

  getProfilePath() {
    if(profilePath == null) return 'https://www.somatechnology.com/App_Themes/SomaNew_Responsive/Images/no-image-available.png';
    return 'https://image.tmdb.org/t/p/w500/$profilePath';
  }
}