class InstagramPhoto {
  String thumbnail;
  String lowResolution;
  String standardResolution;


  InstagramPhoto({this.thumbnail, this.lowResolution, this.standardResolution});


  InstagramPhoto.fromMap(Map json){
    thumbnail = json['thumbnail']['url'];
    lowResolution = json['low_resolution']['url'];
    standardResolution = json['standard_resolution']['url'];
  }
}