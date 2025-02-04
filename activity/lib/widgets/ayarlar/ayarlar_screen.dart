import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:activity/providers/theme_provider.dart';
import 'package:activity/widgets/ayarlar/ayarlar_widget.dart';
import 'package:activity/widgets/title_text.dart';

class Ayarlar extends StatefulWidget {
  const Ayarlar({super.key});

  @override
  State<Ayarlar> createState() => _AyarlarState();
}

class _AyarlarState extends State<Ayarlar> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: TitleTextWidget(label: "Ayarlar"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Genel Ayarlar',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(height: 16),
            AyarlarWidget(image: "images/konum1.png", baslik: "Konum"),
            AyarlarWidget(image: "images/galeri.png", baslik: "Galeri"),
            AyarlarWidget(image: "images/bildirim1.jpg", baslik: "Bildirimler"),
            SizedBox(height: 24),
            Text('Tema',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(height: 16),
            SwitchListTile(
              title: Text(
                themeProvider.getIsDarkTheme ? "Dark Mode" : "Light Mode",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              value: themeProvider.getIsDarkTheme,
              onChanged: (value) {
                themeProvider.setDarkTheme(themeValue: value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
