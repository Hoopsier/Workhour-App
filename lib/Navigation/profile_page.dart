import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final TextEditingController idController;
  final TextEditingController passwordController;
  final VoidCallback refreshData;

  const ProfilePage({
    super.key,
    required this.idController,
    required this.passwordController,
    required this.refreshData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: idController,
            decoration: const InputDecoration(labelText: 'ID'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              final id = int.parse(idController.text);
              final password = passwordController.text;
              debugPrint('Login ID: $id, Password: $password');
              refreshData();
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
