import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String nama;
  final String nim;
  final String hobi;
  final int skorAktivitas;

  const ProfileCard({
    Key? key,
    required this.nama,
    required this.nim,
    required this.hobi,
    required this.skorAktivitas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ekstraksi digit NIM untuk kalkulasi formula dinamis
    String cleanNim = nim.replaceAll(RegExp(r'\D'), '');
    int lastDigit = cleanNim.isNotEmpty ? int.parse(cleanNim[cleanNim.length - 1]) : 0;
    int secondLastDigit = cleanNim.length >= 2 ? int.parse(cleanNim[cleanNim.length - 2]) : 0;

    // Kalkulasi formula berdasarkan NIM: 20240801070
    double cardWidth = 320.0 + (secondLastDigit * 5); // 355.0
    double borderRadiusVal = 12.0 + (lastDigit * 1.5); // 12.0
    double logoSize = 60.0 + (lastDigit * 2);          // 60.0
    double spacingWidth = 15.0 + lastDigit;           // 15.0

    return Container(
      width: cardWidth,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadiusVal),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Kartu (Horizontal - Row)
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 1.5),
                  borderRadius: BorderRadius.circular(borderRadiusVal),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadiusVal),
                  child: FlutterLogo(size: logoSize),
                ),
              ),
              SizedBox(width: spacingWidth),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Kartu Praktikan",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      nama,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Pemisah Horisontal
          const Divider(thickness: 1.5, height: 24),

          // Detail Identitas (Vertikal - Column)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "NIM: $nim",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Hobi: $hobi",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Skor Aktivitas: $skorAktivitas",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}