import 'package:follower_detective/models/user.dart';
import 'instagram_photo.dart';

class InstagramPost {
  String id;
  InstagramPhoto instagramPhoto;
  String createdTime;
  String captionText;
  bool userHasLiked;
  int likes;
  int comments;
  String type;
  String link;
  String filter;
  List<String> usersInPhoto;
  List<InstagramPhoto> carouselMedia;



  InstagramPost({
    this.id,
    this.instagramPhoto,
    this.createdTime,
    this.captionText,
    this.userHasLiked,
    this.likes,
    this.comments,
    this.type,
    this.link,
    this.filter,
    this.usersInPhoto,
    this.carouselMedia,
  });



  InstagramPost.fromJsonMap(Map<String, dynamic> json){
    id = json['id'];
    instagramPhoto = InstagramPhoto.fromMap(json['images']);
    createdTime = json['created_time'];
    var caption = json['caption'];
    captionText = caption != null ? caption['text'] : null;
    userHasLiked = json['user_has_liked'];
    likes = json['likes']['count'];
    comments = json['comments']['count'];
    type = json['type'];
    link = json['link'];
    filter = json['filter'];
    /*var usersInPhotoDynamic = json['users_in_photo'] as List;
    usersInPhoto = usersInPhotoDynamic.length > 0
      ? usersInPhotoDynamic.map((i) => i['user']['username']).toList()
      : List<String>(0);*/
    //var carouselMediaDynamic = json["carousel_media"] as List;
    //carouselMedia = carouselMediaDynamic.map((i) => InstagramPhoto.fromMap(i)).toList();
  }
}