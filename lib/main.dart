//import 'dart:math'; not used so

import 'dart:collection';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:kurssiprojekti/API_Commands.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Flutter code sample for [NavigationBar].

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
  int currentPageIndex = 0;
  late String? name;
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late int role = 0;
  late String homeText;
     
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Map loggedInOrNah = {
      0 : "Please log in to add or edit your workhours.",
      1 : "Welcome !"//$name
    };
    if(role == 0)
    {
      homeText = loggedInOrNah[0];
    }
    else{
      homeText = loggedInOrNah[1];
    }
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: <Widget>[
        /// Home page
        Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(8.0),
          child: SizedBox.expand(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      style: ButtonStyle(
                        iconSize: WidgetStateProperty.all<double>(40.0),
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.blue),
                        iconColor: WidgetStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () {
                        print('Add');
                      },
                      icon: const Icon(Icons.add),
                    ),
                    Container(
                      padding: EdgeInsets.all(16.0),
                      child: IconButton(
                        style: ButtonStyle(
                          iconSize: WidgetStateProperty.all<double>(40.0),
                          backgroundColor:
                              WidgetStateProperty.all<Color>(Colors.blue),
                          iconColor:
                              WidgetStateProperty.all<Color>(Colors.white),
                        ),
                        onPressed: () {
                          print('Edit');
                        },
                        icon: const Icon(Icons.edit),
                      ),
                    ),
                  ],
                ),
                Row(
                  
                  children: [Text(homeText)]
                ),
              ],
            ),
          ),
        ),

        /// Notifications page
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 1'),
                  subtitle: Text('This is a notification'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 2'),
                  subtitle: Text('This is a notification'),
                ),
              ),
            ],
          ),
        ),

        /// Messages page
        ListView.builder(
          reverse: true,
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Align(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: idController,
                        decoration: InputDecoration(labelText: 'ID'),
                        keyboardType: TextInputType.number,
                      ),
                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(labelText: 'Password'),
                        obscureText: true,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          final id = int.parse(idController.text);
                          final password = passwordController.text;
                          Login(id, password);
                        },
                        child: Text('Login'),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 47, 0, 255),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'Please login to access your log your hours.',
                  style: theme.textTheme.bodyLarge!
                      .copyWith(color: theme.colorScheme.onPrimary),
                ),
              ),
            );
          },
        ),
      ][currentPageIndex],
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Work Hours'),
      ),
    );
  }
}
