class Article {
  final int id;
  final String title;
  final String content;
  final String author;
  final String category;
  final String imageUrl;
  final bool isLiked;
  final String createadAt;

  Article({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.category,
    required this.imageUrl,
    required this.isLiked,
    required this.createadAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id_article'],
      title: json['tittle'] ?? '',
      content: json['content'] ?? '',
      author: json['author'] ?? '',
      category: json['category'] ?? 'Uncategorized',
      isLiked: json['isLiked'] ?? false,
      imageUrl: json['image'] ?? '',
      createadAt: json['createdAt'] ?? '',
    );
  }
}
