import 'package:flutter/material.dart';

// --- WIDGET FORM DASAR (Langkah 1 / Step 0) ---

class BiodataForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Function(String key, dynamic value) onDataChanged;

  const BiodataForm({
    super.key,
    required this.formKey,
    required this.onDataChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Langkah 1: Bio Data Akun",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),

          // 1. Username
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Username',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
            validator: (value) {
              if (value == null || value.isEmpty || value.length < 3) {
                return 'Username minimal 3 karakter';
              }
              return null;
            },
            onSaved: (value) => onDataChanged('username', value),
          ),
          const SizedBox(height: 20),

          // 2. Email
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || !value.contains('@')) {
                return 'Masukkan format email yang valid';
              }
              return null;
            },
            onSaved: (value) => onDataChanged('email', value),
          ),
          const SizedBox(height: 20),

          // 3. Password
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.lock),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.length < 6) {
                return 'Password minimal 6 karakter';
              }
              return null;
            },
            onSaved: (value) => onDataChanged('password', value),
          ),
        ],
      ),
    );
  }
}

// --- WIDGET FORM KHUSUS IBU HAMIL (Langkah 2 / Step 1) ---

class IbuHamilFormStep1 extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Function(String key, dynamic value) onDataChanged;

  const IbuHamilFormStep1({
    super.key,
    required this.formKey,
    required this.onDataChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Langkah 2: Data Fisik Ibu Hamil",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            "Informasi ini diperlukan untuk perhitungan gizi yang tepat.",
          ),
          const SizedBox(height: 30),

          // 1. Usia Ibu
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Usia Ibu (Tahun)',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.cake),
            ),
            keyboardType: TextInputType.number,
            validator: (value) => value == null || int.tryParse(value) == null
                ? 'Masukkan usia yang valid'
                : null,
            onSaved: (value) => onDataChanged('usiaIbu', int.parse(value!)),
          ),
          const SizedBox(height: 20),

          // 2. Usia Kandungan
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Usia Kandungan (Minggu)',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.calendar_month),
            ),
            keyboardType: TextInputType.number,
            validator: (value) => value == null || int.tryParse(value) == null
                ? 'Masukkan usia kandungan (minggu)'
                : null,
            onSaved: (value) =>
                onDataChanged('usiaKandungan', int.parse(value!)),
          ),
          const SizedBox(height: 20),

          // 3. Berat Badan (Pre-Kehamilan/Saat ini)
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Berat Badan (kg)',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.scale),
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (value) =>
                value == null || double.tryParse(value) == null
                ? 'Masukkan berat badan yang valid'
                : null,
            onSaved: (value) =>
                onDataChanged('beratBadan', double.parse(value!)),
          ),
          const SizedBox(height: 20),

          // 4. Tinggi Badan
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Tinggi Badan (cm)',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.height),
            ),
            keyboardType: TextInputType.number,
            validator: (value) => value == null || int.tryParse(value) == null
                ? 'Masukkan tinggi badan yang valid'
                : null,
            onSaved: (value) => onDataChanged('tinggiBadan', int.parse(value!)),
          ),
        ],
      ),
    );
  }
}

// --- WIDGET FORM KHUSUS IBU HAMIL (Langkah 3 / Step 2) ---

class IbuHamilFormStep2 extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Function(String key, dynamic value) onDataChanged;

  const IbuHamilFormStep2({
    super.key,
    required this.formKey,
    required this.onDataChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Langkah 3: Pengukuran Antropometri",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text("Input pengukuran tubuh terbaru."),
          const SizedBox(height: 30),

          // 1. Lingkar Perut
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Lingkar Perut (cm)',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.fitness_center),
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (value) =>
                value == null || double.tryParse(value) == null
                ? 'Masukkan lingkar perut yang valid'
                : null,
            onSaved: (value) =>
                onDataChanged('lingkarPerut', double.parse(value!)),
          ),
          const SizedBox(height: 20),

          // 2. Lingkar Lengan Atas (LiLA)
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Lingkar Lengan Atas (LiLA, cm)',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.line_weight),
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (value) =>
                value == null || double.tryParse(value) == null
                ? 'Masukkan LiLA yang valid'
                : null,
            onSaved: (value) =>
                onDataChanged('lingkarLenganAtas', double.parse(value!)),
          ),
          const SizedBox(height: 20),

          // Tambahan field lain jika diperlukan untuk langkah 3
        ],
      ),
    );
  }
}
// --- WIDGET FORM KHUSUS BAYI (Langkah 2 / Step 1) ---