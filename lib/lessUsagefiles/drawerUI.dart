import 'package:Mess_App2_2020/Screens/LoginUI.dart';
import '../lessUsagefiles/profile.dart';
import 'package:flutter/material.dart';
import '../Screens/about.dart';
import '../Screens/contacts.dart';

class SideMenu extends StatelessWidget {
  int cnt = 0;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        height: 450,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                '',
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
              decoration: BoxDecoration(
                  color: Colors.green,
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage('images/licet.jfif'))),
            ),
            ListTile(
              leading: Icon(Icons.account_box),
              title: Text('Profile'),
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProfileScreen(null),
                    ))
              },
            ),
            ListTile(
              leading: Icon(Icons.comment),
              title: Text('About'),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => About()),
                )
              },
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Contacts'),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Contacts()),
                )
              },
            ),
            ListTile(
              leading: Icon(Icons.access_time),
              title: Text('history'),
              onTap: () => {Navigator.of(context).pop()},
            ),
            ListTile(
              leading: Icon(Icons.input),
              title: Text('Logout'),
              onTap: () => { Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                )},
            )
          ],
        ),
      ),
    );
  }
}
