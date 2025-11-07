import 'package:flutter/material.dart';
import 'pages/dashboard_page.dart';
import 'pages/login_page.dart';
import 'pages/rekomendasi_page.dart';
import 'pages/scan_page.dart';
import 'pages/chatbot_page.dart';
import 'pages/edukasi_page.dart';

void main() {
  runApp(const BundaCareApp());
}

class BundaCareApp extends StatelessWidget {
  const BundaCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bunda Care',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF6CC4A1),
      ),
      home: const LoginPage(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    DashboardPage(),
    RekomendasiPage(),
    ScanPage(),
    ChatbotPage(),
    EdukasiPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.restaurant_menu_outlined),
            label: 'Rekomendasi',
          ),
          NavigationDestination(
            icon: Icon(Icons.camera_alt_outlined),
            label: 'Scan',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chatbot',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            label: 'Edukasi',
          ),
        ],
      ),
    );
  }
}
