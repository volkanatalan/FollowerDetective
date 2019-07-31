import 'dart:io';
import 'package:follower_detective/values/paths.dart';
import 'package:http/http.dart' show get;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';

class SaveNetworkImageHelper {
  static Future<String> save(String url, String imageName) async {
    var response = await get(url);
    var documentDirectory = await getApplicationDocumentsDirectory();
    String profilePicturesDirectory = "${documentDirectory.path}/${Paths.profilePictures}";

    debugPrint("profilePicturesDirectory: $profilePicturesDirectory");

    File file = File(
        join(profilePicturesDirectory, "$imageName.jpg")
    );
    file.createSync(recursive: true);
    file.writeAsBytesSync(response.bodyBytes);

    return file.path;
  }
}