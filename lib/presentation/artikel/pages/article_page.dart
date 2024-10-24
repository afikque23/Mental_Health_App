import 'package:flutter/material.dart';
import 'package:mental_health_app/core/configs/assets/app_images.dart';
import 'package:mental_health_app/core/configs/theme/app_colors.dart';

// Contoh halaman artikel (Anda bisa ganti dengan halaman artikel yang sebenarnya)
class ArticlePageList extends StatelessWidget {
  final String title;
  const ArticlePageList({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('Halaman artikel: $title')),
    );
  }
}

class ArticlePage extends StatelessWidget {
  const ArticlePage({super.key});

  // Data artikel dengan informasi navigasi
  final List<Map<String, dynamic>> articles = const [
    {
      "title": "Mengatasi Stress",
      "content":
          "Tips dan trik mengatasi stress dalam kehidupan sehari-hari...",
      "route": "/artikel-stress",
      "pageBuilder": ArticlePageList(title: "Mengatasi Stress"),
    },
    {
      "title": "Meditasi untuk Pemula",
      "content": "Panduan lengkap meditasi untuk pemula yang ingin memulai...",
      "route": "/artikel-meditasi",
      "pageBuilder": ArticlePageList(title: "Meditasi untuk Pemula"),
    },
    {
      "title": "Pola Tidur Sehat",
      "content":
          "Bagaimana menciptakan pola tidur yang sehat dan berkualitas...",
      "route": "/artikel-tidur",
      "pageBuilder": ArticlePageList(title: "Pola Tidur Sehat"),
    },
    {
      "title": "Nutrisi untuk Mental",
      "content": "Makanan yang dapat membantu meningkatkan kesehatan mental...",
      "route": "/artikel-nutrisi",
      "pageBuilder": ArticlePageList(title: "Nutrisi untuk Mental"),
    },
    {
      "title": "Olahraga dan Mental",
      "content": "Hubungan antara aktivitas fisik dan kesehatan mental...",
      "route": "/artikel-olahraga",
      "pageBuilder": ArticlePageList(title: "Olahraga dan Mental"),
    },
  ];

  void _navigateToArticle(BuildContext context, Map<String, dynamic> article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => article["pageBuilder"],
      ),
    );
  }

  Widget _buildArticleCard(BuildContext context, Map<String, dynamic> article) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      width: 404,
      height: 179,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () => _navigateToArticle(context, article),
        child: Row(
          children: [
            Container(
              width: 146,
              height: 179,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {},
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 15, top: 15, bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article["title"] ?? "Judul Artikel",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      article["content"] ?? "Lorem Ipsum...",
                      style: const TextStyle(fontSize: 14),
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
                        const Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 24,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: 276,
                            height: 34,
                            margin: const EdgeInsets.symmetric(horizontal: 18),
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.search, color: Colors.black),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: TextField(
                                      decoration: InputDecoration(
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
                        Container(
                          padding: const EdgeInsets.all(0.0),
                          child: const Icon(
                            size: 27,
                            Icons.notifications,
                            color: Colors.white,
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
                                horizontal: 15, vertical: 0),
                            width: 210,
                            height: 100,
                            child: const Text(
                              'Ayo kita Membaca !',
                              style: TextStyle(
                                  fontFamily: 'Coiny',
                                  fontSize: 30,
                                  color: AppColors.primaryBackground),
                            )),
                        const SizedBox(width: 4),
                        Image.asset(
                          AppImages.articleAppbar,
                          width: 160,
                          height: 126,
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
              color: AppColors.primaryBackground,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    const SizedBox(height: 5),
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
                    const SizedBox(height: 15),





























                    SizedBox (height: 35, 
                      child: Column(
                        children: [
                          const SizedBox(height: 0), // Menambahkan jarak atas
                          Expanded(
                            // Memastikan ListView menggunakan sisa ruang yang tersedia
                            child: ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                final List<String> labels = [
                                  'Kecemasan',
                                  'Terapi',
                                  'Depresi',
                                  'Mood'
                                ];
                                return Padding(
                                  padding:
                                      const EdgeInsets.only(right: 5, left: 5),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Aksi untuk tombol
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: const BorderSide(
                                            color: Colors.black),
                                      ),
                                      elevation: 0,
                                      minimumSize: const Size(110,
                                          38), // Mengatur lebar minimum tombol
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                    ),
                                    child: Text(
                                      labels[index],
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),


































                    Padding(
                      padding: const EdgeInsets.only(right: 120),
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Relevan untuk Anda   >',
                          style: TextStyle(
                              fontSize: 18,
                              color: AppColors.primary,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // List artikel menggunakan ListView.builder
                    ...articles
                        .map((article) => _buildArticleCard(context, article))
                        .toList(),
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
          // SizedBox(
          //   height: 120, // Mengatur tinggi container (40 + 100 jarak atas)
          //   child: Column(
          //     children: [
          //       const SizedBox(height: 80), // Menambahkan jarak atas
          //       Expanded(
          //         // Memastikan ListView menggunakan sisa ruang yang tersedia
          //         child: ListView.builder(
          //           padding: const EdgeInsets.symmetric(horizontal: 20),
          //           scrollDirection: Axis.horizontal,
          //           itemCount: 4,
          //           itemBuilder: (context, index) {
          //             final List<String> labels = [
          //               'Kecemasan',
          //               'Terapi',
          //               'Depresi',
          //               'Mood'
          //             ];
          //             return Padding(
          //               padding: const EdgeInsets.only(right: 5, left: 5),
          //               child: ElevatedButton(
          //                 onPressed: () {
          //                   // Aksi untuk tombol
          //                 },
          //                 style: ElevatedButton.styleFrom(
          //                   backgroundColor: Colors.white,
          //                   shape: RoundedRectangleBorder(
          //                     borderRadius: BorderRadius.circular(10),
          //                     side: const BorderSide(color: Colors.black),
          //                   ),
          //                   elevation: 0,
          //                   minimumSize: const Size(
          //                       110, 38), // Mengatur lebar minimum tombol
          //                   padding: const EdgeInsets.symmetric(
          //                       horizontal: 16, vertical: 8),
          //                 ),
          //                 child: Text(
          //                   labels[index],
          //                   style: const TextStyle(
          //                     color: Colors.black,
          //                     fontSize: 13,
          //                   ),
          //                 ),
          //               ),
          //             );
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // ),