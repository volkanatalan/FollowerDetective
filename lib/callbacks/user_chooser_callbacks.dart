import 'package:follower_detective/widgets/user_chooser.dart';

abstract class UserChooserCallbacks {
  void onTapAddAccount(UserChooser userChooser);
  void afterSetupDropdownButton(bool isThereAnyAccount);
}