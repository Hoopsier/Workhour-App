import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:io';
import 'package:http/io_client.dart';

http.Client createHttpClient() {
  final httpClient = HttpClient()
    ..badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;

  return IOClient(httpClient);
}

Future<void> Login(int id, String password) async {
  final client = createHttpClient();
  late final response;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    if (id != 0 || //no clue if this does anything
        password != "") {
      response = await http.get(Uri.parse(
          'http://localhost:5016/api/Users/Login?_Id=$id&_Password=$password'));
    }

    print(json.decode(response.body));

    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      // Extract individual values

      int id = data[0]['id'];
      String name = data[0]['name'];
      int role = data[0]['role'];
      String password = data[0]['password'];
      print(name);
      // Parse the response
      await prefs.setInt('role', role); // Save userId as an integer
      await prefs.setString('name', name); // Save name as a string
      await prefs.setInt('id', id); // Save id as an integer
      await prefs.setString('password', password); // Save password as a string
      print("Login successful! welcome ${prefs.getString('name')}");
    } else {
      print("Login failed: ${response.body}");
    }
  } catch (e) {
    if (e is RangeError) {
      print(
          "No account found.\nPlease register, if you don't have an account.");
      return;
    }

    print("Error Logging in: $e");
    return;
  } finally {
    client.close();
  }
}

Future<void> Register(String name, String password) async {
  final client = createHttpClient();
  print("hi");
  final response = await http.post(
    Uri.parse(
        'https://localhost:5016/api/Users/Register?_Name=$name&_Password=$password'),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    },
  );
  print("hi2");
  try {
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      int id = data[0]['id'];
      String password = data[0]['password'];
      await Login(id, password);
    } else {
      print(response.statusCode);
    }
  } catch (e) {
    print("Meow $e");
  } finally {
    client.close();
  }
}
