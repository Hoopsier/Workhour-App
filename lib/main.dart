import 'package:flutter/material.dart';
import 'package:kurssiprojekti/Navigation/custom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Navigation/profile_page.dart';
import 'Navigation/notifications_page.dart';
import 'Navigation/home_page.dart';

void main() => runApp(const NavigationBarApp());

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const NavigationExample(),
    );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  late SharedPreferences _prefs;
  int currentPageIndex = 0;
  String? name;
  String password = "null";
  int role = 0;
  int id = -1;

  @override
  void initState() {
    super.initState();
    _initializeSharedPreferences();
  }

  Future<void> _initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      name = _prefs.getString('name');
      role = _prefs.getInt('role') ?? 0;
      password = _prefs.getString('password') ?? "null";
      id = _prefs.getInt('id') ?? -1;
    });
  }

  void refreshData() async {
    await _initializeSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(
        name: name,
        role: role,
        password: password,
        id: id,
        refreshData: refreshData,
      ),
      const NotificationsPage(),
      ProfilePage(
        idController: TextEditingController(),
        passwordController: TextEditingController(),
        refreshData: refreshData,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Work Hours'),
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: currentPageIndex,
        onIndexChanged: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
      body: pages[currentPageIndex],
    );
  }
}
