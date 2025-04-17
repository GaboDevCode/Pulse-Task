import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String greeting;
  final String name;

  const CustomAppbar({super.key, required this.greeting, required this.name});

  @override
  Size get preferredSize => Size.fromHeight(80.0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9.0),
        child: Row(
          children: [
            IconButton(
              icon: CircleAvatar(
                radius: 27,
                backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/201642198?s=96&v=4',
                ),
              ),
              onPressed: () {},
            ),
            SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greeting,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  name,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ],
            ),
            Spacer(),
            IconButton(icon: Icon(Icons.search), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
