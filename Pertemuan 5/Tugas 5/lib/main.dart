import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// Gunakan konfigurasi Firebase dari praktikum sebelumnya.
// File ini dihasilkan oleh `flutterfire configure`.
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pencatatan Stok Barang',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const StokBarangPage(),
    );
  }
}

class StokBarangPage extends StatefulWidget {
  const StokBarangPage({super.key});

  @override
  State<StokBarangPage> createState() => _StokBarangPageState();
}

class _StokBarangPageState extends State<StokBarangPage> {
  // Ketentuan khusus mahasiswa
  static const String _inisialNama = 'K'; // inisial nama depan: Kevin
  static const String _duaAngkaNim = '70'; // dua angka terakhir NIM
  static const int _minDigitKode = 6; // kode barang minimal 6 angka

  final _formKey = GlobalKey<FormState>();

  final _namaController = TextEditingController();
  final _tglMasukController = TextEditingController();
  final _tglKeluarController = TextEditingController();
  final _kodeController = TextEditingController();
  final _stokController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _namaController.dispose();
    _tglMasukController.dispose();
    _tglKeluarController.dispose();
    _kodeController.dispose();
    _stokController.dispose();
    super.dispose();
  }

  // ---------- Validator ----------
  String? _wajibDiisi(String? value, String label) {
    if (value == null || value.trim().isEmpty) {
      return '$label wajib diisi';
    }
    return null;
  }

  String? _validasiNama(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nama Barang wajib diisi';
    }
    if (!value.trim().toUpperCase().startsWith(_inisialNama)) {
      return 'Nama Barang harus diawali inisial nama depan ($_inisialNama)';
    }
    return null;
  }

  String? _validasiKode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Kode Barang wajib diisi';
    }
    if (int.tryParse(value.trim()) == null) {
      return 'Kode Barang harus berupa bilangan bulat';
    }
    if (value.trim().length < _minDigitKode) {
      return 'Kode Barang minimal $_minDigitKode angka';
    }
    if (!value.trim().endsWith(_duaAngkaNim)) {
      return 'Kode Barang harus diakhiri $_duaAngkaNim (dua angka terakhir NIM)';
    }
    return null;
  }

  String? _validasiStok(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Jumlah Stok wajib diisi';
    }
    final angka = int.tryParse(value.trim());
    if (angka == null) {
      return 'Jumlah Stok harus berupa bilangan bulat';
    }
    if (angka < 0) {
      return 'Jumlah Stok tidak boleh negatif';
    }
    return null;
  }

  // ---------- Simpan ke Firestore ----------
  Future<void> _simpanBarang() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Konversi String -> int sebelum dikirim ke Firestore
      final int kodeBarang = int.parse(_kodeController.text.trim());
      final int jumlahStok = int.parse(_stokController.text.trim());

      await FirebaseFirestore.instance.collection('stok_barang').add({
        'nama_barang': _namaController.text.trim(),
        'tanggal_masuk': _tglMasukController.text.trim(),
        'tanggal_keluar': _tglKeluarController.text.trim(),
        'kode_barang': kodeBarang, // Number
        'jumlah_stok': jumlahStok, // Number
        'waktu': FieldValue.serverTimestamp(), // Timestamp dari server
      });

      if (!mounted) return;

      // Kosongkan seluruh field
      _formKey.currentState!.reset();
      _namaController.clear();
      _tglMasukController.clear();
      _tglKeluarController.clear();
      _kodeController.clear();
      _stokController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data barang berhasil disimpan'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menyimpan data: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pencatatan Stok Barang'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Barang',
                  hintText: 'diawali inisial nama depan, contoh: Kopi Susu',
                  border: OutlineInputBorder(),
                ),
                validator: _validasiNama,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _tglMasukController,
                decoration: const InputDecoration(
                  labelText: 'Tanggal Masuk Barang',
                  hintText: 'contoh: 2026-10-16',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => _wajibDiisi(v, 'Tanggal Masuk Barang'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _tglKeluarController,
                decoration: const InputDecoration(
                  labelText: 'Tanggal Keluar Barang',
                  hintText: 'contoh: 2026-10-20',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => _wajibDiisi(v, 'Tanggal Keluar Barang'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _kodeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Kode Barang',
                  hintText: 'min. 6 angka, berakhiran 70, contoh: 123470',
                  border: OutlineInputBorder(),
                ),
                validator: _validasiKode,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _stokController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Jumlah Stok',
                  border: OutlineInputBorder(),
                ),
                validator: _validasiStok,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _simpanBarang,
                  child: _isLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Simpan Barang'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}