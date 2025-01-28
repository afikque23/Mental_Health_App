import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mental_health_app/services/api_service.dart';
import 'package:mental_health_app/core/configs/theme/app_colors.dart';
import 'package:mental_health_app/presentation/auth/pages/login_page.dart';
import 'package:mental_health_app/services/firebase_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  DateTime? _selectedDate;
  String? _selectedGender;

  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName tidak boleh kosong';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Format email tidak valid';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nomor telepon tidak boleh kosong';
    }
    if (!RegExp(r'^\d{10,13}$').hasMatch(value)) {
      return 'Nomor telepon harus 10-13 digit';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (value.length < 8) {
      return 'Password minimal 8 karakter';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Konfirmasi password tidak boleh kosong';
    }
    if (value != _passwordController.text) {
      return 'Password tidak cocok';
    }
    return null;
  }

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
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
                _buildInputField(
                  "Nama Pengguna",
                  "Nama Lengkap",
                  controller: _namaController,
                  validator: (value) => _validateRequired(value, 'Nama'),
                ),
                _buildInputField(
                  "Email",
                  "contoh@gmail.com",
                  controller: _emailController,
                  validator: _validateEmail,
                ),
                _buildInputField(
                  "No. HP",
                  "Nomor Telepon",
                  controller: _phoneController,
                  validator: _validatePhone,
                ),
                _buildInputField(
                  "Password",
                  "Password",
                  isPassword: true,
                  controller: _passwordController,
                  validator: _validatePassword,
                ),
                _buildInputField(
                  "Konfirmasi Password",
                  "Konfirmasi Password",
                  isPassword: true,
                  controller: _confirmPasswordController,
                  validator: _validateConfirmPassword,
                ),
                _buildGenderDropdown(),
                _buildDatePicker(),
                const SizedBox(height: 16),
                _buildRegisterButton(),
                const SizedBox(height: 16),
                _buildLoginPrompt(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
    String label,
    String hintText, {
    bool isPassword = false,
    TextEditingController? controller,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            controller: controller,
            obscureText: isPassword,
            validator: validator,
            decoration: InputDecoration(
              labelText: hintText,
              contentPadding: const EdgeInsets.symmetric(horizontal: 25),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35),
              ),
              errorStyle: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildGenderDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Text(
            'Jenis Kelamin',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButtonFormField<String>(
            value: _selectedGender,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 25),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35),
              ),
            ),
            items: <String>['Laki-Laki', 'Perempuan']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            hint: const Text('Pilih Jenis Kelamin'),
            onChanged: (String? newValue) {
              setState(() {
                _selectedGender = newValue;
              });
            },
            validator: (value) {
              if (value == null) {
                return 'Silakan pilih jenis kelamin';
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Text(
            'Tanggal Lahir',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            readOnly: true,
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: _selectedDate ?? DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (picked != null && picked != _selectedDate) {
                setState(() {
                  _selectedDate = picked;
                });
              }
            },
            decoration: InputDecoration(
              labelText: _selectedDate != null
                  ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                  : 'Pilih Tanggal Lahir',
              contentPadding: const EdgeInsets.symmetric(horizontal: 25),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35),
              ),
            ),
            validator: (value) {
              if (_selectedDate == null) {
                return 'Silakan pilih tanggal lahir';
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildRegisterButton() {
    return ElevatedButton(
      onPressed: () async {
        if (!_formKey.currentState!.validate()) {
          return;
        }
        if (_selectedDate == null) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              const SnackBar(
                content: Text("Silakan pilih tanggal lahir"),
                backgroundColor: Colors.red,
              ),
            );
          return;
        }
        if (_selectedGender == null) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              const SnackBar(
                content: Text("Silakan pilih jenis kelamin"),
                backgroundColor: Colors.red,
              ),
            );
          return;
        }

        // Tampilkan loading dialog
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Dialog(
              backgroundColor: Colors.white,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 20),
                    const Text(
                      'Sedang mendaftarkan akun...',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );

        try {
          final firebaseApi = FirebaseApi();
          final fcmToken = await firebaseApi.getFCMToken();
          if (fcmToken == null) {
            // Tutup loading dialog
            Navigator.pop(context);

            ScaffoldMessenger.of(context)
              ..clearSnackBars()
              ..showSnackBar(
                const SnackBar(
                  content: Text("FCM Token tidak tersedia"),
                  backgroundColor: Colors.red,
                ),
              );
            return;
          }

          final response = await ApiService().register(
            nama: _namaController.text,
            email: _emailController.text,
            gender: _selectedGender!,
            hp: _phoneController.text,
            tanggal_lahir: _selectedDate!,
            password: _passwordController.text,
            passwordConfirmation: _confirmPasswordController.text,
            fcmToken: fcmToken,
          );

          // Tutup loading dialog
          Navigator.pop(context);

          if (response['message'] ==
              'Registrasi berhasil. Mohon verifikasi email Anda.') {
            ScaffoldMessenger.of(context)
              ..clearSnackBars()
              ..showSnackBar(
                SnackBar(
                  content: Text(
                    response["message"] ?? 'Gagal melakukan registrasi',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: "Poppins",
                    ),
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            await Future.delayed(const Duration(seconds: 1));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          } else if (response['message'] !=
              'Registrasi berhasil. Mohon verifikasi email Anda.') {
            ScaffoldMessenger.of(context)
              ..clearSnackBars()
              ..showSnackBar(
                SnackBar(
                  content: Text(
                    response["message"] ?? 'Gagal melakukan registrasi',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: "Poppins",
                    ),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
          }
        } catch (e) {
          // Tutup loading dialog
          Navigator.pop(context);

          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              SnackBar(
                content: Text('Error: ${e.toString()}'),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15),
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
      ),
      child: const Text(
        'Daftar',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }

  Widget _buildLoginPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Sudah punya akun? ',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
          child: const Text(
            'Masuk',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
