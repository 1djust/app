import 'dart:async';
import 'package:flutter/material.dart';
import 'intro_screen.dart';
import '../theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate loading process
    Timer(const Duration(seconds: 4), () {
      if (mounted) {
        // Navigate to Intro Screen after 4 seconds
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const IntroScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background Elements (Subtle Glow)
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: (isDark
                            ? AppColors.electricAccent
                            : AppColors.primaryGreen)
                        .withOpacity(0.1),
                    blurRadius: 60,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
            // Logo
            Image.asset(
              'assets/images/logo1.png',
              width: 120,
              height: 120,
            ),
            // Loading Indicator
            SizedBox(
              width: 150,
              height: 150,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  isDark ? AppColors.electricAccent : AppColors.primaryGreen,
                ),
                strokeWidth: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
