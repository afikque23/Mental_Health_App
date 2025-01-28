// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:mental_health_app/core/configs/theme/app_colors.dart';
import 'package:mental_health_app/services/article_service.dart';

import 'package:mental_health_app/services/api_service.dart';
import 'package:mental_health_app/providers/article_provider.dart';
import 'package:provider/provider.dart';

// Contoh halaman artikel
class FavoritePageList extends StatelessWidget {
  final String tittle;
  final String content;
  final String? imageUrl; // Tambahkan opsional gambar header
  final String category; // Tambahkan opsional gambar header
  final String created_at; // Tambahkan opsional gambar header
  final String author; // Tambahkan opsional gambar header

  const FavoritePageList({
    super.key,
    required this.tittle,
    required this.content,
    required this.category,
    required this.created_at,
    required this.author,
    this.imageUrl,
  });

  String formatDate(String? rawDate) {
    if (rawDate == null) return "No Date";
    try {
      final parsedDate = DateTime.parse(rawDate);
      return DateFormat('yyyy-MM-dd').format(parsedDate);
    } catch (e) {
      return "Invalid Date";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "NURAGA",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar header (opsional)
            if (imageUrl != null)
              Image.network(
                imageUrl!,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, size: 100),
              ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Kategori artikel
                  Chip(
                    label: Text(
                      category,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 64, 130, 112),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    backgroundColor: AppColors.primary.withOpacity(0.5),
                    side:
                        const BorderSide(color: AppColors.primary, width: 0.5),
                  ),
                  // Tanggal dibuat
                  Text(
                    formatDate(created_at),
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'RobotoSlab',
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul artikel
                  Text(
                    tittle,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'RobotoSlab',
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Penulis artikel
                  Text(
                    'Oleh: $author',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  // Garis pembatas
                  const Divider(
                    color: Colors.grey,
                    thickness: 1.2,
                  ),
                  const SizedBox(height: 8),
                  // Konten artikel
                  Text(
                    content,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 24),
                  // Tombol Kembali
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<FavoritePage> {
  final ApiService _apiService = ApiService();
  final ArticleService _articleService = ArticleService();

  String _userName = '';
  String _errorMessage = '';
  String _profileImage = '';
  String _articleImage = '';
  List<dynamic> _likedArticlesList = [];
  int userId = 0;
  List<dynamic> _articles = [];
  List<String> _categories = ['Semua'];
  String _selectedCategory = 'Semua';
  bool _isLoading = true;
  Map<int, bool> _likedArticles = {};

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchAllArticles();
  }

  Future<void> fetchUserProfile() async {
    try {
      final result = await _apiService.getProfile();
      if (result['status'] == 'success') {
        setState(() {
          _userName = result['user']['nama'];
          userId = result['user']['id_user'];
          _profileImage = result['user']['profile_image'];
        });
        fetchAllArticles();
      } else {
        setState(() {
          _errorMessage = result['message'] ?? 'Error loading profile';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to fetch user profile: $e';
      });
    }
  }

  Future<void> fetchAllArticles() async {
    try {
      final articles = await _articleService.getLikedArticles(userId);
      setState(() {
        _likedArticlesList = articles;
        _categories = ['Semua', ..._extractCategories(articles)];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error fetching liked articles: $e';
      });
    }
  }

  List<String> _extractCategories(List<dynamic> articles) {
    return articles
        .map((article) => article['category'] as String)
        .toSet()
        .toList();
  }

  List<dynamic> _filteredArticles() {
    if (_selectedCategory == 'Semua') {
      return _likedArticlesList;
    }
    return _likedArticlesList
        .where((article) => article['category'] == _selectedCategory)
        .toList();
  }

  Future<void> toggleLike(int articleId) async {
    final currentStatus = _likedArticles[articleId] ?? false;

    setState(() {
      _likedArticles[articleId] = !currentStatus;
    });

    try {
      final newStatus = await _articleService.toggleLike(userId, articleId);
      setState(() {
        _likedArticles[articleId] = newStatus;
      });
    } catch (e) {
      setState(() {
        _likedArticles[articleId] = currentStatus;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update like status: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _setSelectedCategory(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  Widget _buildArticleCard(
      BuildContext context, Map<String, dynamic> _likedArticlesList) {
    final articleProvider = Provider.of<ArticleProvider>(context);
    final isLiked =
        articleProvider.likedArticles[_likedArticlesList['id_article']] ??
            false;
    final String articleImageUrl = _likedArticlesList['image'] != null &&
            _likedArticlesList['image'].isNotEmpty
        ? "http://10.0.2.2/api-app/storage/app/private/public/articles/${_likedArticlesList['image']}"
        : 'https://via.placeholder.com/150';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      width: double.infinity,
      height: 179,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FavoritePageList(
              tittle: _likedArticlesList['tittle'] ?? "No Title",
              content: _likedArticlesList['content'] ?? "No Content",
              imageUrl: _likedArticlesList['image'] != null &&
                      _likedArticlesList['image'].isNotEmpty
                  ? "http://10.0.2.2/api-app/storage/app/private/public/articles/${_likedArticlesList['image']}"
                  : 'https://via.placeholder.com/150',
              category: _likedArticlesList['category'] ?? "No Category",
              created_at: _likedArticlesList['createdAt'] ?? "No Date",
              author: _likedArticlesList['author'] ?? "Unknown Author",
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 146,
              height: 275,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(articleImageUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 8,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white, // Warna lingkaran
                      ),
                      width: 40, // Sesuaikan diameter lingkaran
                      height: 35, // Sesuaikan diameter lingkaran
                      alignment: Alignment.center,
                      child: Icon(
                        _likedArticlesList['isLiked']
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: _likedArticlesList['isLiked']
                            ? Colors.red
                            : Colors.black,
                        size: 24, // Ukuran ikon
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: IconButton(
                      padding: const EdgeInsets.all(0),
                      alignment: Alignment.center,
                      icon: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: Colors
                            .transparent, // Membuat ikon transparan agar fungsi tap tetap bekerja
                        size: 40, // Ukuran area klik
                      ),
                      onPressed: () {
                        articleProvider.toggleLike(
                          userId, // Ganti dengan ID pengguna sebenarnya
                          _likedArticlesList['id_article'],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _likedArticlesList["tittle"] ?? "No Title",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      _likedArticlesList["content"] ?? "No Content",
                      style: const TextStyle(fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Category: ${_likedArticlesList["category"] ?? "No Category"}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: AppBar(
                titleSpacing: 2,
                title: const Text(
                  "Favorite Articles",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                backgroundColor: Colors.white,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),
          // Main Content
          Expanded(
            child: Container(
              color: AppColors.primaryBackground,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView(
                  children: [
                    const SizedBox(height: 0),
                    const Center(
                      child: Text(
                        '"Aequam memento rebus in arduis servare mentem"',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Center(
                      child: Text(
                        '-Classroom of the Elite 02[00 : 30]-',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Filter Kategori
                    SizedBox(
                      height: 35,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categories.length,
                        itemBuilder: (context, index) {
                          final category = _categories[index];
                          final isSelected = _selectedCategory == category;

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ElevatedButton(
                              onPressed: () => _setSelectedCategory(category),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isSelected
                                    ? AppColors.primary
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: isSelected
                                        ? AppColors.primary
                                        : Colors.black,
                                  ),
                                ),
                              ),
                              child: Text(
                                category,
                                style: TextStyle(
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Daftar Artikel
                    ..._filteredArticles().map((_likedArticlesList) =>
                        _buildArticleCard(context, _likedArticlesList)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
