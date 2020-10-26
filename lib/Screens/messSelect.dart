import 'package:Mess_App2_2020/Screens/about.dart';
import 'package:Mess_App2_2020/Screens/messHistory.dart';
import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import '../constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MessSelect extends StatefulWidget {
  final String userid;
  const MessSelect({Key key, this.userid}) : super(key: key);
  static int x = 9;
  static List<String> messMon = [];
  static List<String> messTyp = [];
  // final String categoryId;
  // final String categoryTitle;

  // CategoryMealsScreen(this.categoryId, this.categoryTitle);

  @override
  _MessSelectState createState() => _MessSelectState();
}

class _MessSelectState extends State<MessSelect> {
  String mess;

  bool visible = false;

  Future messSelectApi(
      String userid, String password, String mess, BuildContext ctx) async {
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });

    var now = new DateTime.now();
    var formatter = new DateFormat('dd');
    String formattedDate = formatter.format(now);
    print(formattedDate);

    if (int.parse(formattedDate) == 05 || int.parse(formattedDate) == 25) {
      // SERVER API URL

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("THE DEADLINE HAS BEEN REACHED FOR THIS MONTH..!!"),
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
    } else {
      DateTime nextMonth = DateTime.now().add(Duration(days: 30));

      String month = DateFormat.MMM().format(nextMonth);
      print(month);

      var url = 'http://10.0.2.2/flutter-auth/messSelection.php';

      // Store all data with Param Name.
      var data = {
        'userid': userid,
        'password': password,
        'month': month,
        'mess': mess
      };

      // Starting Web API Call.
      var response = await http.post(url, body: json.encode(data));

      // Getting Server response into variable.

      var message = jsonDecode(response.body).toString();
      if (message == 'Login Matched') {
        setState(() {
          visible = false;
        });

        // Navigate to Profile Screen & Sending Email to Next Screen.
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => About(),
            ));
      }
      // If Web call Success than Hide the CircularProgressIndicator.
      if (response.statusCode == 200) {
        setState(() {
          visible = false;
        });
      }
      print(month);
      if (message == 'Mess Registeration Successfully done') {
        MessHistory(mess, month);
        MessSelect.messMon.add(month);
        MessSelect.messTyp.add(mess);

        print('Sucess');
      }

      // Showing Alert Dialog with Response JSON Message.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(message),
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
  }

  TextEditingController passwordController = TextEditingController();

  Widget verifyPassword(String mess) {
    final messThumbnail = new Container(
      margin: new EdgeInsets.symmetric(vertical: 7.0),
      alignment: FractionalOffset.centerLeft,
      child: new Image(
        image: mess == 'VEG'
            ? new AssetImage('images/veg3.png')
            : mess == 'NON-VEG'
                ? new AssetImage('images/nonveg3.png')
                : new AssetImage('images/metro.png'),
        height: 90.0,
        width: 1800.0,
      ),
    );

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          messThumbnail,
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.lock_outline), onPressed: null),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 20, left: 10),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Enter Password to Confirm'),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: 60,
                child: RaisedButton(
                  onPressed: () {
                    messSelectApi(
                        widget.userid, passwordController.text, mess, context);
                  },
                  color: Colors.red,
                  child: Text(
                    'CONFIRM ' + mess + ' MESS',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void verifyMess(BuildContext ctx, String mess) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: ctx,
        builder: (_) {
          return verifyPassword(mess);
        });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: kDarkTheme,
      child: Builder(builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
              backgroundColor: Colors.blueGrey[900],
              appBar: AppBar(
                title: Text('Mess Selection'),
                backgroundColor: Colors.black12,
                leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop()),
              ),
              body: SingleChildScrollView(
                  child: Column(
                children: [
                  InkWell(
                    onTap: () => verifyMess(context, 'VEG'),
                    child: MealItem(
                        mess: 'VEG',
                        title: 'VEGETARIAN MESS',
                        imageUrl: 'images/veg3.png',
                        duration: 5),
                  ),
                  InkWell(
                    onTap: () => verifyMess(context, 'NON-VEG'),
                    child: MealItem(
                        mess: 'NON_VEG',
                        title: 'NON -VEGETARIAN MESS',
                        imageUrl: 'images/nonveg3.png',
                        duration: 5),
                  ),
                  InkWell(
                    onTap: () => verifyMess(context, 'METRO'),
                    child: MealItem(
                        mess: 'METRO',
                        title: 'METRO MESS',
                        imageUrl: 'images/metro.png',
                        duration: 5),
                  ),
                ],
              ))),
        );
      }),
    );
  }
}

class MealItem extends StatefulWidget {
  final String mess;
  final String title;
  final String imageUrl;
  final int duration;

  MealItem({
    @required this.mess,
    @required this.title,
    @required this.imageUrl,
    @required this.duration,
  });

  @override
  _MealItemState createState() => _MealItemState();
}

class _MealItemState extends State<MealItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      margin: EdgeInsets.all(25),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Image.asset(
                  widget.imageUrl,
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Positioned(
                bottom: 20,
                right: 10,
                child: Container(
                  width: 350,
                  color: Colors.black54,
                  padding: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 20,
                  ),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.schedule,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text('${widget.duration} Days'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
