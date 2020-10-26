import 'package:Mess_App2_2020/Screens/LoginUI.dart';
import 'package:Mess_App2_2020/Screens/messHistory.dart';
import 'package:Mess_App2_2020/Screens/messReduction.dart';
import 'package:Mess_App2_2020/Screens/messSelect.dart';
import 'package:Mess_App2_2020/Screens/rssFeed.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../constants.dart';
import 'about.dart';
import '../widgets/profile_list_item.dart';
import 'contacts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  final String userId;
  HomeScreen(this.userId);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: kDarkTheme,
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeProvider.of(context),
            home: ProfileScreen(userId),
          );
        },
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final String userId;
  ProfileScreen(this.userId);
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);

    var profileInfo = Expanded(
      child: Column(
        children: <Widget>[
          Container(
            height: kSpacingUnit.w * 10,
            width: kSpacingUnit.w * 10,
            margin: EdgeInsets.only(top: kSpacingUnit.w * 3),
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: kSpacingUnit.w * 5,
                  backgroundImage: AssetImage('images/Asmir.jpeg'),
                ),
              ],
            ),
          ),
          SizedBox(height: kSpacingUnit.w * 2),
          Text(
            'Asmir THE KHAN',
            style: kTitleTextStyle,
          ),
          SizedBox(height: kSpacingUnit.w * 0.5),
          Text(
            'asmirkhan7@gmail.com',
            style: kCaptionTextStyle,
          ),
          SizedBox(height: kSpacingUnit.w * 2),
          Container(
            height: kSpacingUnit.w * 4,
            width: kSpacingUnit.w * 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
              color: Theme.of(context).accentColor,
            ),
            child: Center(
              child: Text(
                'AC NO:' + userId,
                style: kButtonTextStyle,
              ),
            ),
          ),
        ],
      ),
    );

    var themeSwitcher = ThemeSwitcher(
      builder: (context) {
        return AnimatedCrossFade(
          duration: Duration(milliseconds: 200),
          crossFadeState:
              ThemeProvider.of(context).brightness == Brightness.dark
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
          firstChild: GestureDetector(
            onTap: () =>
                ThemeSwitcher.of(context).changeTheme(theme: kLightTheme),
            child: Icon(
              LineAwesomeIcons.sun,
              size: ScreenUtil().setSp(kSpacingUnit.w * 3),
            ),
          ),
          secondChild: GestureDetector(
            onTap: () =>
                ThemeSwitcher.of(context).changeTheme(theme: kDarkTheme),
            child: Icon(
              LineAwesomeIcons.moon,
              size: ScreenUtil().setSp(kSpacingUnit.w * 3),
            ),
          ),
        );
      },
    );

    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: kSpacingUnit.w * 3),
        GestureDetector(
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RSSReader()),
            )
          },
          child: Icon(
            LineAwesomeIcons.bell_1,
            size: ScreenUtil().setSp(kSpacingUnit.w * 3),
          ),
        ),
        profileInfo,
        themeSwitcher,
        SizedBox(width: kSpacingUnit.w * 3),
      ],
    );

    return MaterialApp(
      home: ThemeSwitchingArea(
        child: Builder(
          builder: (context) {
            return Scaffold(
              body: Column(
                children: <Widget>[
                  SizedBox(height: kSpacingUnit.w * 5),
                  header,
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        InkWell(
                          child: ProfileListItem(
                            icon: LineAwesomeIcons.check_circle_1,
                            text: 'Mess Selection',
                            hasNavigation: true,
                          ),
                          onTap: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MessSelect(
                                  userid: userId,
                                ),
                              ),
                            )
                          },
                        ),
                        InkWell(
                          child: ProfileListItem(
                            icon: LineAwesomeIcons.download,
                            text: 'Mess Reduction',
                          ),
                          onTap: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MessReduction(userid: userId),
                              ),
                            )
                          },
                        ),
                        InkWell(
                          child: ProfileListItem(
                            icon: LineAwesomeIcons.history,
                            text: 'Mess History',
                          ),
                          onTap: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MessHistory(null, null),
                              ),
                            )
                          },
                        ),
                        InkWell(
                          child: ProfileListItem(
                            icon: LineAwesomeIcons.bell,
                            text: 'Notification Feeds',
                          ),
                          onTap: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RSSReader()),
                            )
                          },
                        ),
                        InkWell(
                          child: ProfileListItem(
                            icon: LineAwesomeIcons.phone,
                            text: 'Contacts',
                          ),
                          onTap: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Contacts()),
                            )
                          },
                        ),
                        InkWell(
                          child: ProfileListItem(
                            icon: LineAwesomeIcons.info,
                            text: 'About Us',
                          ),
                          onTap: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => About()),
                            )
                          },
                        ),
                        InkWell(
                          child: ProfileListItem(
                            icon: LineAwesomeIcons.alternate_sign_out,
                            text: 'Logout',
                            hasNavigation: false,
                          ),
                          onTap: () async {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInScreen()),
                            );
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.remove('userId');
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
