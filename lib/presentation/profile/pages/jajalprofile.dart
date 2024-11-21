import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Jajalprofile extends StatefulWidget {
  const Jajalprofile({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<Jajalprofile> {
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Profile", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _image != null ? FileImage(_image!) : null,
                backgroundColor: Colors.grey[300],
                child: _image == null
                    ? const Icon(Icons.person, size: 50, color: Colors.white)
                    : null,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Lorem Ipsum',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'iniemail@gmail.com',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 20),
            buildMenuItem(Icons.notifications, "Notifikasi", trailing: Switch(value: true, onChanged: (value) {})),
            buildMenuItem(Icons.edit, "Edit Profile"),
            buildMenuItem(Icons.favorite, "Favorite"),
            buildMenuItem(Icons.logout, "Keluar"),
            buildMenuItem(Icons.delete, "Hapus Akun"),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(IconData icon, String text, {Widget? trailing}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.teal),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.black),
          title: Text(text),
          trailing: trailing ?? const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 16),
        ),
      ),
    );
  }
}
