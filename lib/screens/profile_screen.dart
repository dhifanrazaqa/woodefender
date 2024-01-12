import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:woodefender/screens/auth/login_screen.dart';
import 'package:woodefender/services/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _selectedFile;
  final picker = ImagePicker();

  Future<void> _pickFile() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(left: 12.0, right: 12.0 , top: height * 0.2),
            child: Column(
              children: [
                FutureBuilder(
                  future: AuthService().getUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.red,),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      return Container(
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                snapshot.data!.imageUrl! != '' ?
                                CircleAvatar(
                                  backgroundColor: Colors.grey[200],
                                  radius: 60,
                                  backgroundImage: 
                                  NetworkImage(snapshot.data!.imageUrl!),
                                )
                                :
                                CircleAvatar(
                                  backgroundColor: Colors.grey[200],
                                  radius: 60,
                                  backgroundImage: 
                                  AssetImage('assets/images/user.png'),
                                ),
                                IconButton.filled(
                                  onPressed: () async {
                                    await _pickFile();
                                    await AuthService().addUserImage(_selectedFile);
                                    setState(() {
                                      
                                    });
                                  },
                                  icon: Icon(Icons.edit)
                                )
                              ],
                            ),
                            const SizedBox(height: 20,),
                            Text(
                              snapshot.data!.username!,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800
                              ),
                            ),
                            const SizedBox(height: 5,),
                            Text(snapshot.data!.email!),
                          ],
                        )
                      );
                    }
                  }
                ),
                const SizedBox(height: 15,),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    overlayColor: MaterialStatePropertyAll(Colors.white),
                    fixedSize: MaterialStatePropertyAll(Size(width, 40)),
                    backgroundColor: MaterialStatePropertyAll(Colors.red),
                  ),
                  onPressed: () {
                    showConfirmationDialog(context);
                  },
                  child: const Text(
                    'Keluar',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Oops..',
            style: TextStyle(
              fontWeight: FontWeight.w700
            ),
          ),
          content: Text('Apakah kamu yakin ingin keluar?'),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStatePropertyAll(Colors.white),
                overlayColor: MaterialStatePropertyAll(Colors.grey[200])
              ),
              onPressed: () {
                // Tombol Cancel
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.black
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                overlayColor: MaterialStatePropertyAll(Colors.grey[200]),
                fixedSize: MaterialStatePropertyAll(Size(100, 40)),
                backgroundColor: MaterialStatePropertyAll(Colors.black),
              ),
              onPressed: () async {
                await AuthService().signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              child: const Text(
                'Keluar',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}