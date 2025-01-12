import 'package:flutter/material.dart';
<<<<<<< HEAD
=======
import 'package:mental_health_app/presentation/auth/pages/login_page.dart';
import 'package:mental_health_app/services/api_service.dart';
>>>>>>> master

class GantiPasswordPage extends StatefulWidget {
  final Function(String, String, String) onSubmit;

  const GantiPasswordPage({
<<<<<<< HEAD
    Key? key,
    required this.onSubmit,
  }) : super(key: key);
=======
    super.key,
    required this.onSubmit,
  });
>>>>>>> master

  @override
  State<GantiPasswordPage> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<GantiPasswordPage> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureOldPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
<<<<<<< HEAD
=======
  bool _isLoading = false;
  final ApiService _apiService = ApiService();
>>>>>>> master

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

<<<<<<< HEAD
=======
  Future<void> _logout() async {
    try {
      final result = await _apiService.logout();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } catch (e) {
      _showMessage('Logout error: $e');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _handleSubmit() async {
    final oldPassword = _oldPasswordController.text;
    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Konfirmasi password tidak cocok.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final apiService = ApiService(); // Ganti dengan URL API Anda

    final response = await apiService.changePassword(
      oldPassword,
      newPassword,
    );

    setState(() {
      _isLoading = false;
    });

    if (response['success'] == true) {
      _logout();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'])),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(response['message'] ?? 'Gagal mengganti password.')),
      );
    }
  }

>>>>>>> master
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Ganti Password',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Password Lama',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _oldPasswordController,
              obscureText: _obscureOldPassword,
              decoration: InputDecoration(
                hintText: '••••••••',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
<<<<<<< HEAD
                    _obscureOldPassword ? Icons.visibility_off : Icons.visibility,
=======
                    _obscureOldPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
>>>>>>> master
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureOldPassword = !_obscureOldPassword;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Password Baru',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _newPasswordController,
              obscureText: _obscureNewPassword,
              decoration: InputDecoration(
                hintText: '••••••••',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
<<<<<<< HEAD
                    _obscureNewPassword ? Icons.visibility_off : Icons.visibility,
=======
                    _obscureNewPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
>>>>>>> master
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureNewPassword = !_obscureNewPassword;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Konfirmasi Password',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _confirmPasswordController,
              obscureText: _obscureConfirmPassword,
              decoration: InputDecoration(
                hintText: '••••••••',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
<<<<<<< HEAD
                    _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
=======
                    _obscureConfirmPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
>>>>>>> master
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
<<<<<<< HEAD
              child: TextButton(
                onPressed: () {
                  widget.onSubmit(
                    _oldPasswordController.text,
                    _newPasswordController.text,
                    _confirmPasswordController.text,
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF65B7AB),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Ganti Password',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
=======
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : TextButton(
                      onPressed: _handleSubmit,
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFF65B7AB),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Ganti Password',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
>>>>>>> master
            ),
          ],
        ),
      ),
    );
  }
}

// Helper function to show the dialog
void showChangePasswordDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return GantiPasswordPage(
<<<<<<< HEAD
        onSubmit: (oldPassword, newPassword, confirmPassword) {
          // Add password change logic here
          print('Old Password: $oldPassword');
          print('New Password: $newPassword');
          print('Confirm Password: $confirmPassword');
          
          // Close dialog after submission
          Navigator.of(context).pop();
        },
=======
        onSubmit: (oldPassword, newPassword, confirmPassword) {},
>>>>>>> master
      );
    },
  );
}
<<<<<<< HEAD

// Example usage:
// ElevatedButton(
//   onPressed: () => showChangePasswordDialog(context),
//   child: const Text('Change Password'),
// )
=======
>>>>>>> master
