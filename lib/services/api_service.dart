import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.18.82:8000/api';
  String? _token;

  Future<void> setToken(String token) async {
    _token = token;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
  }

  Future<void> clearToken() async {
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<Map<String, dynamic>> register({
    required String nama,
    required String email,
    required String password,
    required String gender,
    required String hp,
    required DateTime tanggal_lahir,
    required String passwordConfirmation,
  }) async {
    final dateFormatter = DateFormat('yyyy-MM-dd');
    final formattedDate = dateFormatter.format(tanggal_lahir);

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nama': nama,
          'email': email,
          'gender': gender,
          'hp': hp,
          'tanggal_lahir': formattedDate,
          'password': password,
          'password_confirmation': passwordConfirmation,
        }),
      );

      return _handleResponse(response);
    } catch (e) {
      return {'message': 'Failed to connect to the server: $e'};
    }
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final result = _handleResponse(response);
      if (result.containsKey('token')) {
        await setToken(
            result['token']); // Save the token if login is successful
      }
      return result;
    } catch (e) {
      return {'message': 'Failed to connect to the server: $e'};
    }
  }

  Future<Map<String, dynamic>> getProfile() async {
    await loadToken();
    if (_token == null) {
      return {'message': 'User is not logged in.'};
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
      );

      final result = _handleResponse(response);
      return result;
    } catch (e) {
      return {'message': 'Failed to connect to the server: $e'};
    }
  }

  Future<Map<String, dynamic>> logout() async {
    if (_token == null) {
      return {'message': 'User is not logged in.'};
    }

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/logout'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
      );

      await clearToken(); // Clear token on logout
      return _handleResponse(response);
    } catch (e) {
      return {'message': 'Failed to connect to the server: $e'};
    }
  }

  Future<Map<String, dynamic>> deleteAccount() async {
    if (_token == null) {
      return {'message': 'User is not logged in.'};
    }

    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/delete-account'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
      );

      await clearToken(); // Clear token if account deletion is successful
      return _handleResponse(response);
    } catch (e) {
      return {'message': 'Failed to connect to the server: $e'};
    }
  }

  Future<void> resendVerificationEmail(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/resend-verification-email'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to send verification email: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    final responseBody = jsonDecode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return responseBody; // Successful response
    } else {
      return {
        'message': responseBody['message'] ?? 'Unknown error occurred',
        'status_code': response.statusCode
      };
    }
  }
}
