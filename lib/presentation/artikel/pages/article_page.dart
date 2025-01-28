import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mental_health_app/common/widgets/appbar/bottom_navbar.dart';
import 'package:mental_health_app/core/configs/assets/app_images.dart';
import 'package:mental_health_app/core/configs/theme/app_colors.dart';
import 'package:mental_health_app/presentation/artikel/pages/article_search_page.dart';
import 'package:mental_health_app/services/api_service.dart';
import 'package:mental_health_app/services/article_service.dart';
import 'package:mental_health_app/providers/article_provider.dart';
import 'package:mental_health_app/services/qoutes_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArticlePageList extends StatelessWidget {
  final String tittle;
  final String content;
  final String? imageUrl; // Tambahkan opsional gambar header
  final String category; // Tambahkan opsional gambar header
  final String created_at; // Tambahkan opsional gambar header
  final String author; // Tambahkan opsional gambar header

  const ArticlePageList({
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

class ArticlePage extends StatefulWidget {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  final ApiService _apiService = ApiService();
  final ArticleService _articleService = ArticleService();
  final QoutesService _qoutesService = QoutesService();
  final TextEditingController _searchController = TextEditingController();

  String _userName = '';
  String _errorMessage = '';
  String _profileImage = '';
  String _articleImage = '';
  String _selectedCategory = 'Semua';
  String content = '';
  String author = '';

  List<dynamic> _articles = [];
  List<String> _categories = ['Semua'];

  Map<int, bool> _likedArticles = {};

  int articleId = 0;
  int userId = 0;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
    fetchQuote();
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchAllArticles();
  }

  Future<void> fetchQuote() async {
    try {
      final response = await _qoutesService.fetchRandomQuote();
      setState(() {
        content = response['data']['content'];
        author = response['data']['author'] ?? 'Unknown';
      });
    } catch (e) {
      setState(() {
        content = 'Failed to fetch quote. Please try again later.';
        author = '';
      });
    }
  }

  Future<void> fetchUserProfile() async {
    try {
      final result = await _apiService.getProfile();

      if (result['status'] == 'success') {
        setState(() {
          _userName = result['user']['nama'];
          userId = result['user']['id_user'];

          _profileImage = result['user']['profile_image'] ?? '';
        });
        getLikeStatus(articleId).then((status) {
          setState(() {
            _likedArticles[articleId] = status;
          });
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
      final articles = await _articleService.getAllArticles(userId);
      // for (var article in articles) {
      //   final int articleId = article['id_article'];
      //   final isLiked = await _articleService.checkArticleLiked(articleId);
      //   _likedArticles[articleId] = isLiked;
      // }
      setState(() {
        _articles = articles;
        _categories = ['Semua', ..._extractCategories(articles)];
        _articleImage = articles[0]['image'];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error fetching articles: $e';
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
      return _articles;
    }
    return _articles
        .where((article) => article['category'] == _selectedCategory)
        .toList();
  }

  Future<bool> getLikeStatus(int articleId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('article_like_$articleId') ??
        false; // Default false if not found
  }

  Future<void> saveLikedArticles() async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> likedArticlesList = _likedArticles.entries
        .map((entry) => {
              'id': entry.key.toString(), // Convert the key to a String
              'liked': entry.value,
            })
        .toList();
    prefs.setString('likedArticles', jsonEncode(likedArticlesList));
  }

  Future<void> loadLikedArticles() async {
    final prefs = await SharedPreferences.getInstance();
    final likedArticlesString = prefs.getString('likedArticles') ?? '[]';
    List<dynamic> likedArticlesList = jsonDecode(likedArticlesString);

    // Convert the List of maps back to a Map<int, bool>
    Map<int, bool> likedArticlesMap = {};
    for (var entry in likedArticlesList) {
      final int id = int.parse(entry['id']); // Convert String back to int
      final bool liked = entry['liked'];
      likedArticlesMap[id] = liked;
    }

    setState(() {
      _likedArticles = likedArticlesMap;
    });
  }

  Future<void> toggleLike(int articleId) async {
    // Ambil status suka saat ini atau default ke false
    final currentLikeStatus = _likedArticles[articleId] ?? false;

    // Perbarui status suka secara lokal
    setState(() {
      _likedArticles[articleId] = !currentLikeStatus;
    });

    try {
      // Panggil API untuk memperbarui status suka
      final bool newLikeStatus =
          await _articleService.toggleLike(userId, articleId);

      // Perbarui status suka di peta jika berhasil
      saveLikedArticles();

      setState(() {
        _likedArticles[articleId] = newLikeStatus;
      });
    } catch (e) {
      // Kembalikan status awal jika terjadi kesalahan
      setState(() {
        _likedArticles[articleId] = currentLikeStatus;
      });

      // Tampilkan pesan kesalahan
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

  Widget _buildArticleCard(BuildContext context, Map<String, dynamic> article) {
    final articleProvider = Provider.of<ArticleProvider>(context);

    final isLiked =
        articleProvider.likedArticles[article['id_article']] ?? false;

    final String articleImageUrl = article['image'] != null &&
            article['image'].isNotEmpty
        ? "https://mentalhealth.cyou/storage/app/private/public/articles/${article['image']}"
        : 'https://via.placeholder.com/150';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      constraints: const BoxConstraints(maxHeight: 230),
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
            builder: (context) => ArticlePageList(
              tittle: article['tittle'] ?? "No Title",
              content: article['content'] ?? "No Content",
              imageUrl: article['image'] != null && article['image'].isNotEmpty
                  ? "https://mentalhealth.cyou/storage/app/private/public/articles/${article['image']}"
                  : 'https://via.placeholder.com/150',
              category: article['category'] ?? "No Category",
              created_at: article['createdAt'] ?? "No Date",
              author: article['author'] ?? "Unknown Author",
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
                        article['isLiked']
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: article['isLiked'] ? Colors.red : Colors.black,
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
                          article['id_article'],
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
                      article["tittle"] ?? "No Title",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      article["content"] ?? "No Content",
                      style: const TextStyle(fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Category: ${article["category"] ?? "No Category"}',
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
          // App Bar
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(50)),
            child: Container(
              padding: const EdgeInsets.all(16),
              color: AppColors.primary,
              child: SafeArea(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: GestureDetector(
                            onTap: () {
                              // Navigasi ke ProfilePage saat foto profil ditekan
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const BottomNavbar(
                                          currentIndex: 3,
                                        )),
                              );
                            },
                            child: _profileImage.isNotEmpty
                                ? CircleAvatar(
                                    radius: 25,
                                    backgroundImage: NetworkImage(
                                        'https://mentalhealth.cyou/storage/app/private/public/profile_images/$_profileImage'),
                                  )
                                : const CircleAvatar(
                                    radius: 30,
                                    child: Icon(Icons.person, size: 30),
                                  ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: 276,
                            height: 40,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.search,
                                      color: Colors.black),
                                  onPressed: () {
                                    final keyword = _searchController.text;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ArticleSearchPage(
                                                  keyword: keyword)),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  width: 0,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                    child: TextField(
                                      onSubmitted: (value) {
                                        if (value.isNotEmpty) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ArticleSearchPage(
                                                      keyword: value),
                                            ),
                                          );
                                        }
                                      },
                                      decoration: const InputDecoration(
                                        hintText: 'Cari artikel disini...',
                                        hintStyle: TextStyle(
                                            color: Colors.black, fontSize: 12),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 0),
                          width: 210,
                          height: 100,
                          child: const Text(
                            'Ayo kita Membaca!',
                            style: TextStyle(
                                fontFamily: 'Coiny',
                                fontSize: 30,
                                color: AppColors.primaryBackground),
                          ),
                        ),
                        Image.asset(
                          AppImages.articleAppbar,
                          width: 150,
                          height: 126,
                        ),
                      ],
                    ),
                  ],
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
                    Center(
                      child: Text(
                        '"$content"',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Center(
                      child: Text(
                        '-$author-',
                        style: const TextStyle(
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
                    ..._filteredArticles()
                        .map((article) => _buildArticleCard(context, article)),
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
