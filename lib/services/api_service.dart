<<<<<<< HEAD
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.18.82:8000/api';
  String? _token;
=======
// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:mental_health_app/data/models/ScreeningQuestion.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8000/api';
  String? _token;
  String? get token => _token;
>>>>>>> master

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

<<<<<<< HEAD
=======
  Future<http.Response> sendResetLink(String email) async {
    final url = Uri.parse('$baseUrl/forgot-password');
    return await http.post(url, body: {'email': email});
  }

  Future<http.Response> resetPassword(String email, String password,
      String passwordConfirmation, String token) async {
    final url = Uri.parse('$baseUrl/password/reset');
    return await http.post(url, body: {
      'email': email,
      'token': token,
      'password': password,
      'password_confirmation': passwordConfirmation,
    });
  }

>>>>>>> master
  Future<Map<String, dynamic>> register({
    required String nama,
    required String email,
    required String password,
    required String gender,
    required String hp,
    required DateTime tanggal_lahir,
    required String passwordConfirmation,
<<<<<<< HEAD
=======
    required String fcmToken,
>>>>>>> master
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
<<<<<<< HEAD
        }),
      );

=======
          'fcm_token': fcmToken,
        }),
      );
>>>>>>> master
      return _handleResponse(response);
    } catch (e) {
      return {'message': 'Failed to connect to the server: $e'};
    }
  }

<<<<<<< HEAD
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

=======
  Future<Map<String, dynamic>> login(
      {required String email,
      required String password,
      required String fcm_token}) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
          'fcm_token': fcm_token,
        }),
      );

      if (response.statusCode == 200) {
        // Successful login
        final data = json.decode(response.body);

        // Assuming response contains the token and user data
        if (data.containsKey('token') && data.containsKey('user')) {
          final token = data['token'];
          final user = data['user'];

          // Store the token for future API requests
          await setToken(token);

          return {
            'status': 'success',
            'message': 'Login successful',
            'user': user,
            'hasCompletedScreening': data['has_completed_screening']
          };
        } else {
          // In case the expected response structure doesn't match
          throw Exception('Unexpected response structure');
        }
      } else if (response.statusCode == 401) {
        // Unauthorized - Incorrect email/password
        throw Exception('Email or password is incorrect.');
      } else if (response.statusCode == 403) {
        // Forbidden - Email not verified
        throw Exception('Please verify your email before logging in.');
      } else {
        // Other errors
        throw Exception('Failed to login: ${response.body}');
      }
    } catch (e) {
      // Catch network errors or other exceptions

      return {'message': '$e'};
    }
  }

  Future<Map<String, dynamic>> uploadProfileImage(
      int userId, File imageFile) async {
    final uri = Uri.parse('$baseUrl/upload-profile-image');
    final request = http.MultipartRequest('POST', uri)
      ..fields['id_user'] = userId.toString()
      ..files.add(
          await http.MultipartFile.fromPath('profile_image', imageFile.path));

    final response = await http.Response.fromStream(await request.send());

    return jsonDecode(response.body);
  }

>>>>>>> master
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

<<<<<<< HEAD
      final result = _handleResponse(response);
      return result;
=======
      return _handleResponse(response);
>>>>>>> master
    } catch (e) {
      return {'message': 'Failed to connect to the server: $e'};
    }
  }

  Future<Map<String, dynamic>> logout() async {
<<<<<<< HEAD
=======
    await loadToken();
>>>>>>> master
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

<<<<<<< HEAD
  Map<String, dynamic> _handleResponse(http.Response response) {
    final responseBody = jsonDecode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return responseBody; // Successful response
    } else {
      return {
        'message': responseBody['message'] ?? 'Unknown error occurred',
=======
  // Screening Feature

  Future<List<ScreeningQuestion>> getScreeningQuestions() async {
    await loadToken();
    if (_token == null) {
      throw Exception('Not authenticated: Token is missing');
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/screening'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is Map && data.containsKey('questions')) {
          final questionsJson = data['questions'] ?? [];

          return questionsJson
              .map<ScreeningQuestion>((q) => ScreeningQuestion.fromJson(q))
              .toList();
        } else {
          throw Exception('Unexpected response structure: ${response.body}');
        }
      } else {
        // Throw detailed exception if the response is not successful
        throw Exception('Failed to load questions: ${response.body}');
      }
    } catch (e) {
      throw Exception("Exception in getScreeningQuestions: $e");
    }
  }

  Future<Map<String, dynamic>> submitScreeningAnswers(
      List<Map<String, int>> answers) async {
    await loadToken(); // Load the token for authentication
    if (_token == null) {
      return {'message': 'User is not logged in.'};
    }

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/submit'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
        body: jsonEncode({
          'answers': answers,
        }),
      );

      // Handle response and parse JSON
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'message': 'Failed to submit screening. Server error.',
          'status_code': response.statusCode
        };
      }
    } catch (e) {
      return {'message': 'Failed to connect to the server: $e'};
    }
  }

  Future<Map<String, dynamic>> getLatestScreening() async {
    await loadToken(); // Load the token for authentication
    if (_token == null) {
      return {'message': 'User is not logged in.'};
    }
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/latest-screening'),
        headers: {
          'Authorization': 'Bearer $_token', // Pastikan token dikirim
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Jika response berhasil, parsing data
        return json.decode(response.body);
      } else if (response.statusCode == 404) {
        // Jika tidak ditemukan
        return {
          'status': 'error',
          'message': 'Hasil screening tidak ditemukan.',
        };
      } else {
        return {
          'status': 'error',
          'message': 'Gagal mendapatkan hasil screening.',
        };
      }
    } catch (e) {
      // Jika ada exception, menangkapnya
      return {
        'status': 'error',
        'message': 'Terjadi kesalahan: $e',
      };
    }
  }

  Future<Map<String, dynamic>> updateProfile({
    String? nama,
    String? gender,
    String? dateOfBirth,
    String? phone,
  }) async {
    await loadToken();
    if (_token == null) {
      return {'message': 'User is not logged in.'};
    }

    final url = Uri.parse('$baseUrl/updateProfile');
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
        body: jsonEncode({
          'nama': nama,
          'gender': gender,
          'date_of_birth': dateOfBirth,
          'phone': phone,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'status': 'error',
          'message': jsonDecode(response.body)['message'] ??
              'Failed to update profile',
        };
      }
    } catch (e) {
      return {
        'status': 'error',
        'message': 'An error occurred: $e',
      };
    }
  }

  Future<Map<String, dynamic>> updateProfileImage(File imageFile) async {
    await loadToken(); // Load the token for authentication
    if (_token == null) {
      return {'message': 'User is not logged in.'};
    }
    try {
      final uri = Uri.parse('$baseUrl/update-profile-image');
      final request = http.MultipartRequest('POST', uri);

      // Tambahkan file gambar
      request.files.add(await http.MultipartFile.fromPath(
        'profile_image',
        imageFile.path,
      ));

      // Tambahkan header authorization (jika diperlukan)
      request.headers.addAll({
        'Authorization': 'Bearer $_token',
        'Accept': 'application/json',
      });

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await http.Response.fromStream(response);
        return json.decode(responseData.body);
      } else {
        return {
          'status': 'error',
          'message':
              'Failed to upload profile image. Status Code: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {'status': 'error', 'message': 'An error occurred: $e'};
    }
  }

  Future<Map<String, dynamic>> changePassword(
      String currentPassword, String newPassword) async {
    final url = Uri.parse('$baseUrl/change-password');
    await loadToken();
    if (_token == null) {
      return {'message': 'User is not logged in.'};
    } // Ganti endpoint sesuai API kamu

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'current_password': currentPassword,
          'new_password': newPassword,
          'new_password_confirmation': newPassword,
        }),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': data['message'],
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to change password.',
          'errors': data['errors'] ?? {},
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'An error occurred.',
        'error_details': e.toString(),
      };
    }
  }

  Future<bool> updateNotificationStatus(bool isEnabled) async {
    await loadToken();
    if (_token == null) {
      return false;
    } // Ganti endpoint sesuai API kamu
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/update-notif-status'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Tambahkan token jika diperlukan
        },
        body: jsonEncode({
          'notifications_enabled': isEnabled,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    final responseBody = jsonDecode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return responseBody;
    } else {
      return {
        'message': responseBody['message'] ?? 'Unknown error occurred',
        'error': responseBody['error'] ?? 'Unknown error',
>>>>>>> master
        'status_code': response.statusCode
      };
    }
  }
<<<<<<< HEAD
=======

  fetchRandomQuote() {}
>>>>>>> master
}
