// ignore_for_file: unused_field

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mental_health_app/common/widgets/appbar/bottom_navbar.dart';
import 'package:mental_health_app/core/configs/assets/app_images.dart';
import 'package:mental_health_app/core/configs/assets/app_vectors.dart';
import 'package:mental_health_app/core/configs/theme/app_colors.dart';
import 'package:mental_health_app/services/article_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mental_health_app/services/api_service.dart';
import 'package:mental_health_app/services/qoutes_service.dart';
import 'package:mental_health_app/providers/article_provider.dart';
import 'package:provider/provider.dart';
import 'package:mental_health_app/presentation/artikel/pages/article_search_page.dart';

// Contoh halaman artikel
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
      return DateFormat('dd-MM-yyyy').format(parsedDate);
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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService _apiService = ApiService();
  final ArticleService _articleService = ArticleService();
  final QoutesService _qoutesService = QoutesService();
  final TextEditingController _searchController = TextEditingController();
  String _userName = '';
  String _errorMessage = '';
  String _profileImage = '';
  String _articleImage = '';
  String? content;
  String? author;

  int userId = 0;
  int articleId = 0;
  List<dynamic> _articles = [];
  Map<String, dynamic>? _screeningData;
  bool _isLoading = true;
  Map<int, bool> _likedArticles = {};

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
    fetchQuote();
    getLikeStatus(articleId).then((status) {
      setState(() {
        _likedArticles[articleId] = status;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchUserProfile();
    _fetchScreeningData();
    fetchRecommendedArticles();
  }

  Future<void> _fetchScreeningData() async {
    var data = await _apiService.getLatestScreening();
    setState(() {
      _screeningData = data;
    });
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

  Future<void> fetchUserProfile() async {
    try {
      final result = await _apiService.getProfile();

      if (result['status'] == 'success') {
        setState(() {
          _userName = result['user']['nama'];
          userId = result['user']['id_user'];
          _profileImage = result['user']['profile_image'];
        });
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

  Future<void> fetchRecommendedArticles() async {
    try {
      final articles = await _articleService.fetchRecommendedArticles();
      setState(() {
        _articles = articles;
        _articleImage = articles[0]['image'];
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Failed to load articles: $e';
          _isLoading = false;
        });
      }
    }
  }

  String formatScreeningDate(String? rawDate) {
    if (rawDate == null) return "N/A";

    try {
      final DateTime parsedDate = DateTime.parse(rawDate);
      final DateFormat formatter = DateFormat(
        'dd MMMM yyyy',
      ); // Bahasa Indonesia
      return formatter.format(parsedDate);
    } catch (e) {
      return "Format tanggal tidak valid";
    }
  }

  void _navigateToArticle(BuildContext context, Map<String, dynamic> article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArticlePageList(
          tittle: article['tittle'],
          content: article['content'],
          imageUrl: article['image'] != null && article['image'].isNotEmpty
              ? "https://mentalhealth.cyou/storage/app/private/public/articles/${article['image']}"
              : 'https://via.placeholder.com/150',
          category: article['category'],
          created_at: article['createdAt'],
          author: article['author'],
        ),
      ),
    );
  }

  Future<void> checkArticleLikeStatus(int articleId) async {
    try {
      final isLiked = await _articleService.checkArticleLiked(articleId);
      setState(() {
        _likedArticles[articleId] = isLiked;
      });
    } catch (e) {
      print('Failed to check like status: $e');
    }
  }

  Set<int> _processingLikes = {};

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
        onTap: () => _navigateToArticle(context, article),
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
                      maxLines: 2, // Limit the content to 3 lines
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Kategori: ' + article["category"] ?? "No Category",
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
                                        'http://10.0.2.2/api-app/storage/app/private/public/profile_images/$_profileImage'),
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
                                            color: AppColors.grey,
                                            fontSize: 12),
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
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 0),
                            width: 210,
                            height: 100,
                            child: Text(
                              _userName.isNotEmpty
                                  ? 'Halo, $_userName'
                                  : 'Memuat...',
                              style: const TextStyle(
                                  fontFamily: 'RobotoSlab',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 30,
                                  color: AppColors.primaryBackground),
                            )),
                        const SizedBox(width: 0),
                        Image.asset(
                          AppImages.homeAppbar,
                          width: 150,
                          height: 139,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),

          // Main Content
          Expanded(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    const SizedBox(height: 16),

                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 1.0,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const BottomNavbar(
                                          currentIndex: 2,
                                        )),
                              );
                            },
                            child: const Text(
                              'Hasil Screening anda   >',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.teal,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          const SizedBox(height: 2.0),
                          // Depression Score

                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 11),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Depression Score:',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  '${_screeningData?['data']['depresion_score'] ?? 0}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.teal),
                                ),
                              ],
                            ),
                          ),
                          // Anxiety Score
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 11),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Anxiety Score:',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  '${_screeningData?['data']['anxiety_score'] ?? 0}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.teal),
                                ),
                              ],
                            ),
                          ),
                          // Stress Score
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 11),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Stress Score:',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  '${_screeningData?['data']['stress_score'] ?? 0}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.teal),
                                ),
                              ],
                            ),
                          ),
                          // Screening Date
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 11),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Screening Date:',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  formatScreeningDate(_screeningData?['data']
                                      ?['screening_date']),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.teal),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BottomNavbar(
                                      currentIndex: 2,
                                    )),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          maximumSize: const Size(350, 60),
                          backgroundColor: Colors.teal,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppVectors.howAreYou,
                              width: 28,
                              height: 28,
                            ),
                            const SizedBox(width: 5),
                            const Text(
                              'Bagaimana Perasaan mu Hari ini ?',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
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
                        '- $author -',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(right: 120),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BottomNavbar(
                                      currentIndex: 1,
                                    )),
                          );
                        },
                        child: const Text(
                          'Artikel untuk Anda   >',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.teal,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ignore: unnecessary_to_list_in_spreads
                    ..._articles
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
