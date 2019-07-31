import 'package:flutter/material.dart';
import 'package:follower_detective/helpers/instagram_api_helper.dart';
import 'package:follower_detective/models/user.dart';
import 'package:follower_detective/values/app_gradients.dart';
import 'package:follower_detective/values/app_colors.dart';
import 'package:follower_detective/values/english.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

import 'circle_image.dart';


class Header extends StatelessWidget {

  final User user;
  Header(this.user);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        color: AppColors.colorPrimary,
        child: Padding(
            padding: EdgeInsets.only(top: 30, bottom: 30),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Container(
                              width: 3,
                              height: 30,
                              decoration: BoxDecoration(color: AppColors.colorPrimaryDark,),
                            ),
                          ),
                        ),
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              FutureBuilder<User>(
                                initialData: User(followedBy: 0),
                                future: getUserDetails(user.accessToken),
                                builder: (context, userDetailSnapshot){
                                  return userDetailSnapshot.hasData
                                      ? GradientText(
                                    userDetailSnapshot.data.followedBy.toString(),
                                    gradient: AppGradients.pinkBlueLinear,
                                    shaderRect: Rect.fromLTWH(0, 0, 50, 50),
                                    style: TextStyle(
                                      fontSize: 27,
                                      fontFamily: "Lobster"
                                    ),
                                  )
                                      : CircularProgressIndicator();
                                },
                              ),
                              Text(English.follower),
                            ],
                          ),
                        ),
                      ],
                    )
                ),
                Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          CircleImage(
                            user.profilePicture,
                            diameter: 100,
                            borderWidth: 5,),
                          Container(height: 10,),
                          Text(
                            user.fullName,
                            style: TextStyle(fontSize: 18,),
                          ),
                          Container(height: 5,),
                          Text(
                            user.username,
                            style: TextStyle(fontSize: 16,),
                          ),
                        ],
                      ),
                    )
                ),
                Expanded(
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 3,
                              height: 30,
                              decoration: BoxDecoration(color: AppColors.colorPrimaryDark),
                            ),
                          ),
                        ),
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              FutureBuilder<User>(
                                initialData: User(follows: 0),
                                future: getUserDetails(user.accessToken),
                                builder: (context, userDetailSnapshot){
                                  return userDetailSnapshot.hasData
                                      ? GradientText(
                                    userDetailSnapshot.data.follows.toString(),
                                    gradient: AppGradients.pinkBlueLinear,
                                    shaderRect: Rect.fromLTWH(0, 0, 50, 50),
                                    style: TextStyle(
                                        fontSize: 27,
                                        fontFamily: "Lobster"
                                    ),
                                  )
                                      : CircularProgressIndicator();
                                },
                              ),
                              Text(English.following),
                            ],
                          ),
                        )
                      ],
                    )
                ),
              ],
            )
        )
    );
  }
}