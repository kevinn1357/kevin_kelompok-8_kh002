import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'widgets/app_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Hasil perhitungan d = 0
    const double paddingCard = 16.0;
    const double roundedCard = 8.0;
    const double tinggiTombol = 40.0;
    const double roundedTombol = 4.0;
    const double ukuranAvatar = 40.0;
    const double jarakNamaNim = 8.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Profile Card'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(roundedCard),
            ),
            child: Padding(
              padding: const EdgeInsets.all(paddingCard),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                    radius: ukuranAvatar / 2, // Radius = 20 (Diameter 40px)
                    child: Icon(Icons.person),
                  ),
                  const SizedBox(height: 12),
                  const Text('Kevin'),
                  const SizedBox(height: jarakNamaNim),
                  const Text('NIM: 20240801070'),
                  const SizedBox(height: 8),
                  const Text('Teknik Informatika'),
                  const SizedBox(height: 12),
                  const Text(
                    'Mahasiswa Teknik Informatika Universitas Esa Unggul',
                  ),
                  const SizedBox(height: 16),
                  const AppButton(
                    label: 'Kunjungi GitHub Saya',
                    icon: Icons.code,
                    url: 'https://github.com/kevinn1357',
                    height: tinggiTombol,
                    borderRadius: roundedTombol,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}