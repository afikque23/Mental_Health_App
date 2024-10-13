import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const Center(child: Text('Home Page', style: TextStyle(fontSize: 30))),
    const Center(child: Text('Artikel Page', style: TextStyle(fontSize: 30))),
    const Center(child: Text('Tracker Page', style: TextStyle(fontSize: 30))),
    const Center(child: Text('Profile Page', style: TextStyle(fontSize: 30))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ), // Membuat circular pada bagian atas
          child: SizedBox(
            height: 70, // Mengatur tinggi BottomNavigationBar
            child: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.article),
                  label: 'Artikel',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.track_changes),
                  label: 'Tracker',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor:
                  const Color(0xFF68B39F), // Warna item yang dipilih
              unselectedItemColor:
                  const Color(0xFF5F5F5F), // Warna item yang tidak dipilih
              onTap: _onItemTapped,
              backgroundColor:
                  const Color(0xFFF9FFFF), // Warna background navbar
              elevation: 50, // Shadow effect
            ),
          ),
        ));
  }
}
