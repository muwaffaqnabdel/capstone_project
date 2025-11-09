import 'package:flutter/material.dart';

class RekomendasiPage extends StatelessWidget {
  final String mealType;
  const RekomendasiPage({super.key, required this.mealType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("rekomendasi $mealType"),
        backgroundColor: Colors.pink[200],
      ),
      body: Center(
        child: Text(
          "ini halaman rekomendasi makanan untuk $mealType",
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

// Fungsi untuk menentukan rekomendasi berdasarkan mealType
String _getMenuRecommendation(String mealType) {
  switch (mealType.toLowerCase()) {
    case 'breakfast':
      return '🍞 Roti gandum + Telur rebus + Susu rendah lemak';
    case 'lunch':
      return '🍛 Nasi + Ayam panggang + Sayur bayam + Air putih';
    case 'dinner':
      return '🥗 Salad sayur + Ikan kukus + Jus jeruk';
    default:
      return '🍽️ Pilih waktu maekan untuk melihat rekomendasi menu.';
  }
}
