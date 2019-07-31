class User {
  String id;
  String accessToken;
  String username;
  String fullName;
  String profilePicture;
  int followedBy;
  int follows;
  int posts;



  User({
    this.id,
    this.accessToken,
    this.username,
    this.fullName,
    this.profilePicture,
    this.followedBy,
    this.follows,
  });



  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'accessToken': accessToken,
      'username': username,
      'fullName': fullName,
      'profilePicture': profilePicture,
    };
  }



  User.fromJsonMapForAuthentication(Map json){
    id = json['user']['id'];
    accessToken = json['access_token'];
    username = json['user']['username'];
    fullName = json['user']['full_name'];
    profilePicture = json['user']['profile_picture'];
  }



  User.fromJsonMapForUserDetails(Map json){
    id = json['data']['id'];
    username = json['data']['username'];
    fullName = json['data']['full_name'];
    profilePicture = json['data']['profile_picture'];
    posts = json['data']['counts']['media'];
    follows = json['data']['counts']['follows'];
    followedBy = json['data']['counts']['followed_by'];
  }
}