import 'package:flutter/material.dart';
import '../API/API_Commands.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  final TextEditingController idController;
  final TextEditingController loginPasswordController;
  final TextEditingController registerPasswordController;
  final TextEditingController nameController;
  final VoidCallback refreshData;
  final VoidCallback initializeData;

  const ProfilePage({
    super.key,
    required this.idController,
    required this.loginPasswordController,
    required this.registerPasswordController,
    required this.refreshData,
    required this.nameController,
    required this.initializeData,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> clearLocalStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    print("Local storage cleared!");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: widget.idController,
            decoration: const InputDecoration(labelText: 'ID'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: widget.loginPasswordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              final id = int.parse(widget.idController.text);
              final password = widget.loginPasswordController.text;
              print('Login ID: $id, Password: $password');
              await Login(id, password);
              widget.refreshData();
              print("SSSS");
            },
            child: const Text('Login'),
          ),
          TextField(
            controller: widget.nameController,
            decoration: const InputDecoration(labelText: 'Name'),
            keyboardType: TextInputType.name,
          ),
          TextField(
            controller: widget.registerPasswordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          ElevatedButton(
              onPressed: () async {
                final name = widget.nameController.text;
                final password = widget.registerPasswordController.text;
                await Register(name, password);
                widget.refreshData();
              },
              child: const Text("Register")),
          ElevatedButton(
            onPressed: () async {
              await clearLocalStorage();
              widget.initializeData();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 160, 11, 0),
            ),
            child: const Text("Log out",
            style: TextStyle(
                inherit: false,
                color: Color.fromARGB(255, 255, 255, 255)),),
          ),
        ],
      ),
    );
  }
}
