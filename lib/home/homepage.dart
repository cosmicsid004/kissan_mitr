import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Use const constructors where possible for better performance
  static final List<Widget> _widgetOptions = <Widget>[
    // Use Container directly, Scaffold inside Scaffold is not recommended
    homeTab(),
    Center(child: Text('Sensor Data')),
    Center(child: Text('Analyzer')),
    Center(child: Text('Weather')),
    Center(child: Text('Expert')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFFCA),
      body: _widgetOptions[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.red,
        elevation: 0,
        child: const Icon(Icons.crisis_alert),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            height: 80,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              // Prevent shifting animation
              backgroundColor: const Color(0xFFB9D4AA),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined, color: Colors.black),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.sensors_rounded, color: Colors.black),
                  label: 'Sensor Data',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.camera_alt_outlined, color: Colors.black),
                  label: 'Analyzer',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.sunny_snowing, color: Colors.black),
                  label: 'Weather',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person, color: Colors.black),
                  label: 'Expert',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.black54,
              onTap: _onItemTapped,
              showUnselectedLabels: true,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class homeTab extends StatefulWidget {
  const homeTab({super.key});

  @override
  State<homeTab> createState() => _homeTabState();
}

class _homeTabState extends State<homeTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFFCA),
      body: Center(child: Text("home tab")),
    );
  }
}
