import 'package:flutter/material.dart';
import '../lessUsagefiles/profile.dart';
import '../Screens/about.dart';
import '../Screens/contacts.dart';


class TabsScreen extends StatefulWidget {
  static const routeName = '/bottomTab';
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, Object>> _pages = [
    {
      'page': ProfileScreen(null),
      'title': null,
    },
    {
      'page': About(),
      'title': 'Our Legacy',
    },
     {
      'page': Contacts(),
      'title': 'Contacts',
    },
  ];
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.teal,
        currentIndex: _selectedPageIndex,
        // type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.lightBlueAccent,
            icon: Icon(Icons.account_box),
            title: Text('Profile'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.lightBlueAccent,
            icon: Icon(Icons.info),
            title: Text('About'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.lightBlueAccent,
            icon: Icon(Icons.open_in_new),
            title: Text('Contacts'),
          ),
        ],
      ),
    );
  }
}
