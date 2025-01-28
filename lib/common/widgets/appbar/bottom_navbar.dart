// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mental_health_app/core/configs/assets/app_vectors.dart';
import 'package:mental_health_app/core/configs/theme/app_colors.dart';
import 'package:mental_health_app/presentation/artikel/pages/article_page.dart';
import 'package:mental_health_app/presentation/home/pages/home_page.dart';
import 'package:mental_health_app/presentation/profile/pages/profile_page.dart';
import 'package:mental_health_app/presentation/tracker/pages/tracker_page.dart';

// ignore: use_key_in_widget_constructors
class BottomNavbar extends StatefulWidget {
  final int
      currentIndex; // Menambahkan parameter untuk menerima index yang diberikan

  const BottomNavbar({Key? key, this.currentIndex = 0}) : super(key: key);

  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  late int _bottomNavCurrentIndex;

  @override
  void initState() {
    super.initState();
    _bottomNavCurrentIndex = widget.currentIndex; // Set index dari parameter
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(),
      bottomNavigationBar: _getBottomNavigationBar(),
    );
  }

  Widget _getBody() {
    const BorderRadius.only(
        topLeft: Radius.circular(20), topRight: Radius.circular(20));
    switch (_bottomNavCurrentIndex) {
      case 0:
        return const HomePage();
      case 1:
        return ArticlePage();
      case 2:
        return const TrackerPage();
      case 3:
        return const ProfilePage();
      default:
        return const HomePage();
    }
  }

  Widget _getBottomNavigationBar() {
    final shadowColor = Colors.black.withOpacity(0.2);

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: BottomNavigationBar(
          backgroundColor: AppColors.primaryBackground,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.grey,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _bottomNavCurrentIndex = index;
            });
          },
          currentIndex: _bottomNavCurrentIndex,
          unselectedLabelStyle: const TextStyle(
              fontSize: 12, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
          selectedLabelStyle: const TextStyle(
              fontSize: 12, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
          items: [
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: SvgPicture.asset(
                  AppVectors.home,
                  color: AppColors.primary,
                ),
              ),
              icon: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: SvgPicture.asset(
                  AppVectors.home,
                  color: AppColors.grey,
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: SvgPicture.asset(
                  AppVectors.article,
                  color: AppColors.primary,
                ),
              ),
              icon: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: SvgPicture.asset(
                  AppVectors.article,
                  color: AppColors.grey,
                ),
              ),
              label: 'Artikel',
            ),
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: SvgPicture.asset(
                  AppVectors.tracker,
                  color: AppColors.primary,
                ),
              ),
              icon: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: SvgPicture.asset(
                  AppVectors.tracker,
                  color: AppColors.grey,
                ),
              ),
              label: 'Tracker',
            ),
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: SvgPicture.asset(
                  AppVectors.profile,
                  color: AppColors.primary,
                ),
              ),
              icon: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: SvgPicture.asset(
                  AppVectors.profile,
                  color: AppColors.grey,
                ),
              ),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
