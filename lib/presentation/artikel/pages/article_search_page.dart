import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mental_health_app/core/configs/theme/app_colors.dart';
import 'package:mental_health_app/providers/article_provider.dart';
import 'package:provider/provider.dart';
import 'package:mental_health_app/data/models/Article.dart';
import 'package:mental_health_app/services/article_service.dart';

class ArticlePageList extends StatelessWidget {
  final String tittle;
  final String content;
  final String? imageUrl;
  final String category;
  final String createdAt;
  final String author;

  const ArticlePageList({
    super.key,
    required this.tittle,
    required this.content,
    required this.category,
    required this.createdAt,
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
                  Text(
                    formatDate(createdAt),
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
                  Text(
                    'Oleh: $author',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1.2,
                  ),
                  const SizedBox(height: 8),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArticleSearchPage extends StatefulWidget {
  final String keyword;

  const ArticleSearchPage({required this.keyword, super.key});

  @override
  _ArticleSearchPageState createState() => _ArticleSearchPageState();
}

class _ArticleSearchPageState extends State<ArticleSearchPage> {
  @override
  Widget build(BuildContext context) {
    final articleProvider = Provider.of<ArticleProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Results'),
      ),
      body: FutureBuilder<List<Article>>(
        future: ArticleService().searchArticles(widget.keyword),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No articles found.'));
          }

          final articles = snapshot.data!;

          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              final String articleImageUrl = article.imageUrl != null &&
                      article.imageUrl.isNotEmpty
                  ? "http://10.0.2.2/api-app/storage/app/private/public/articles/${article.imageUrl}"
                  : 'https://via.placeholder.com/150';
              final articleProvider = Provider.of<ArticleProvider>(context);
              final isLiked =
                  articleProvider.likedArticles[article.id] ?? false;

              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArticlePageList(
                      tittle: article.title,
                      content: article.content,
                      imageUrl: articleImageUrl,
                      category: article.category,
                      createdAt: article.createadAt,
                      author: article.author,
                    ),
                  ),
                ),
                child: Card(
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      if (article.imageUrl != null)
                        Image.network(
                          articleImageUrl,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image),
                        ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                article.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'RobotoSlab',
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                article.content,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'RobotoSlab',
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      isLiked
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isLiked ? Colors.red : Colors.grey,
                                    ),
                                    onPressed: () {
                                      articleProvider.toggleLike(
                                        article.id,
                                        (!isLiked) as int,
                                      );
                                    },
                                  ),
                                  const Spacer(),
                                  Text(
                                    article.category,
                                    style: const TextStyle(
                                      fontFamily: 'RobotoSlab',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
