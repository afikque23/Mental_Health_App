import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mental_health_app/presentation/auth/pages/login_page.dart';
import 'package:mental_health_app/presentation/profile/pages/edit_profile_page.dart';
import 'package:mental_health_app/presentation/profile/pages/favorite.dart';
import 'package:mental_health_app/services/api_service.dart';
import 'package:mental_health_app/core/configs/theme/app_colors.dart';
import 'package:mental_health_app/core/configs/assets/app_vectors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ApiService _apiService = ApiService();
  String _userName = '';
  String _userEmail = '';
  bool _notificationsEnabled = false;
  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

    Future<void> _loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('profile_image');
    if (imagePath != null) {
      setState(() {
        _image = File(imagePath);
      });
    }
  }

    Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('profile_image', pickedFile.path);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchUserProfile(); // Memanggil API fetchUserProfile di didChangeDependencies
  }

  Future<void> fetchUserProfile() async {
    try {
      final result = await _apiService.getProfile();

      if (result['status'] == 'success') {
        setState(() {
          _userName = result['user']['nama'];
          _userEmail = result['user']['email'];
        });
      } else {
        _showMessage(result['message'] ?? 'Error loading profile');
      }
    } catch (e) {
      _showMessage('Failed to fetch user profile: $e');
    }
  }

  Future<void> _logout() async {
    try {
      final result = await _apiService.logout();
      if (result['status_code'] == 200) {
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        _showMessage(result['message'] ?? 'Failed to logout');
      }
    } catch (e) {
      _showMessage('Logout error: $e');
    }
  }

  Future<void> _confirmLogout() async {
    final shouldLogout = await _showConfirmationDialog(
      "Keluar",
      "Apakah Anda yakin ingin keluar?",
    );
    if (shouldLogout) {
      _logout();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  Future<void> _deleteAccount() async {
    try {
      final result = await _apiService.deleteAccount();
      if (result['status_code'] == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        _showMessage(result['message'] ?? 'Failed to delete account');
      }
    } catch (e) {
      _showMessage('Deletion error: $e');
    }
  }

  Future<void> _confirmDeleteAccount() async {
    final shouldDelete = await _showConfirmationDialog(
      "Hapus Akun",
      "Apakah Anda yakin ingin menghapus akun Anda? Tindakan ini tidak dapat dibatalkan.",
    );
    if (shouldDelete) {
      _deleteAccount();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  Future<bool> _showConfirmationDialog(String title, String content) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("Tidak"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("Ya"),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _showMessage(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: AppColors.primaryBackground,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child: _image == null
                        ? const Icon(Icons.person, size: 50)
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: -10,
                    child: ElevatedButton(
                      onPressed: _pickImage,
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(10),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                _userName.isNotEmpty ? _userName : 'Loading...',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                _userEmail.isNotEmpty ? _userEmail : 'Loading...',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              _buildSwitchCard("Notifikasi", _notificationsEnabled, (newValue) {
                setState(() {
                  _notificationsEnabled = newValue;
                });
              }),
              const SizedBox(height: 15),
              SizedBox(
                width: 340,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditProfile()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      side: const BorderSide(
                          color: AppColors.lineColor, width: 2),
                      overlayColor: Colors.black),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        AppVectors.editProfile,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Edit Profile',
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
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FavoritePage()));
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      side: const BorderSide(
                          color: AppColors.lineColor, width: 2),
                      overlayColor: Colors.black),
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
              const SizedBox(height: 15),
              _buildButton(
                icon: Icons.exit_to_app,
                text: "Keluar",
                onPressed: _confirmLogout,
              ),
              const SizedBox(height: 15),
              _buildButton(
                icon: Icons.delete,
                text: "Hapus Akun",
                onPressed: _confirmDeleteAccount,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchCard(
      String title, bool value, ValueChanged<bool> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        width: 345,
        height: 65,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: AppColors.lineColor, width: 2),
          ),
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const Icon(Icons.notifications, color: Colors.black),
                      const SizedBox(width: 8),
                      Text(
                        title,
                        style: const TextStyle(
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
                  value: value,
                  onChanged: onChanged,
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
    );
  }

  Widget _buildButton({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 340,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          side: const BorderSide(color: AppColors.lineColor, width: 2),
          overlayColor: Colors.black,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.black),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(fontSize: 18, fontFamily: "inter"),
            ),
          ],
        ),
      ),
    );
  }
}

// STYLE POPUP KELUAR DAN HAPUS AKUN
// VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV
// void _showSimpleDialogKeluar(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (context) {
//       return SimpleDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         children: <Widget>[
//           const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
//             child: Center(
//               child: Text(
//                 "Apa kamu yakin buat keluar? :(",
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontFamily: 'Inter',
//                   fontWeight: FontWeight.w500,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 Expanded(
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.primary, // Warna tombol Batal
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                     ),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: const Padding(
//                       padding: EdgeInsets.symmetric(vertical: 15),
//                       child: Text(
//                         "Batal",
//                         style: TextStyle(
//                             fontFamily: 'Inter',
//                             fontWeight: FontWeight.w500,
//                             color: Colors.black,
//                             fontSize: 22),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xffd9d9d9), // Warna tombol Ya
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                     ),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: const Padding(
//                       padding: EdgeInsets.symmetric(vertical: 15),
//                       child: Text(
//                         "Ya",
//                         style: TextStyle(
//                             fontFamily: 'Inter',
//                             fontWeight: FontWeight.w500,
//                             color: Colors.black,
//                             fontSize: 22),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }
// void _showSimpleDialogHapusAkun(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (context) {
//       return SimpleDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         children: <Widget>[
//           const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
//             child: Center(
//               child: Text(
//                 "Apa kamu yakin ingin hapus akun? :(",
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontFamily: 'Inter',
//                   fontWeight: FontWeight.w500,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 Expanded(
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.primary, // Warna tombol Batal
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                     ),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: const Padding(
//                       padding: EdgeInsets.symmetric(vertical: 15),
//                       child: Text(
//                         "Batal",
//                         style: TextStyle(
//                             fontFamily: 'Inter',
//                             fontWeight: FontWeight.w500,
//                             color: Colors.black,
//                             fontSize: 22),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xffd9d9d9), // Warna tombol Ya
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                     ),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: const Padding(
//                       padding: EdgeInsets.symmetric(vertical: 15),
//                       child: Text(
//                         "Ya",
//                         style: TextStyle(
//                             fontFamily: 'Inter',
//                             fontWeight: FontWeight.w500,
//                             color: Colors.black,
//                             fontSize: 22),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }
