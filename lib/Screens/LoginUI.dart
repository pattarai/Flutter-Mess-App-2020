import 'package:Mess_App2_2020/Screens/about.dart';
import 'package:Mess_App2_2020/Screens/userProfile.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'ForgotPassUI.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthMode { Signup, Login }

class SignInScreen extends StatefulWidget {
  static const routeName = '/logIn';
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  final userIdController = TextEditingController();
  final passwordController = TextEditingController();
  String link;
  bool visible = false;
  Future<String> sharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var userId = prefs.getString('userId');
    print(userId);
    return userId;
  }

  Future loginApi(String userId, String password) async {
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });

    // SERVER API URL

    var url = 'http://10.0.2.2/flutter-auth/login_user.php';

    // Store all data with Param Name.
    var data = {'userid': userId, 'password': password};

    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));

    // Getting Server response into variable.

    var message = jsonDecode(response.body);
    if (message == 'Login Matched') {
      setState(() {
        visible = false;
      });
      if (message == 'Login Matched') {
        // Navigate to Profile Screen & Sending Email to Next Screen.
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('userId', userIdController.text);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(userIdController.text)),
        );
      }
    }
    // If Web call Success than Hide the CircularProgressIndicator.
    if (response.statusCode == 200) {
      setState(() {
        visible = false;
      });
    }

    // Showing Alert Dialog with Response JSON Message.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(message == 'Login Matched'
              ? 'Your Logged In Successfully!'
              : message),
          actions: <Widget>[
            FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Container(
              height: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: AssetImage('images/app.png'))),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.person), onPressed: null),
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.only(right: 20, left: 10),
                          child: TextFormField(
                            controller: userIdController,
                            autocorrect: true,
                            decoration:
                                InputDecoration(hintText: 'Enter Your Acc No.'),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty || value.length < 5) {
                                return 'Acc No is too short!';
                              }
                            },
                          )))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.lock), onPressed: null),
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.only(right: 20, left: 10),
                          child: (_authMode == AuthMode.Login)
                              ? TextFormField(
                                  controller: passwordController,
                                  autocorrect: true,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      hintText: 'Enter Your Password'),
                                  validator: (value) {
                                    if (value.isEmpty || value.length < 5) {
                                      return 'Password is too short!';
                                    }
                                  },
                                )
                              : null)),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  height: 60,
                  child: RaisedButton(
                    onPressed: () {
                      loginApi(userIdController.text, passwordController.text);
                    },
                    color: Color(0xFF00a79B),
                    child: Text(
                      'LOG IN',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
              child: Center(
                child: RichText(
                    text: TextSpan(
                  text: 'Forgot Password?',
                  style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
