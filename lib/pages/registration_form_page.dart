import 'package:flutter/material.dart';
import '_form.dart'; // Import file yang berisi semua widget form
import 'dashboard_page.dart'; // Import halaman Dashboard

class RegistrationFormPage extends StatefulWidget {
  final String
  userRole; // Menerima peran pengguna: 'IbuHamil', 'IbuMenyusui', 'Batita'

  const RegistrationFormPage({super.key, required this.userRole});

  @override
  State<RegistrationFormPage> createState() => _RegistrationFormPageState();
}

class _RegistrationFormPageState extends State<RegistrationFormPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalSteps = 5;

  // GlobalKey untuk validasi Form di setiap langkah
  final List<GlobalKey<FormState>> _formKeys = List.generate(
    5,
    (_) => GlobalKey<FormState>(),
  );

  // Data yang akan dikumpulkan dari form (dummy data model)
  Map<String, dynamic> formData = {};

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  // Fungsi untuk mendapatkan widget form spesifik berdasarkan peran dan langkah
  Widget _getFormStep(int step) {
    // Step 0 adalah Biodata Dasar untuk semua peran
    if (step == 0) {
      return BiodataForm(
        formKey: _formKeys[step],
        onDataChanged: (key, value) => formData[key] = value,
      );
    }

    // Langkah-langkah kondisional (Step 1 hingga 4)
    switch (widget.userRole) {
      case 'IbuHamil':
        if (step == 1) {
          return IbuHamilFormStep1(
            formKey: _formKeys[step],
            onDataChanged: (key, value) => formData[key] = value,
          );
        } else if (step == 2) {
          return IbuHamilFormStep2(
            formKey: _formKeys[step],
            onDataChanged: (key, value) => formData[key] = value,
          );
        }
        // Asumsi step 3 dan 4 adalah informasi umum tambahan
        return _buildPlaceholderForm(step);
      case 'IbuMenyusui':
        // Implementasi form khusus Ibu Menyusui di sini
        return _buildPlaceholderForm(step);
      case 'Batita':
        // Implementasi form khusus Batita di sini
        return _buildPlaceholderForm(step);
      default:
        return _buildPlaceholderForm(step);
    }
  }

  // Fungsi untuk maju ke halaman berikutnya
  void _nextPage() {
    // Validasi form saat ini
    if (_formKeys[_currentPage].currentState!.validate()) {
      _formKeys[_currentPage].currentState!
          .save(); // Simpan data (jika menggunakan onSaved)

      if (_currentPage < _totalSteps - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeIn,
        );
      } else {
        _submitForm();
      }
    }
  }

  // Fungsi untuk mundur ke halaman sebelumnya
  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    } else {
      Navigator.pop(context); // Kembali ke halaman pilihan peran
    }
  }

  // Fungsi saat form selesai (Langkah terakhir)
  void _submitForm() {
    // 1. Kumpulkan semua data (sudah ada di 'formData')
    // 2. Kirim data ke backend/database (contoh: Firebase)
    print(
      "Data Pendaftaran Lengkap: ${formData}",
    ); // Debug: tampilkan data di console

    // 3. Navigasi ke Dashboard
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Pendaftaran untuk ${widget.userRole} berhasil!')),
    );

    // Asumsi nama pengguna ada di formData['username']
    String displayName = formData['username'] ?? "Pengguna Baru";

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => DashboardPage(userName: displayName),
      ),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color accentColor = Colors.teal.shade600;

    return Scaffold(
      appBar: AppBar(
        title: Text("Langkah ${_currentPage + 1} dari $_totalSteps"),
        backgroundColor: accentColor,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _previousPage,
        ),
      ),
      body: Column(
        children: [
          // Indikator Progres
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: LinearProgressIndicator(
              value: (_currentPage + 1) / _totalSteps,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation<Color>(accentColor),
            ),
          ),

          // PageView untuk Form
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics:
                  const NeverScrollableScrollPhysics(), // Nonaktifkan swipe manual
              itemCount: _totalSteps,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(32.0),
                  child: _getFormStep(index),
                );
              },
            ),
          ),

          // Tombol Navigasi
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 10, 32, 32),
            child: ElevatedButton(
              onPressed: _nextPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: accentColor,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                _currentPage == _totalSteps - 1 ? 'Selesai & Masuk' : 'Lanjut',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget Placeholder untuk langkah yang belum didefinisikan
  Widget _buildPlaceholderForm(int step) {
    return Form(
      key: _formKeys[step],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Langkah ${step + 1}: Informasi Tambahan",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Ini adalah formulir umum atau placeholder untuk peran ${widget.userRole}.",
            style: TextStyle(color: Colors.grey.shade700),
          ),
          const SizedBox(height: 30),
          TextFormField(
            decoration: const InputDecoration(labelText: "Nomor Telepon"),
            keyboardType: TextInputType.phone,
            validator: (value) =>
                value == null || value.isEmpty ? 'Field wajib diisi' : null,
            onSaved: (value) => formData['phone'] = value,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: "Alamat"),
            keyboardType: TextInputType.streetAddress,
            validator: (value) =>
                value == null || value.isEmpty ? 'Field wajib diisi' : null,
            onSaved: (value) => formData['address'] = value,
          ),
          // Tambahkan lebih banyak field umum di sini...
        ],
      ),
    );
  }
}
