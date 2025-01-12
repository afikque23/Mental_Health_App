import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mental_health_app/services/article_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArticleProvider extends ChangeNotifier {
  final ArticleService _articleService = ArticleService();
  List<dynamic> _articles = [];
  Map<int, bool> _likedArticles = {};
  bool _isLoading = false;

  List<dynamic> get articles => _articles;
  Map<int, bool> get likedArticles => _likedArticles;
  bool get isLoading => _isLoading;

  ArticleProvider() {
    fetchArticles();
    loadLikedArticles();
  }

  Future<void> fetchArticles() async {
    _isLoading = true;
    notifyListeners();
    try {
      _articles = await _articleService.fetchRecommendedArticles();
    } catch (e) {
      debugPrint("Error fetching articles: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleLike(int userId, int articleId) async {
    final currentStatus = _likedArticles[articleId] ?? false;
    _likedArticles[articleId] = !currentStatus;
    notifyListeners();

    try {
      final newStatus = await _articleService.toggleLike(userId, articleId);
      _likedArticles[articleId] = newStatus;
      saveLikedArticles();
    } catch (e) {
      _likedArticles[articleId] = currentStatus;
      debugPrint("Error toggling like: $e");
      notifyListeners();
    }
  }

  Future<void> loadLikedArticles() async {
    final prefs = await SharedPreferences.getInstance();
    final likedArticlesString = prefs.getString('likedArticles') ?? '[]';
    List<dynamic> likedArticlesList = jsonDecode(likedArticlesString);

    _likedArticles = {
      for (var entry in likedArticlesList)
        int.parse(entry['id']): entry['liked'] as bool,
    };

    notifyListeners();
  }

  Future<void> saveLikedArticles() async {
    final prefs = await SharedPreferences.getInstance();
    final likedArticlesList = _likedArticles.entries
        .map((entry) => {'id': entry.key.toString(), 'liked': entry.value})
        .toList();
    prefs.setString('likedArticles', jsonEncode(likedArticlesList));
  }
}
