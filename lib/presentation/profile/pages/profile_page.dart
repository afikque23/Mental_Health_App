import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mental_health_app/core/configs/assets/app_vectors.dart';
import 'package:mental_health_app/core/configs/theme/app_colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _notificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: AppColors.primaryBackground,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(AppVectors.avatarProfile)
              ),
              const SizedBox(height: 20),
              const Text(
                'Lorem Ipsum',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'iniemial@gmail.com',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              // Notifikasi
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
                  width: 345,
                  height: 65,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: AppColors.lineColor, width: 2)
                    ),
                    color: Colors.white,
                    child: Row(
                      children: [
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.notifications,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "Notifikas",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "inter",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Transform.scale(
                          scale: 0.7,
                          child: Switch(
                            value: _notificationsEnabled,
                            onChanged: (newValue) {
                              setState(() {
                                _notificationsEnabled = newValue;
                              });
                              if (kDebugMode) {
                                print('Switch toggled: $newValue');
                              }
                            },
                            activeColor: Colors.white,
                            activeTrackColor: AppColors.primary,
                            inactiveTrackColor: const Color(0xff797C7B),
                            inactiveThumbColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: 340,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {

                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)) ,
                    side: const BorderSide(color: AppColors.lineColor, width: 2 ),
                    overlayColor: Colors.black
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Ganti Password',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "inter",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: 340,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)) ,
                    side: const BorderSide(color: AppColors.lineColor, width: 2 ),
                    overlayColor: Colors.black
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Colors.black,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Favorite',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "inter",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: 340,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)) ,
                    side: const BorderSide(color: AppColors.lineColor, width: 2 ),
                    overlayColor: Colors.black
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.black,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Keluar',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "inter",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: 340,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)) ,
                    side: const BorderSide(color: AppColors.lineColor, width: 2 ),
                    overlayColor: Colors.black
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.black,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Hapus Akun',
                        style: TextStyle(fontSize: 18, fontFamily: "inter"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
