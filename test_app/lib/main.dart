import 'package:flutter/material.dart';
import 'sideDrawer.dart';
import 'Screen/SplashScreen.dart';
import 'pdf_Viewer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'القرآن الكريم',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 107, 103, 112),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: sideDrawer_Page(),
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        toolbarHeight: 55,
        centerTitle: true,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.symmetric(vertical: 6),
          child: Text(
            'القرآن الكريم',
            style: TextStyle(
              fontSize: 26,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      // PDF viewer as the main content
      body: 
      // Text("Data"),
       const PdfViewerPage(),
    );
  }
}
