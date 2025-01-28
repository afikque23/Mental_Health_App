import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mental_health_app/data/models/Article.dart';
import 'package:mental_health_app/services/api_service.dart';

class ArticleService {
  static const String _baseUrl = 'https://mentalhealth.cyou/api';
  final ApiService _apiService = ApiService();

  // Fetch all articles with like status
  Future<List<dynamic>> getAllArticles(int userId) async {
    await _apiService.loadToken();
    final token = _apiService.token;
    if (token == null) {
      return Future.error('User not authenticated');
    }

    final response = await http.get(
      Uri.parse('$_baseUrl/articles/all?id_user=$userId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status'] == 'success' && jsonResponse['data'] is List) {
        return jsonResponse['data'];
      } else {
        throw Exception('Unexpected response structure');
      }
    } else {
      return Future.error(
          'Failed to fetch articles: ${response.statusCode}, ${response.body}');
    }
  }

  Future<List<Article>> searchArticles(String keyword) async {
    await _apiService.loadToken();
    final token = _apiService.token;
    if (token == null) {
      throw Exception('User not authenticated');
    }
    final response = await http.get(
      Uri.parse('$_baseUrl/articles/search?keyword=$keyword'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['articles'] as List)
          .map((article) => Article.fromJson(article))
          .toList();
    } else {
      throw Exception('Failed to search articles');
    }
  }

  Future<List<dynamic>> getLikedArticles(int userId) async {
    await _apiService.loadToken();
    final token = _apiService.token;

    // Pastikan token ada
    if (token == null) {
      throw Exception("User is not authenticated.");
    }

    final response = await http.get(
      Uri.parse('$_baseUrl/articles/liked/$userId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['status'] == 'success') {
        return data['data']; // Return the list of liked articles
      } else {
        throw Exception('Failed to load liked articles');
      }
    } else {
      throw Exception('Failed to fetch liked articles');
    }
  }

  // Fetch recommended articles
  Future<List<dynamic>> fetchRecommendedArticles() async {
    await _apiService.loadToken();
    final token = _apiService.token;

    if (token == null) {
      throw Exception("User is not authenticated.");
    }

    final url = Uri.parse('$_baseUrl/recommended-articles');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return data['data'] ?? [];
    } else {
      throw Exception(
          "Failed to fetch recommended articles: ${response.statusCode}");
    }
  }

  // Toggle like on an article
  Future<bool> toggleLike(int userId, int articleId) async {
    // Muat token dari _apiService
    await _apiService.loadToken();
    final token = _apiService.token;

    // Pastikan token ada
    if (token == null) {
      throw Exception("User is not authenticated.");
    }

    try {
      // Kirim permintaan ke API
      final response = await http.post(
        Uri.parse('$_baseUrl/articles/like'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: json.encode({
          'id_user': userId,
          'id_article': articleId,
        }),
      );

      // Log respons untuk debugging

      // Tangani respons API
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);

        if (data['status'] == "success") {
          // Kembalikan status like saat ini
          final likeStatus = data['like-status'];
          return likeStatus ?? false;
        } else {
          // Jika respons gagal, lempar pesan error
          throw Exception(data['message'] ?? 'Failed to toggle like');
        }
      } else {
        // Jika respons bukan 200/201, lempar error
        throw Exception('Failed to toggle like: ${response.statusCode}');
      }
    } catch (e) {
      // Log error untuk debugging

      rethrow;
    }
  }

  // Check if article is liked
  Future<bool> checkArticleLiked(int articleId) async {
    await _apiService.loadToken();
    final token = _apiService.token;

    if (token == null) {
      throw Exception('User not authenticated');
    }

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/articles/$articleId/like-status'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['liked'] ?? false;
      } else {
        throw Exception('Failed to check like status: ${response.statusCode}');
      }
    } catch (e) {
      return false;
    }
  }
}
