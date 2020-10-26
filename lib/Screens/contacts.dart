import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

class Contacts extends StatelessWidget {
  static const routeName = '/contacts';

  @override
  Widget build(BuildContext context) {
    
    return ThemeProvider(
      initTheme: kDarkTheme,
      child: Builder(
        builder: (context) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeProvider.of(context),
              home: Scaffold(
                  appBar: AppBar(
                    title: Text('Hostel Contacts'),
                    backgroundColor: Colors.black45, leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop()),
                  ),
                  body: SafeArea(
                      child: Container(
                    height: 600,
                    child: ListView(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 30,
                            ),
                            CircleAvatar(
                              radius: 50.0,
                              backgroundImage: AssetImage('images/licet.jfif'),
                            ),
                            Text(
                              'SAMUEL ARUL',
                              style: TextStyle(
                                  fontFamily: 'Pacifico',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.0,
                                  color: Colors.white),
                            ),
                            Text(
                              'HOSTEL DIRECTOR',
                              style: TextStyle(
                                  fontFamily: 'SourceSansPro',
                                  fontSize: 18.0,
                                  letterSpacing: 2.5,
                                  color: Colors.blue.shade50),
                            ),
                            Card(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 48.0, vertical: 8.0),
                              child: ListTile(
                                leading: Icon(
                                  Icons.phone,
                                  color: Colors.teal,
                                ),
                                title: Text(
                                  '7358303663',
                                  style: TextStyle(color: Colors.teal.shade400),
                                ),
                              ),
                            ),
                            Card(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 48.0, vertical: 8.0),
                              child: ListTile(
                                leading: Icon(
                                  Icons.email,
                                  color: Colors.teal.shade400,
                                ),
                                title: Text(
                                  'hosteldirector@gmail.com',
                                  style: TextStyle(color: Colors.teal.shade400),
                                ),
                              ),
                            ),
                            CircleAvatar(
                              radius: 50.0,
                              backgroundImage: AssetImage('images/licet.jfif'),
                            ),
                            Text(
                              'MATHEW BILLA',
                              style: TextStyle(
                                  fontFamily: 'Pacifico',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.0,
                                  color: Colors.white),
                            ),
                            Text(
                              'HOSTEL WARDEN',
                              style: TextStyle(
                                  fontFamily: 'SourceSansPro',
                                  fontSize: 18.0,
                                  letterSpacing: 2.5,
                                  color: Colors.blue.shade50),
                            ),
                            Card(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 48.0, vertical: 8.0),
                              child: ListTile(
                                leading: Icon(
                                  Icons.phone,
                                  color: Colors.teal.shade400,
                                ),
                                title: Text(
                                  '908765764',
                                  style: TextStyle(color: Colors.teal.shade400),
                                ),
                              ),
                            ),
                            Card(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 48.0, vertical: 8.0),
                              child: ListTile(
                                leading: Icon(
                                  Icons.email,
                                  color: Colors.teal.shade400,
                                ),
                                title: Text(
                                  'hostelWarden@gmail.com',
                                  style: TextStyle(color: Colors.teal.shade400),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ))));
        },
      ),
    );
  }
}
