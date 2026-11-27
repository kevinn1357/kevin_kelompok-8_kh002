import 'package:flutter/material.dart';

import 'profile_card.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const String nimMahasiswa = '20240801070';
    const String namaMahasiswa = 'Kevin';
    const String hobiMahasiswa = 'Game';

    // Formula Skor Aktivitas: 70 + 50 = 120
    final int lastTwoDigits =
        int.parse(nimMahasiswa.substring(nimMahasiswa.length - 2));
    final int calculatedScore = lastTwoDigits + 50;

    // Digit Terakhir NIM = 0 (Genap) -> Colors.amber[100]
    final int lastDigit = int.parse(nimMahasiswa[nimMahasiswa.length - 1]);

    return MaterialApp(
      title: 'Tugas Layout Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: (lastDigit % 2 == 0)
            ? Colors.amber[100]
            : Colors.tealAccent[100],
      ),
      home: HomePage(
        nama: namaMahasiswa,
        nim: nimMahasiswa,
        hobi: hobiMahasiswa,
        skor: calculatedScore,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final String nama;
  final String nim;
  final String hobi;
  final int skor;

  HomePage({
    super.key,
    required this.nama,
    required this.nim,
    required this.hobi,
    required this.skor,
  });

  // State Pengontrol Visibilitas Kartu
  final ValueNotifier<bool> _isCardVisible = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: ValueListenableBuilder<bool>(
            valueListenable: _isCardVisible,
            builder: (context, isVisible, _) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (isVisible)
                    ProfileCard(
                      nama: nama,
                      nim: nim,
                      hobi: hobi,
                      skorAktivitas: skor,
                    ),
                  ElevatedButton.icon(
                    onPressed: () {
                      _isCardVisible.value = !_isCardVisible.value;
                    },
                    icon: Icon(
                      isVisible ? Icons.visibility_off : Icons.visibility,
                    ),
                    label: Text(
                      isVisible ? 'Sembunyikan Profil' : 'Tampilkan Profil',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber[800],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 12.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 4,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
