import 'package:flutter/material.dart';
import 'profile_card.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String nimMahasiswa = "20240801070";
    const String namaMahasiswa = "Kevin";
    const String hobiMahasiswa = "Game";

    // Formula Skor Aktivitas: 70 + 50 = 120
    int lastTwoDigits = int.parse(nimMahasiswa.substring(nimMahasiswa.length - 2));
    int calculatedScore = lastTwoDigits + 50;

    // Digit Terakhir NIM = 0 (Genap) -> Colors.amber[100]
    int lastDigit = int.parse(nimMahasiswa[nimMahasiswa.length - 1]);

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

// HomePage Tetap Berbentuk StatelessWidget Sesuai Ketentuan Modul
class HomePage extends StatelessWidget {
  final String nama;
  final String nim;
  final String hobi;
  final int skor;

  HomePage({
    Key? key,
    required this.nama,
    required this.nim,
    required this.hobi,
    required this.skor,
  }) : super(key: key);

  // State Pengontrol Visibilitas Kartu
  final ValueNotifier<bool> _isCardVisible = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // SizedBox membungkus layar agar memiliki lebar penuh (double.infinity)
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            // Meratakan secara vertikal (jarak seimbang atas, tengah, bawah)
            mainAxisAlignment: MainAxisAlignment.center,
            // Meratakan seluruh anak widget tepat di tengah secara horizontal
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Area Tampilan Kartu Profil
              ValueListenableBuilder<bool>(
                valueListenable: _isCardVisible,
                builder: (context, isVisible, child) {
                  return AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: isVisible ? 1.0 : 0.0,
                    child: Visibility(
                      visible: isVisible,
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      child: ProfileCard(
                        nama: nama,
                        nim: nim,
                        hobi: hobi,
                        skorAktivitas: skor,
                      ),
                    ),
                  );
                },
              ),

              // Tombol Interaktif di Bagian Bawah
              ValueListenableBuilder<bool>(
                valueListenable: _isCardVisible,
                builder: (context, isVisible, child) {
                  return ElevatedButton.icon(
                    onPressed: () {
                      // Mengubah status visibilitas kartu saat tombol ditekan
                      _isCardVisible.value = !_isCardVisible.value;
                    },
                    icon: Icon(
                      isVisible ? Icons.visibility_off : Icons.visibility,
                    ),
                    label: Text(
                      isVisible ? "Sembunyikan Profil" : "Tampilkan Profil",
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
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}