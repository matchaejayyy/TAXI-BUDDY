import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/pages/auth_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // gina hide ya and system UI (like status bar and navigation bar))
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

 // gina delay ya ng execution 
    Future.delayed(const Duration(seconds: 5), () {
      // NAvigate if where makadto after sng splashscreen 
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const AuthPage(),
        ),
      );
    });
  }

  @override
  void dispose() {
    // ginabalik ya ang system UI sa default
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
// sa gif ni siyaaaa iya padding etc.
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.yellow, Colors.yellow],
          ),
        ),
        child: const Center(
          child: Padding(
            padding: EdgeInsets.all(50.0),
            // Adjust padding as needed
            child: Image(
                image: AssetImage('lib/logos/splash.gif')), // Use Image widget
          ),
        ),
      ),
    );
  }
}
