import 'package:flutter/material.dart';
import '../main.dart'; // Make sure path is correct

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    // Delay then navigate
    Future.delayed(const Duration(seconds: 2), () {
      _navigateToHome();
    });
  }

  // Navigation to Home Page
  void _navigateToHome() {
    try {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const MyHomePage(title: 'القرآن الكريم'),
        ),
      );
    } catch (e) {
      debugPrint('Navigation error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load the app')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildSplashContent(),
    );
  }

  // Splash Content (Image)
  Widget _buildSplashContent() {
    return Center(
      child: Image.asset(
        'assets/images/image1.jpg',
        fit: BoxFit.contain,
        width: 250,      // You can adjust
        height: 250,     // You can adjust
        errorBuilder: (_, __, ___) =>
            const Text("⚠️ Logo not found", style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
