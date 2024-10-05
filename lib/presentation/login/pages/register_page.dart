import 'package:flutter/material.dart';
import 'package:mental_health_app/core/configs/theme/app_colors.dart';
import 'package:mental_health_app/presentation/login/pages/login_page.dart';
import 'package:intl/intl.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? _selectedGender;
  @override
  void initState(){
    super.initState();
    _selectedGender = 'Laki-laki';
  }
  final _dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30),
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
              const SizedBox(height: 30),
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
              const SizedBox(height: 15),
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
              const SizedBox(height: 15),
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
              // const SizedBox(height: 15),
              // const Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              //   child: Text(
              //     "Konfirmasi Password",
              //     style: TextStyle(
              //         fontFamily: 'Poppins',
              //         fontWeight: FontWeight.w500,
              //         fontSize: 18),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 10),
              //   child: TextField(
              //     obscureText: true,
              //     decoration: InputDecoration(
              //       labelText: 'Konfirmasi Password',
              //       contentPadding: const EdgeInsets.symmetric(horizontal: 25),
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(35),
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Text(
                  "Jenis Kelamin",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: "Pilih Jenis Kelamin",
                    icon: Icon(Icons.person),
                  ),
                  value: _selectedGender,
                  items: <String>['Laki-laki', 'Perempuan'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedGender = newValue;
                    });
                  },
                ),
              ),
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Text(
                  "Tanggal Lahir",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: _dateController,
                  decoration: const InputDecoration(
                    labelText: "Select Date",
                    hintText: "yyyy-MM-dd",
                    icon: Icon(Icons.calendar_today),
                  ),
                  readOnly:
                      true, // Agar TextField tidak bisa di-edit secara manual
                  onTap: () async {
                    await _selectDate(
                        context); // Memanggil fungsi untuk memilih tanggal
                  },
                ),
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 15),
              // Center(
              //   child: TextButton(
              //     onPressed: () {},
              //     child: const Text(
              //       'Lupa password?',
              //       style: TextStyle(
              //           color: AppColors.lineColor,
              //           fontSize: 16,
              //           fontWeight: FontWeight.w500,
              //           fontFamily: 'Poppins'),
              //     ),
              //   ),
              // ),
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
                            builder: (context) => const LoginPage()),
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }
}
