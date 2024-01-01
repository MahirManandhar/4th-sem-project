import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _themeData;

  ThemeNotifier(this._themeData);

  ThemeData getTheme() => _themeData;

  setTheme(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }
}

class Settings extends StatefulWidget {
  final String userId;
  final String email;
  const Settings({super.key, required this.userId, required this.email});

  // const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isDarkMode = false;
  String newPassword = '';

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // children: [
          children: [
            ListTile(
              title: const Text('Change Appearance'),
              subtitle: const Text('Toggle light/dark mode'),
              trailing: Switch(
                value: isDarkMode,
                onChanged: (value) {
                  setState(() {
                    isDarkMode = value;
                    _updateThemeMode(themeNotifier);
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Change Password'),
              onTap: () => {
                Navigator.pop(context),
                // Navigator.pushNamed(context, '/changepasssword'),
                Navigator.pushNamed(
                  context,
                  '/changepasssword',
                  arguments: {'userId': widget.userId, 'email': widget.email},
                )
              },
            ),
          ],
        ),
      ),
    );
  }

  void _updateThemeMode(ThemeNotifier themeNotifier) {
    final Brightness newBrightness =
        isDarkMode ? Brightness.dark : Brightness.light;
    final ThemeData newTheme = ThemeData(brightness: newBrightness);

    themeNotifier.setTheme(newTheme);
  }

//   void _changePassword() {
//     print('Password changed to: $newPassword');
//   }
}
