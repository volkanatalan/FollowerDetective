import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:follower_detective/callbacks/instagram_login_callbacks.dart';
import 'package:follower_detective/callbacks/user_chooser_callbacks.dart';
import 'package:follower_detective/databases/user_database.dart';
import 'package:follower_detective/helpers/instagram_api_helper.dart';
import 'package:follower_detective/helpers/save_network_image_helper.dart';
import 'package:follower_detective/models/user.dart';
import 'package:follower_detective/screens/user_home_page_screen.dart';
import 'package:follower_detective/widgets/login_button.dart';
import 'package:follower_detective/widgets/user_chooser.dart';



class LoginScreen extends StatefulWidget{
  @override
  _LoginScreenState createState() => _LoginScreenState();
}



class _LoginScreenState extends State<LoginScreen>
    implements UserChooserCallbacks, InstagramLoginCallbacks {

  bool _isLoading = false;
  bool _isThereAnyAccount = false;
  UserChooser userChooser;
  WebviewScaffold webviewScaffold;



  @override
  void initState() {
    super.initState();
    userChooser = UserChooser(callbacks: this,);
  }



  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return WillPopScope(
        onWillPop: () async {
          setState(() {
            _isLoading = false;
          });
          return false;
        },
        child: webviewScaffold == null
        ? Container()
        : webviewScaffold,
      );
    }

    else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset("assets/images/detective_logo.png", width: 250, height: 250,),
            Padding(
              padding: EdgeInsets.only(top: 40, bottom: 40,),
              child: userChooser,),
            _isThereAnyAccount
                ? LoginButton(50, onPressed: () => onPressedLoginButton(),)
                : Container(),
          ],
        ),
      );
    }
  }



  onPressedLoginButton(){
    User selectedUser = userChooser.currentUser;
    Navigator.pushNamed(
      context,
      UserHomePageScreen.routeName,
      arguments: selectedUser,
    );
  }



  @override
  void afterSetupDropdownButton(bool isThereAnyAccount) {
    setState(() {
      _isThereAnyAccount = isThereAnyAccount;
    });
  }



  @override
  void onTapAddAccount(UserChooser userChooser) {
    if(!_isLoading){
      _isLoading = true;
      getAccessToken(webviewScaffold, this).then((user){
        user != null
            ? onLoginSuccess(userChooser, user)
            : onLoginError();
      });
      /*getAccessToken(
          InstagramConstants.APP_ID,
          InstagramConstants.APP_SECRET
      ).then((user) {
        user != null
            ? onLoginSuccess(userChooser, user)
            : onLoginError();
      });*/
    }
  }


  @override
  onCode(){
    setState((){
      webviewScaffold = WebviewScaffold(
        url: instagramAuthorizationUrl,
        clearCache: true,
        clearCookies: true,
        withLocalStorage: true,
      );
    });
  }



  @override
  void onResponse() {
    webviewScaffold = null;
    setState(() {
      _isLoading = false;
    });
  }



  @override
  void onLoginSuccess(UserChooser userChooser, User user) {
    _isLoading = false;
    SaveNetworkImageHelper.save(user.profilePicture, user.username).then((imagePath){
      user.profilePicture = imagePath;
      UserDatabase().insertUser(user).then((_){
        userChooser.setupDropdownButton();
      });
    });
  }



  @override
  void onLoginError() {
    _isLoading = false;
    SnackBar snackBar = SnackBar(content: Text("Login error!"));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}