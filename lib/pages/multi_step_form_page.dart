import 'package:flutter/material.dart';
import 'dashboard_page.dart';

class MultiStepFormPage extends StatefulWidget {
  final String userRole; // 'IbuHamil', 'IbuMenyusui', atau 'Batita'

  const MultiStepFormPage({Key? key, required this.userRole}) : super(key: key);

  @override
  State<MultiStepFormPage> createState() => _MultiStepFormPageState();
}

class _MultiStepFormPageState extends State<MultiStepFormPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalSteps = 5;

  // GlobalKey untuk validasi Form di setiap langkah
  final List<GlobalKey<FormState>> _formKeys = List.generate(
    5,
    (_) => GlobalKey<FormState>(),
  );

  // Data yang dikumpulkan dari form
  Map<String, dynamic> formData = {};

  // Dropdown values
  String? selectedUsiaKehamilan;
  String? selectedUsiaBatita;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  // Fungsi untuk mendapatkan widget form berdasarkan peran dan langkah
  Widget _getFormStep(int step) {
    switch (widget.userRole) {
      case 'IbuHamil':
        return _buildIbuHamilForm(step);
      case 'IbuMenyusui':
        return _buildIbuMenyusuiForm(step);
      case 'Batita':
        return _buildBatitaForm(step);
      default:
        return _buildDefaultForm(step);
    }
  }

  // Form untuk Ibu Hamil (5 langkah)
  Widget _buildIbuHamilForm(int step) {
    switch (step) {
      case 0:
        return _buildFormTemplate(
          step: step,
          title: "Langkah 1: Data Pribadi",
          fields: [
            _buildTextField("Nama Lengkap", "nama", TextInputType.name),
            _buildTextField("Usia", "usia", TextInputType.number),
            _buildTextField("Alamat", "alamat", TextInputType.streetAddress),
          ],
        );
      case 1:
        return Form(
          key: _formKeys[step],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Langkah 2: Data Kehamilan",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade700,
                ),
              ),
              SizedBox(height: 24),
              Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Usia Kehamilan",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                  value: selectedUsiaKehamilan,
                  items: List.generate(42, (index) {
                    String week = "${index + 1} Minggu";
                    return DropdownMenuItem<String>(
                      value: week,
                      child: Text(week),
                    );
                  }),
                  onChanged: (value) {
                    setState(() {
                      selectedUsiaKehamilan = value;
                      formData['usia_kehamilan'] = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Usia kehamilan wajib dipilih';
                    }
                    return null;
                  },
                ),
              ),
              _buildTextField(
                "Berat Badan (kg)",
                "berat_badan",
                TextInputType.number,
              ),
              _buildTextField(
                "Tinggi Badan (cm)",
                "tinggi_badan",
                TextInputType.number,
              ),
            ],
          ),
        );
      case 2:
        return _buildFormTemplate(
          step: step,
          title: "Langkah 3: Riwayat Kesehatan",
          fields: [
            _buildTextField(
              "Riwayat Penyakit",
              "riwayat_penyakit",
              TextInputType.text,
            ),
            _buildTextField(
              "Alergi Obat/Makanan",
              "alergi",
              TextInputType.text,
            ),
            _buildTextField(
              "Golongan Darah",
              "golongan_darah",
              TextInputType.text,
            ),
          ],
        );
      case 3:
        return _buildFormTemplate(
          step: step,
          title: "Langkah 4: Pola Makan",
          fields: [
            _buildTextField(
              "Frekuensi Makan per Hari",
              "frekuensi_makan",
              TextInputType.number,
            ),
            _buildTextField(
              "Jenis Makanan Favorit",
              "makanan_favorit",
              TextInputType.text,
            ),
            _buildTextField(
              "Makanan yang Dihindari",
              "makanan_dihindari",
              TextInputType.text,
            ),
          ],
        );
      case 4:
        return _buildFormTemplate(
          step: step,
          title: "Langkah 5: Kontak Darurat",
          fields: [
            _buildTextField(
              "Nama Kontak Darurat",
              "nama_darurat",
              TextInputType.name,
            ),
            _buildTextField(
              "No. Telepon Darurat",
              "telp_darurat",
              TextInputType.phone,
            ),
            _buildTextField("Hubungan", "hubungan_darurat", TextInputType.text),
          ],
        );
      default:
        return Container();
    }
  }

  // Form untuk Ibu Menyusui (5 langkah)
  Widget _buildIbuMenyusuiForm(int step) {
    switch (step) {
      case 0:
        return _buildFormTemplate(
          step: step,
          title: "Langkah 1: Data Pribadi",
          fields: [
            _buildTextField("Nama Lengkap", "nama", TextInputType.name),
            _buildTextField("Usia", "usia", TextInputType.number),
            _buildTextField("Alamat", "alamat", TextInputType.streetAddress),
          ],
        );
      case 1:
        return _buildFormTemplate(
          step: step,
          title: "Langkah 2: Data Bayi",
          fields: [
            _buildTextField("Nama Bayi", "nama_bayi", TextInputType.name),
            _buildTextField(
              "Usia Bayi (bulan)",
              "usia_bayi",
              TextInputType.number,
            ),
            _buildTextField(
              "Berat Badan Bayi (kg)",
              "bb_bayi",
              TextInputType.number,
            ),
          ],
        );
      case 2:
        return _buildFormTemplate(
          step: step,
          title: "Langkah 3: Pola Menyusui",
          fields: [
            _buildTextField(
              "Frekuensi Menyusui per Hari",
              "frekuensi_menyusui",
              TextInputType.number,
            ),
            _buildTextField(
              "ASI Eksklusif? (Ya/Tidak)",
              "asi_eksklusif",
              TextInputType.text,
            ),
            _buildTextField(
              "Kesulitan Menyusui?",
              "kesulitan",
              TextInputType.text,
            ),
          ],
        );
      case 3:
        return _buildFormTemplate(
          step: step,
          title: "Langkah 4: Pola Makan Ibu",
          fields: [
            _buildTextField(
              "Frekuensi Makan per Hari",
              "frekuensi_makan",
              TextInputType.number,
            ),
            _buildTextField(
              "Konsumsi Vitamin/Suplemen",
              "vitamin",
              TextInputType.text,
            ),
            _buildTextField(
              "Makanan yang Dihindari",
              "makanan_dihindari",
              TextInputType.text,
            ),
          ],
        );
      case 4:
        return _buildFormTemplate(
          step: step,
          title: "Langkah 5: Kontak Darurat",
          fields: [
            _buildTextField(
              "Nama Kontak Darurat",
              "nama_darurat",
              TextInputType.name,
            ),
            _buildTextField(
              "No. Telepon Darurat",
              "telp_darurat",
              TextInputType.phone,
            ),
            _buildTextField("Hubungan", "hubungan_darurat", TextInputType.text),
          ],
        );
      default:
        return Container();
    }
  }

  // Form untuk Batita (5 langkah)
  Widget _buildBatitaForm(int step) {
    switch (step) {
      case 0:
        return _buildFormTemplate(
          step: step,
          title: "Langkah 1: Data Anak",
          fields: [
            _buildTextField("Nama Anak", "nama_anak", TextInputType.name),
            _buildTextField(
              "Usia Anak (bulan)",
              "usia_anak",
              TextInputType.number,
            ),
            _buildTextField(
              "Jenis Kelamin",
              "jenis_kelamin",
              TextInputType.text,
            ),
          ],
        );
      case 1:
        return _buildFormTemplate(
          step: step,
          title: "Langkah 2: Data Fisik",
          fields: [
            _buildTextField(
              "Berat Badan (kg)",
              "berat_badan",
              TextInputType.number,
            ),
            _buildTextField(
              "Tinggi Badan (cm)",
              "tinggi_badan",
              TextInputType.number,
            ),
            _buildTextField(
              "Lingkar Kepala (cm)",
              "lingkar_kepala",
              TextInputType.number,
            ),
          ],
        );
      case 2:
        return _buildFormTemplate(
          step: step,
          title: "Langkah 3: Riwayat Kesehatan",
          fields: [
            _buildTextField(
              "Riwayat Penyakit",
              "riwayat_penyakit",
              TextInputType.text,
            ),
            _buildTextField("Alergi", "alergi", TextInputType.text),
            _buildTextField(
              "Imunisasi Terakhir",
              "imunisasi",
              TextInputType.text,
            ),
          ],
        );
      case 3:
        return _buildFormTemplate(
          step: step,
          title: "Langkah 4: Pola Makan",
          fields: [
            _buildTextField(
              "Frekuensi Makan per Hari",
              "frekuensi_makan",
              TextInputType.number,
            ),
            _buildTextField(
              "Jenis Makanan Utama",
              "makanan_utama",
              TextInputType.text,
            ),
            _buildTextField(
              "Makanan yang Dihindari",
              "makanan_dihindari",
              TextInputType.text,
            ),
          ],
        );
      case 4:
        return _buildFormTemplate(
          step: step,
          title: "Langkah 5: Data Orang Tua",
          fields: [
            _buildTextField("Nama Orang Tua", "nama_ortu", TextInputType.name),
            _buildTextField("No. Telepon", "telp_ortu", TextInputType.phone),
            _buildTextField("Alamat", "alamat", TextInputType.streetAddress),
          ],
        );
      default:
        return Container();
    }
  }

  // Template form
  Widget _buildFormTemplate({
    required int step,
    required String title,
    required List<Widget> fields,
  }) {
    return Form(
      key: _formKeys[step],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade700,
            ),
          ),
          SizedBox(height: 24),
          ...fields,
        ],
      ),
    );
  }

  // Widget Dropdown reusable (untuk referensi jika diperlukan nanti)

  // Widget TextField reusable
  Widget _buildTextField(String label, String key, TextInputType inputType) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.grey[50],
        ),
        keyboardType: inputType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label wajib diisi';
          }
          return null;
        },
        onSaved: (value) => formData[key] = value,
      ),
    );
  }

  Widget _buildDefaultForm(int step) {
    return _buildFormTemplate(
      step: step,
      title: "Langkah ${step + 1}",
      fields: [
        _buildTextField("Field 1", "field1", TextInputType.text),
        _buildTextField("Field 2", "field2", TextInputType.text),
      ],
    );
  }

  // Navigasi ke halaman berikutnya
  void _nextPage() {
    if (_formKeys[_currentPage].currentState!.validate()) {
      _formKeys[_currentPage].currentState!.save();

      if (_currentPage < _totalSteps - 1) {
        _pageController.nextPage(
          duration: Duration(milliseconds: 400),
          curve: Curves.easeIn,
        );
      } else {
        _submitForm();
      }
    }
  }

  // Navigasi ke halaman sebelumnya
  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    } else {
      Navigator.pop(context);
    }
  }

  // Submit form terakhir
  void _submitForm() {
    print("Data Lengkap ${widget.userRole}: $formData");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Pendaftaran ${widget.userRole} berhasil!'),
        backgroundColor: Colors.green,
      ),
    );

    String displayName =
        formData['nama'] ?? formData['nama_anak'] ?? widget.userRole;

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
          icon: Icon(Icons.arrow_back),
          onPressed: _previousPage,
        ),
      ),
      body: Column(
        children: [
          // Progress Indicator
          Padding(
            padding: EdgeInsets.all(16.0),
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
              physics: NeverScrollableScrollPhysics(),
              itemCount: _totalSteps,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  padding: EdgeInsets.all(32.0),
                  child: _getFormStep(index),
                );
              },
            ),
          ),

          // Tombol Navigasi
          Padding(
            padding: EdgeInsets.fromLTRB(32, 10, 32, 32),
            child: ElevatedButton(
              onPressed: _nextPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: accentColor,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                _currentPage == _totalSteps - 1 ? 'Selesai & Masuk' : 'Lanjut',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
