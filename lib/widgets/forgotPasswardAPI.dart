import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Apicalling {
  Future forgotPassword(String email,context) async {
    var response1 =
        await http.post('http://10.0.2.2/flutter-auth/checkUser.php', body: {
      "email": email,
    });

    var link = json.decode(response1.body);
    print(link);
    if (link != 'INVALID EMAIL ID! PLEASE CHECK AGAIN') {
      print('success also');
    }
showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(link == 'INVALID EMAIL ID! PLEASE CHECK AGAIN'
              ? link
              
              : 'RECOVERY LINK SENT SUCCESSFULLY!!'+link),
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
  
  



