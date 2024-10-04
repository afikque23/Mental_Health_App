import 'package:flutter/material.dart';
import 'package:mental_health_app/core/configs/theme/app_colors.dart';
import 'package:mental_health_app/presentation/login/pages/login_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Daftar Akun',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              const SizedBox(height: 35),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Text(
                  "Nama Pengguna",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Nama Lengkap',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Text(
                  "Email",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'contoh@gmail.com',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                child: Text(
                  "Password",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                child: Text(
                  "Konfirmasi Password",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Konfirmasi Password',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                  child: const Text(
                    'Buat Akun',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Lupa password?',
                    style: TextStyle(
                        color: AppColors.lineColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins'),
                  ),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sudah mempunyai akun?',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (
                            context) => const LoginPage(
                          )
                        ),
                      );
                    },
                    child: const Text(
                      'Masuk',
                      style: TextStyle(
                          color: AppColors.lineColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}