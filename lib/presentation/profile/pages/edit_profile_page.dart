import 'package:flutter/material.dart';
import 'package:mental_health_app/core/configs/theme/app_colors.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          flexibleSpace: const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            
            children: [
              SizedBox(height: 100),
              Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(height: 10),
            ],
                    ),
          ),
          centerTitle: false,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildInputField("Nama Pengguna", ''),
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
                    contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildInputField("Jenis Kelamin", ""),
              _buildInputField("Tanggal Lahir", ""),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(2, 3),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                      onPressed: () {
                        _showSimpleDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Ganti Password",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "inter",
                                  color: Colors.black),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward,
                              size: 20,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      )),
                ),
              ),
              const Spacer(),
              _buildLoginPrompt(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String hintText,
      {bool isPassword = false}) {
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
          child: TextField(
            obscureText: isPassword,
            decoration: InputDecoration(
              labelText: hintText,
              contentPadding: const EdgeInsets.symmetric(horizontal: 25),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildLoginPrompt() {
    return const Row();
  }
}

void _showSimpleDialog(context) {
  showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Center(
                    
                    child: Expanded(
                      child: Text(
                        "Ganti Password",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
          const Divider(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Password Lama",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: TextField(
                    style: const TextStyle(
                        fontSize: 14.0, height: 1.0, color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 14.0, horizontal: 15.0),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Password Baru",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: TextField(
                    style: const TextStyle(
                        fontSize: 14.0, height: 1.0, color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 14.0, horizontal: 15.0),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Konfirmasi Password Baru",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: TextField(
                    style: const TextStyle(
                        fontSize: 14.0, height: 1.0, color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 14.0, horizontal: 15.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: MaterialButton(
              color: AppColors.primary,
              child: const Text(
                "Ganti Password",
                style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      color: Colors.white,),
                
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      );
    },
  );
}
