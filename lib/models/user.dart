class User {
  String uid;
  String name;
  String username;
  String profilePhoto;

  User({
    this.uid,
    this.name,
    this.username,
    this.profilePhoto,
  });

  Map toMap(User user) {
    var data = Map<String, dynamic>();
    data['uid'] = user.uid;
    data['name'] = user.name;
    data['username'] = user.username;
    data["profile_photo"] = user.profilePhoto;
    return data;
  }

  // Named constructor
  User.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['uid'];
    this.name = mapData['name'];
    this.username = mapData['username'];
    this.profilePhoto = mapData['profile_photo'];
  }
}
