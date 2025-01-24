import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String? name;
  final int role;
  final String password;
  final int id;
  final VoidCallback initializeData;

  const HomePage({
    super.key,
    required this.name,
    required this.role,
    required this.password,
    required this.id,
    required this.initializeData,
  });

  @override
  Widget build(BuildContext context) {
    final String homeText = role == 0
        ? "Please log in to add or edit your workhours."
        : "Welcome $name!";
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  debugPrint('Add');
                },
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  debugPrint('Edit');
                },
              ),
            ],
          ),
          Text(homeText),
        ],
      ),
    );
  }
}
