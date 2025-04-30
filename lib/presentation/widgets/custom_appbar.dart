import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:pulse_task/configuration/theme/app_theme.dart';
import 'package:pulse_task/presentation/providers/profile_provider/profile_provider.dart';
import 'package:pulse_task/presentation/providers/theme_provider/ThemeProvider.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String greeting;
  final String name;

  const CustomAppbar({super.key, required this.greeting, required this.name});

  @override
  Size get preferredSize => const Size.fromHeight(80.0);

  @override
  Widget build(BuildContext context) {
    final profileImage = context.watch<ProfileProvider>().profileImage;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9.0),
        child: Row(
          children: [
            IconButton(
              icon: CircleAvatar(
                radius: 27,
                backgroundImage:
                    profileImage != null
                        ? FileImage(profileImage) as ImageProvider
                        : const NetworkImage(
                          'https://avatars.githubusercontent.com/u/201642198?s=96&v=4',
                        ),
              ),
              onPressed: () {
                context.goNamed('profile');
              },
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greeting,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF9E9B9B),
                  ),
                ),
              ],
            ),
            const Spacer(),

            ColorThemeDropdown(),
            const SizedBox(width: 8), // Add spacing between the icons
          ],
        ),
      ),
    );
  }
}

class ColorThemeDropdown extends StatelessWidget {
  const ColorThemeDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<Themeprovider>(context, listen: false);

    return PopupMenuButton<int>(
      icon: Icon(Icons.color_lens, color: Theme.of(context).primaryColor),
      itemBuilder: (BuildContext context) {
        return List.generate(AppTheme.colors.length, (index) {
          return PopupMenuItem<int>(
            value: index,
            child: Row(
              children: [
                Icon(Icons.color_lens, color: AppTheme.colors[index]),
                SizedBox(width: 12),
                Text(AppTheme.getColorName(AppTheme.colors[index])),
              ],
            ),
          );
        });
      },
      onSelected: (int index) {
        themeProvider.setColorIndex(index);
      },
      offset: Offset(0, 50), // Ajusta la posición del menú
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
