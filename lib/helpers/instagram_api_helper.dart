import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:follower_detective/callbacks/instagram_login_callbacks.dart';
import 'package:follower_detective/models/instagram_post.dart';
import 'package:follower_detective/models/user.dart';
import 'package:follower_detective/values/instagram_constants.dart';
import 'package:http/http.dart' as http;



String instagramAuthorizationUrl =
    "https://api.instagram.com/oauth/authorize?"
    "client_id=${InstagramConstants.APP_ID}&"
    "redirect_uri=http://localhost:8585&"
    "response_type=code";



Future<Stream<String>> server() async {
  final StreamController<String> onCode = new StreamController();
  HttpServer server =
  await HttpServer.bind(InternetAddress.loopbackIPv4, 8585);
  server.listen((HttpRequest request) async {
    final String code = request.uri.queryParameters["code"];
    request.response
      ..statusCode = 200
      ..headers.set("Content-Type", ContentType.html.mimeType);
    await request.response.close();
    await server.close(force: true);
    onCode.add(code);
    await onCode.close();
  });
  return onCode.stream;
}



Future<User> getAccessToken(
    WebviewScaffold webviewScaffold, InstagramLoginCallbacks callbacks
    ) async {
  Stream<String> onCode = await server();
  callbacks.onCode();
  final String code = await onCode.first;
  final http.Response response = await http.post(
      "https://api.instagram.com/oauth/access_token",
      body: {
        "client_id": InstagramConstants.APP_ID,
        "redirect_uri": "http://localhost:8585",
        "client_secret": InstagramConstants.APP_SECRET,
        "code": code,
        "grant_type": "authorization_code"});
  callbacks.onResponse();

  return User.fromJsonMapForAuthentication(jsonDecode(response.body));
}



/*Future<User> getAccessToken(String appId, String appSecret) async {
  String url =
      "https://api.instagram.com/oauth/authorize?"
      "client_id=$appId&"
      "redirect_uri=http://localhost:8585&"
      "response_type=code";
  Stream<String> onCode = await server();
  final flutterWebviewPlugin = FlutterWebviewPlugin();

  // Close FlutterWebviewPlugin when back button is pressed.
  flutterWebviewPlugin.onBack.listen((_){
    flutterWebviewPlugin.close();
  });

  // Clean cookies before FlutterWebviewPlugin get destroyed.
  flutterWebviewPlugin.onDestroy.listen((_){
    flutterWebviewPlugin.cleanCookies();
  });

  flutterWebviewPlugin.launch(url, clearCookies: true, clearCache: true);
  final String code = await onCode.first;
  final http.Response response = await http.post(
      "https://api.instagram.com/oauth/access_token",
      body: {
        "client_id": appId,
        "redirect_uri": "http://localhost:8585",
        "client_secret": appSecret,
        "code": code,
        "grant_type": "authorization_code"});
  flutterWebviewPlugin.close();
  return User.fromJsonMapForAuthentication(jsonDecode(response.body));
}*/



Future<User> getUserDetails(String accessToken) async {
  final String url ="https://api.instagram.com/v1/users/self/?access_token=$accessToken";
  final response =  await http.get(url);
  return User.fromJsonMapForUserDetails(jsonDecode(response.body));
}



Future<List<InstagramPost>> getMostRecentMedia(String accessToken) async {
  final String url = "https://api.instagram.com/v1/users/self/media/recent/?access_token=$accessToken";
  final response =  await http.get(url);
  var jsonMap = jsonDecode(response.body);
  var listDynamic = jsonMap["data"] as List;
  List<InstagramPost> instagramPosts = listDynamic.map((i) => InstagramPost.fromJsonMap(i)).toList();
  return instagramPosts;
}