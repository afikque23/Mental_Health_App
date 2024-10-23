import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.person,
              size: 100,
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
            SizedBox(
              width: 410,
              height: 46,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                color: Colors.grey,
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
                        activeColor: Colors.grey,
                        activeTrackColor: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: 400,
              height: 38,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.grey,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
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
            const SizedBox(height: 10),
            SizedBox(
              width: 400,
              height: 38,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.grey,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
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
            const SizedBox(height: 10),
            SizedBox(
              width: 400,
              height: 38,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.grey,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
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
            const SizedBox(height: 10),
            SizedBox(
              width: 400,
              height: 38,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.grey,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
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
    );
  }
}
