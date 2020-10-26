import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import '../constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:quiver/time.dart';

class MessReduction extends StatefulWidget {
  final String userid;
  const MessReduction({Key key, this.userid}) : super(key: key);

  @override
  _MessReductionState createState() => _MessReductionState();
}

class _MessReductionState extends State<MessReduction> {
  DateTime _selectedStartDate;
  DateTime _selectedEndDate;

  bool start = true;
  TextEditingController userController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _presentDatePicker(bool start) {
    showDatePicker(
      context: context,
      initialDate:
          _selectedStartDate == null ? DateTime.now() : _selectedStartDate,
      firstDate:
          _selectedStartDate == null ? DateTime.now() : _selectedStartDate,
      lastDate: DateTime(2040),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        start == true
            ? _selectedStartDate = pickedDate
            : _selectedEndDate = pickedDate;
      });
    });
  }

  Future messReductionApi(BuildContext ctx) async {
    print('Works');

    String nextMonth = DateFormat.MMM().format(_selectedEndDate);

    String month = DateFormat.MMM().format(_selectedStartDate);
    var totalDays =
        daysInMonth(_selectedStartDate.year, _selectedStartDate.month);

    var url = 'http://10.0.2.2/flutter-auth/messReduction.php';

    print(widget.userid);

    var data = {
      'userid': widget.userid,
      'month': month,
      'nextmonth': nextMonth,
      'startDate': _selectedStartDate.day,
      'endDate': _selectedEndDate.day,
      'totalDays':
          (_selectedStartDate.month == _selectedEndDate.month) ? 0 : totalDays,
    };

    var response = await http.post(url, body: json.encode(data));
    print(jsonDecode(response.body).toString());
    print('hii');
    var message = jsonDecode(response.body).toString();
    print('hello');
    if (message == 'Login Matched') {
      setState(() {
        bool visible = false;
      });

      // Navigate to Profile Screen & Sending Email to Next Screen.

      print(message);
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
// inside Widget build

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
                  title: Text('Mess Reduction'),
                  backgroundColor: Colors.black12,
                  leading: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.of(context).pop()),
                ),
                body: SingleChildScrollView(
                  child: Card(
                    color: Colors.black12,
                    margin: EdgeInsets.all(30),
                    child: Center(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Center(
                              child: Container(
                                height: 70,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: FlatButton(
                                        textColor: Colors.teal,
                                        child: Text(
                                          'Choose Start Date',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        onPressed: () =>
                                            _presentDatePicker(true),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        _selectedStartDate == null
                                            ? '  No Date Chosen!'
                                            : '  From: ${DateFormat.yMMMd().format(_selectedStartDate)}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: _selectedStartDate == null
                                                ? Colors.grey
                                                : Colors.blue),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: Container(
                                height: 70,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: FlatButton(
                                        textColor: Colors.teal,
                                        child: Text(
                                          'Choose End  Date',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        onPressed: () =>
                                            _presentDatePicker(false),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        _selectedEndDate == null
                                            ? '  No Date Chosen!'
                                            : '  To: ${DateFormat.yMMMd().format(_selectedEndDate)}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: _selectedEndDate == null
                                                ? Colors.grey
                                                : Colors.blue),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                children: <Widget>[
                                  IconButton(
                                      icon: Icon(Icons.add_comment),
                                      onPressed: null),
                                  Expanded(
                                      child: Container(
                                          margin: EdgeInsets.only(
                                              right: 20, left: 10),
                                          child: TextFormField(
                                            controller: userController,
                                            autofocus: false,
                                            autocorrect: true,
                                            style:
                                                TextStyle(color: Colors.black),
                                            decoration: InputDecoration(
                                                hintText:
                                                    'Enter Your Reason for Mess Reducion',
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[700]),
                                                filled: true,
                                                fillColor: Colors.white),
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: 3,
                                            maxLength: 120,
                                            validator: (value) {
                                              if (value.isEmpty ||
                                                  value.length < 20) {
                                                return 'Enter More Characters';
                                              }
                                            },
                                          )))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  color: Colors.teal,
                                  height: 60,
                                  child: RaisedButton(
                                    textColor: Colors.black,
                                    onPressed: () {
                                      messReductionApi(context);
                                    },
                                    child: Text(
                                      'SUBMIT',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    color: Colors.teal,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
