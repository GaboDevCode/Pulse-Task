import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pulse_task/presentation/providers/profile_provider/profile_provider.dart';

import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      Provider.of<ProfileProvider>(
        context,
        listen: false,
      ).setProfileImage(File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileImage = context.watch<ProfileProvider>().profileImage;

    return Scaffold(
      backgroundColor: const Color(0xFF222121),
      appBar: AppBar(
        backgroundColor: const Color(0xFF222121),
        centerTitle: true,
        title: Text(
          'Perfil',
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: () => _pickImage(context),
              child: CircleAvatar(
                radius: 80,
                backgroundImage:
                    profileImage != null
                        ? FileImage(profileImage)
                        : const NetworkImage(
                              'https://avatars.githubusercontent.com/u/201642198?s=96&v=4',
                            )
                            as ImageProvider,
                child:
                    profileImage == null
                        ? Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        )
                        : null,
              ),
            ),
            const SizedBox(height: 32),
            const ProfileOptions(),
          ],
        ),
      ),
    );
  }
}

class ProfileOptions extends StatelessWidget {
  const ProfileOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTema = Theme.of(context).colorScheme.primary;
    return Column(
      children: [
        Card(
          color: colorTema,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  Icon(Icons.favorite, color: Colors.redAccent),
                  SizedBox(width: 12),
                  Text('Valoranos', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 8),

        Card(
          color: colorTema,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  Icon(Icons.message, color: Colors.blue),
                  SizedBox(width: 12),
                  Text(' Enviar sugerencia', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Card(
          color: colorTema,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  Icon(Icons.error_outline_rounded, color: Colors.red),
                  SizedBox(width: 12),
                  Text('Reportar un problema', style: TextStyle(fontSize: 18)),
                  Spacer(),
                ],
              ),
            ),
          ),
        ),

        Card(
          color: colorTema,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  Icon(Icons.group_add_sharp, color: Colors.blue),
                  SizedBox(width: 12),
                  Text('Invita a un amigo ', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
