import 'package:flutter/material.dart';
import 'package:kurssiprojekti/Navigation/custom_navigation_bar.dart';
//import 'package:shared_preferences/shared_preferences.dart'; //Change all shared preferences into temporary variables for MVP
import 'Navigation/profile_page.dart';
import 'Navigation/notifications_page.dart';
import 'Navigation/home_page.dart';
import 'API/API_Commands.dart';
import 'dart:io';


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const NavigationBarApp());
  
}
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
    _refreshSharedPreferences();
  }

  Future<void> clearLocalStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    print("Local storage cleared!");
  }

  Future<void> _initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    //4 or 5 random 512 bit hashes to ensure no one will be able to accidentally have the same. Overkill? yes.
    final String logoutPass =
        "362aa5a60b1541bc96be043250fbc0a86a7e845f633eed641ea29e274a44df824e19c5a0ce79f9b56678fc8fae3a599fe2526ea74bd6416c4ac23d373d671e9ef3203643fdaba92d1b45aa0f3a6b61c4386b41049c9976f41fa43719238dbda833e64975129f4257d7c8015cab78f9d2bb5190d7f487e89f742fdbc4a1e935e7822ab79a2624919ed3f638732ac90a23486372e0362d42e5609983e5f2f482368a5a7d7f4c4a0f21133bf0654efa4efa13b227fb08478f56c06bbe09bfc135f8c441734811409537c1aef96ea722f43a25f191cc0f71a4348025aa58ac2b568783fa2f44bbc8a12bfe4eeeff3acb0026f1a7ca58b17234f1d9e66e81d5d66a2ceb9a6e2eea4b4d15f784c4c1ec9f7d602edcbd8a52f0b3a4f8c4e9e6ead8751acfcfef3bcafa9cea80a8aac880ace0842029ca50f67ec75b066c06225586035e";
    setState(() {
      password = _prefs.getString('password') ?? logoutPass;
      id = _prefs.getInt('id') ??
          -1; //-1 to ensure the fact that no id will be found. -1 id is not possible to make with this app.
      Login(id, password);
      name = _prefs.getString('name');
      role = _prefs.getInt('role') ?? 0;
    });
  }

  Future<void> _refreshSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    //4 or 5 random 512 bit hashes to ensure no one will be able to accidentally have the same. Overkill? yes.
    final String logoutPass =
        "362aa5a60b1541bc96be043250fbc0a86a7e845f633eed641ea29e274a44df824e19c5a0ce79f9b56678fc8fae3a599fe2526ea74bd6416c4ac23d373d671e9ef3203643fdaba92d1b45aa0f3a6b61c4386b41049c9976f41fa43719238dbda833e64975129f4257d7c8015cab78f9d2bb5190d7f487e89f742fdbc4a1e935e7822ab79a2624919ed3f638732ac90a23486372e0362d42e5609983e5f2f482368a5a7d7f4c4a0f21133bf0654efa4efa13b227fb08478f56c06bbe09bfc135f8c441734811409537c1aef96ea722f43a25f191cc0f71a4348025aa58ac2b568783fa2f44bbc8a12bfe4eeeff3acb0026f1a7ca58b17234f1d9e66e81d5d66a2ceb9a6e2eea4b4d15f784c4c1ec9f7d602edcbd8a52f0b3a4f8c4e9e6ead8751acfcfef3bcafa9cea80a8aac880ace0842029ca50f67ec75b066c06225586035e";
    setState(() {
      password = _prefs.getString('password') ?? logoutPass;
      id = _prefs.getInt('id') ??
          -1; //-1 to ensure the fact that no id will be found. -1 id is not possible to make with this app.
      name = _prefs.getString('name');
      role = _prefs.getInt('role') ?? 0;
    });
  }

  void initializeData() async {
    await _initializeSharedPreferences();
  }

  void refreshData() async {
    await _refreshSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(
        name: name,
        role: role,
        password: password,
        id: id,
        initializeData: initializeData,
      ),
      const NotificationsPage(),
      ProfilePage(
        idController: TextEditingController(),
        loginPasswordController: TextEditingController(),
        registerPasswordController: TextEditingController(),
        nameController: TextEditingController(),
        refreshData: refreshData,
        initializeData: initializeData,
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
