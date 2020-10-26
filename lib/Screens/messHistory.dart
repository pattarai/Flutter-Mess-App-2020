import 'package:Mess_App2_2020/Screens/about.dart';
import 'package:Mess_App2_2020/Screens/messSelect.dart';
import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import '../constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'messSelect.dart';

class MessHistory extends StatefulWidget {
  final String mess;
  final String month;

  MessHistory(this.mess, this.month);
  @override
  _MessHistoryState createState() => _MessHistoryState();
}

class _MessHistoryState extends State<MessHistory> {
  List<String> messArrMess = [];
  List<String> messArrMonth = [];
  int array() {
    messArrMess.add(widget.mess);
    messArrMonth.add(widget.month);
    print('SEE here');
    print(messArrMonth);
    return messArrMonth.length;
  }

  Widget noArray() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        Center(
          child: Text('No Mess Selected Yet!',
              style: TextStyle(fontSize: 24, color: Colors.grey)),
        ),
        SizedBox(
          height: 60,
        ),
        Container(
          height: 200,
          child: Image.asset(
            'images/waiting.png',
            fit: BoxFit.fill,
          ),
        )
      ],
    );
  }

  Widget displayArray() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 60,
        ),
        Center(
            child: Text(
          MessSelect.messMon[0],
        )),
        Center(
          child: Text(MessSelect.messTyp[0].toString()),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: kDarkTheme,
      child: Builder(
        builder: (context) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                backgroundColor: Colors.black12,
                appBar: AppBar(
                  title: Text('Your Mess History'),
                  backgroundColor: Colors.black12,
                  leading: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.of(context).pop()),
                ),
                body: Container(
                  height: 600,
                  child: ListView(
                    children: [
                      MessSelect.messTyp.length == 0
                          ? noArray()
                          : Column(
                              children: <Widget>[
                                for (var i = 0;
                                    i < MessSelect.messTyp.length;
                                    i++)
                                  Column(
                                    children: <Widget>[SizedBox(height: 30,),
                                      Card(
                  margin: EdgeInsets.symmetric(vertical: 18, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 50,backgroundColor: Colors.teal,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(MessSelect.messMon[i],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white),),
                        ),
                      ),
                    ),
                    title: Text(
                      MessSelect.messTyp[i],
                      style: Theme.of(context).textTheme.headline6,
                    ),),)
                                    ],
                                  )
                              ],
                            ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
