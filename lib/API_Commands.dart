import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> Login(int id, String password) async {
  final response = await http.get(Uri.parse(
      'http://localhost:5016/api/Users/Login?_Id=$id&_Password=$password')); // Replace with your API URL
  print(json.decode(response.body));
  try {
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      // Extract individual values

      int id = data[0]['id'];
      String name = data[0]['name'];
      int role = data[0]['role'];
      String password = data[0]['password'];
      print(name);
      // Parse the response

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('role', role); // Save userId as an integer
      await prefs.setString('name', name); // Save name as a string
      await prefs.setInt('id', id); // Save id as an integer
      await prefs.setString('password', password);
      print("Login successful! welcome ${prefs.getString('name')}");
    } else {
      print("Login failed: ${response.body}");
    }
  } catch (e) {
    print("An error occurred: $e");
  }
}

int getRole() {
  return 2;
}
