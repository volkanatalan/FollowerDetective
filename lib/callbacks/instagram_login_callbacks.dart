import 'package:follower_detective/models/user.dart';
import 'package:follower_detective/widgets/user_chooser.dart';

abstract class InstagramLoginCallbacks {
  void onLoginSuccess(UserChooser userChooser, User token);
  void onLoginError();
  void onCode();
  void onResponse();
}