import 'package:flutter/material.dart';
import 'package:follower_detective/helpers/instagram_api_helper.dart';
import 'package:follower_detective/models/instagram_post.dart';
import 'package:follower_detective/models/user.dart';
import 'package:follower_detective/values/app_colors.dart';
import 'package:follower_detective/widgets/header.dart';
import 'package:follower_detective/widgets/info_box.dart';

class UserHomePageScreen extends StatelessWidget {
  static const routeName = '/userHomePageScreen';


  @override
  Widget build(BuildContext context) {

    final User user = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: AppColors.colorPrimaryDark,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            children: <Widget>[
              Header(user),
              Expanded(
                child: FutureBuilder<Widget>(
                  future: fetchUserInfo(user.accessToken),
                  builder: (context, snapshot){
                    Widget widget = snapshot.data;
                    return widget != null ? widget
                        : Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  Future<Widget> fetchUserInfo(String accessToken) async {
    List<InstagramPost> mostRecentMedia = await getMostRecentMedia(accessToken);
    int totalLikes = 0;
    int totalComments = 0;

    for(int i = 0; i < mostRecentMedia.length; i++){
      totalLikes += mostRecentMedia[i].likes;
      totalComments += mostRecentMedia[i].comments;
    }

    debugPrint("asdad");
    return GridView.count(
      padding: EdgeInsets.only(top: 15, left: 15, bottom: 100, right: 15),
      crossAxisCount: 2,
      childAspectRatio: 2.5,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      children: <Widget>[
        InfoBox(
          value: "15",
          label: "Non Followers",
        ),
        InfoBox(
          value: "20305644638",
          label: "Fans",
        ),
        InfoBox(
          value: "1225",
          label: "Mutual Followers",
        ),
        InfoBox(
          value: "5",
          label: "Blockers",
        ),
        InfoBox(
          value: "2241",
          label: "Lost Followers",
        ),
        InfoBox(
          value: "8234",
          label: "New Followers",
        ),
        InfoBox(
          value: "$totalLikes",
          label: "Total Likes",
        ),
        InfoBox(
          value: "$totalComments",
          label: "Total Comments",
        ),
        InfoBox(
          onlyLabel: true,
          label: "Top Likers",
        ),
        InfoBox(
          onlyLabel: true,
          label: "Top Commenters",
        ),
        InfoBox(
          onlyLabel: true,
          label: "Top Taggers",
        ),
        InfoBox(
          onlyLabel: true,
          label: "Most Popular Posts",
        ),
        InfoBox(
          onlyLabel: true,
          label: "Least Popular Posts",
        ),
        InfoBox(
          onlyLabel: true,
          label: "Auto Like List",
        ),
      ],
    );
  }
}