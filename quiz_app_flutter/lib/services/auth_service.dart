import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final String baseUrl =
      'http://10.0.2.2:8080'; // Use this for Android emulator
  // final String baseUrl = 'http://localhost:8080'; // Use this for iOS simulator
  final storage = FlutterSecureStorage();

  Future<Map<String, dynamic>> register(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Registration successful'};
      } else {
        final errorMsg =
            jsonDecode(response.body)['message'] ?? 'Registration failed';
        return {'success': false, 'message': errorMsg};
      }
    } catch (e) {
      return {'success': false, 'message': 'An error occurred'};
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        await storage.write(key: 'user_id', value: userData['ID']);
        await storage.write(key: 'user_email', value: userData['Email']);
        return {'success': true, 'user': userData};
      } else {
        final errorMsg = jsonDecode(response.body)['message'] ?? 'Login failed';
        return {'success': false, 'message': errorMsg};
      }
    } catch (e) {
      return {'success': false, 'message': 'An error occurred'};
    }
  }

  Future<void> logout() async {
    await storage.delete(key: 'user_id');
    await storage.delete(key: 'user_email');
  }

  Future<String?> getUserEmail() async {
    return await storage.read(key: 'user_email');
  }
}
