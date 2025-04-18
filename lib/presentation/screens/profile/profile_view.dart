import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Perfil', textAlign: TextAlign.center),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(
                'https://avatars.githubusercontent.com/u/201642198?s=96&v=4',
              ),
            ),
            SizedBox(height: 32),
            ProfileOptions(),
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
    return Column(
      children: [
        Card(
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  Icon(Icons.person, color: Colors.blue),
                  SizedBox(width: 12),
                  Text('Cuenta', style: TextStyle(fontSize: 18)),
                  Spacer(),
              
                ],
              ),
            ),
          ),
        ),
        Card(
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  Icon(Icons.security, color: Colors.blue),
                  SizedBox(width: 12),
                  Text('seguridad', style: TextStyle(fontSize: 18)),
                  Spacer(),
                 
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
