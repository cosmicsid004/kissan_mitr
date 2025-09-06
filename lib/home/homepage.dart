import 'package:flutter/material.dart';
import 'package:kissan_mitr/common.dart';
import 'package:kissan_mitr/home/analyzer.dart';
import 'package:kissan_mitr/home/hometab.dart';
import 'package:kissan_mitr/home/chat_page.dart';
import 'package:kissan_mitr/home/sensorPage/sensorReadings.dart';
import 'package:kissan_mitr/weatherPage/pages/weather_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  static final List<Widget> _widgetOptions = <Widget>[
    homeTab(),
    SenorReadings(),
    analyzer(),
    WeatherPage(),
    ChatPage(),
  ];

  void _onItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double navBarHeight = MediaQuery.of(context).size.height * 0.1;
    // ~10% of screen height (auto scales on small/large devices)

    return Scaffold(
      backgroundColor: const Color(0xFFFAFFCA),
      body: PageView(
        controller: _pageController,
        children: _widgetOptions,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.red,
        elevation: 0,
        child: const Icon(Icons.crisis_alert),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0), // reduced padding for smaller screens
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            height: navBarHeight.clamp(60, 90),
            // Keeps min 60 and max 90 (safe across all devices)
            width: double.infinity,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: colors.dockColor(),
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home_outlined, color: Colors.black), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.sensors_rounded, color: Colors.black), label: 'Sensor Data'),
                BottomNavigationBarItem(icon: Icon(Icons.camera_alt_outlined, color: Colors.black), label: 'Analyzer'),
                BottomNavigationBarItem(icon: Icon(Icons.sunny_snowing, color: Colors.black), label: 'Weather'),
                BottomNavigationBarItem(icon: Icon(Icons.person, color: Colors.black), label: 'Expert'),
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
