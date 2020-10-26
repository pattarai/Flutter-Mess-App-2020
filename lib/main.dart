import 'package:Mess_App2_2020/Screens/ForgotPassUI.dart';
import 'package:Mess_App2_2020/Screens/userProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'Screens/about.dart';
import 'Screens/contacts.dart';
import 'Screens/LoginUI.dart';


Future<void> main() async {
 

    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('userId');
    print(userId);
    runApp(MaterialApp(
        home: userId == null ? SignInScreen() : HomeScreen(userId)));
  }


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mess_App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.deepOrange,
        fontFamily: 'Lato',
      ),
      debugShowCheckedModeBanner: false,
      home: SignInScreen(),

      // home: SignInScreen(),
      initialRoute: '/logIn',
      routes: {
        SignInScreen.routeName: (ctx) => SignInScreen(),
        SignUpScreen.routeName: (ctx) => SignUpScreen(),
        About.routeName: (ctx) => About(),
        Contacts.routeName: (ctx) => Contacts(),
      },
    );
  }
}
