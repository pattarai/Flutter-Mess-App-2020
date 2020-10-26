import'../lessUsagefiles/bottomtab.dart';
import '../lessUsagefiles/drawerUI.dart';
import 'package:flutter/material.dart';
import 'drawerUI.dart';
import '../Screens/about.dart';
import '../Screens/contacts.dart';

class ProfileScreen extends StatefulWidget {
  String id;
  ProfileScreen(this.id);
// Creating String Var to Hold sent Email.

// Receiving Email using Constructor.

  static const routeName = '/profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  logout(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(initialRoute: 'bottomTab',
      
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal[900],
          title: Text('User Profile'),
        ),
        drawer: SideMenu(),
        body: Center(
            child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              CircleAvatar(
                radius: 60.0,
                backgroundImage: AssetImage('images/licet.jfif'),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 48.0, vertical: 8.0),
                child: ListTile(
                  leading: Icon(
                    Icons.perm_identity,
                    color: Colors.teal.shade400,
                  ),
                  title: Text(
                    'Asmir khan',
                    style: TextStyle(color: Colors.teal.shade400),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 48.0, vertical: 8.0),
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.teal.shade400,
                  ),
                  title: Text(
                    'XXXXX47' ,
                    style: TextStyle(color: Colors.teal.shade400),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 48.0, vertical: 8.0),
                child: ListTile(
                  leading: Icon(
                    Icons.school,
                    color: Colors.teal.shade400,
                  ),
                  title: Text(
                    'LICET',
                    style: TextStyle(color: Colors.teal.shade400),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 48.0, vertical: 8.0),
                child: ListTile(
                  leading: Icon(
                    Icons.account_circle,
                    color: Colors.teal.shade400,
                  ),
                  title: Text(
                    'ID: 19CS003',
                    style: TextStyle(color: Colors.teal.shade400),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                onPressed: () {
                  logout(context);
                },
                color: Colors.red,
                textColor: Colors.white,
                child: Text('Click Here To Logout'),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
