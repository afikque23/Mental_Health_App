import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mental_health_app/services/api_service.dart';

class MoodService {
  static const String _baseUrl = 'http://10.0.2.2:8000/api';
  final ApiService _apiService = ApiService();

  // Ambil data mood tracker berdasarkan filter waktu
  Future<List<dynamic>> getFilteredMoodTrackers(
      String filter, int userId) async {
    await _apiService.loadToken();
    final token = _apiService.token;
    if (token == null) {
      return Future.error('User not authenticated');
    }

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/mood-trackers?&filter=$filter&id_user=$userId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'] as List;
        return data;
      } else {
        throw Exception('Failed to load mood trackers');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Tambah mood tracker baru
  Future<dynamic> addMoodTracker({
    required String storyUser,
    required int userId,
    required String mood,
  }) async {
    await _apiService.loadToken();
    final token = _apiService.token;
    if (token == null) {
      return Future.error('User not authenticated');
    }

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/add-mood'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'story_user': storyUser,
          'id_user': userId,
          'mood': mood,
        }),
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to add mood tracker');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
