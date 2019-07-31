import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:follower_detective/callbacks/user_chooser_callbacks.dart';
import 'package:follower_detective/databases/user_database.dart';
import 'package:follower_detective/models/user.dart';
import 'package:follower_detective/values/app_colors.dart';
import 'package:follower_detective/values/english.dart';



// ignore: must_be_immutable
class UserChooser extends StatefulWidget{
  User currentUser;
  UserChooserCallbacks callbacks;
  _UserChooserState _userChooserState;

  UserChooser({this.callbacks});

  setupDropdownButton() => _userChooserState.setupDropdownButton();

  @override
  State<StatefulWidget> createState() {
    _userChooserState = _UserChooserState();
    return _userChooserState;
  }
}




class _UserChooserState extends State<UserChooser>{

  List<DropdownMenuItem<User>> _dropDownMenuItems;
  List<User> _users;



  @override
  // ignore: must_call_super
  void initState(){
    setupDropdownButton();
  }



  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.colorPrimary,
      elevation: 4,
      child: Container(
        width: 400,
        padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: Column(
          children: <Widget>[
            _dropDownMenuItems != null && _dropDownMenuItems.length > 0
                ? DropdownButtonHideUnderline(
              child: DropdownButton(
                value: widget.currentUser,
                items: _dropDownMenuItems,
                onChanged: _changedDropDownItem,
              ),
            )
                : Text(English.there_is_not_any_account),
            Padding(padding: EdgeInsets.only(bottom: 20),),
            Divider(color: Colors.black38,),
            Padding(padding: EdgeInsets.only(bottom: 10),),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:
              _dropDownMenuItems != null && _dropDownMenuItems.length > 0
                  ? <Widget>[
                GestureDetector(
                  onTap: () => _onTapDeleteButton(),
                  child: Text("Delete Account",
                    style: TextStyle(color: Colors.red, fontSize: 20,),),
                ),
                GestureDetector(
                  onTap: () => widget.callbacks.onTapAddAccount(widget),
                  child: Text("Add Account",
                    style: TextStyle(color: Colors.white70, fontSize: 20,),),
                ),
              ]
              : <Widget>[
                GestureDetector(
                  onTap: () => widget.callbacks.onTapAddAccount(widget),
                  child: Text("Add Account",
                    style: TextStyle(color: Colors.lightGreenAccent, fontSize: 20,),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }



  setupDropdownButton(){
    UserDatabase().getUsers().then((users){
      setState(() {
        _users = users;
        _dropDownMenuItems = getDropDownMenuItems();
        bool _isThereAnyAccount = _dropDownMenuItems.length > 0;

        if(_isThereAnyAccount) {
          widget.currentUser = _dropDownMenuItems[0].value;
        }

        widget.callbacks.afterSetupDropdownButton(_isThereAnyAccount);
      });
    });
  }



  List<DropdownMenuItem<User>> getDropDownMenuItems() {
    List<DropdownMenuItem<User>> items = new List();
    for (User user in _users) {
      items.add(DropdownMenuItem(
        value: user,
        child: Container(
          margin: EdgeInsets.all(2),
          width: 346,
          child: Row(
            children: <Widget>[
              ClipOval(
                child: Container(
                  decoration: BoxDecoration(color: Colors.black,),
                  padding: EdgeInsets.all(2),
                  child: ClipOval(
                    child: Image.asset(
                      "assets/images/volkanatalanprofileimage2.jpg", width: 40, height: 40,
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0),),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(user.fullName, style: TextStyle(color: Colors.white),),
                  Text(user.username, style: TextStyle(color: Colors.white),),
                ],
              )
            ],
          ),
        ),
      ));
    }
    return items;
  }



  void _changedDropDownItem(User selectedUser) {
    setState(() {
      widget.currentUser = selectedUser;
    });
  }



  void _onTapDeleteButton(){
    showDialog(
      context: context,
      builder: (context){
        return CupertinoAlertDialog(
          title: Text(English.delete_account),
          content: Text("${English.are_you_sure_that_you_want_to_delete_this_account}\n"
              "${widget.currentUser.fullName}"
              "${widget.currentUser.username}"
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(English.delete),
              onPressed: (){
                Navigator.pop(context); // Dismiss dialog
                _deleteUser();
              },
            ),
            FlatButton(
              child: Text(English.cancel),
              onPressed: (){
                Navigator.pop(context); // Dismiss dialog
              },
            ),
          ],
        );
      }
    );
  }



  void _deleteUser(){
    UserDatabase().deleteUser(widget.currentUser.id).then((_){
      widget.currentUser = null;
      setupDropdownButton();
    });
  }
}