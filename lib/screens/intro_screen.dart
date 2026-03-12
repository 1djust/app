import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'create_account_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with TickerProviderStateMixin {
  // Staggered entrance states
  bool _showGlobe = false;
  bool _showText = false;
  bool _showButtons = false;

  // Floating animation
  late AnimationController _floatingController;
  late Animation<double> _floatingAnimation;

  // Interactive scale
  double _scale = 1.0;

  @override
  void initState() {
    super.initState();

    // Initialize floating controller
    _floatingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _floatingAnimation = Tween<double>(begin: 0, end: 15.0).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
    );

    // Staggered entrance sequence
    _startEntranceSequence();
  }

  void _startEntranceSequence() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) setState(() => _showGlobe = true);

    await Future.delayed(const Duration(milliseconds: 600));
    if (mounted) setState(() => _showText = true);

    await Future.delayed(const Duration(milliseconds: 400));
    if (mounted) setState(() => _showButtons = true);
  }

  @override
  void dispose() {
    _floatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: Stack(
        children: [
          // Background Elements
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: Center(
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 800),
                      opacity: _showGlobe ? 1.0 : 0.0,
                      curve: Curves.easeOut,
                      child: GestureDetector(
                        onTapDown: (_) => setState(() => _scale = 0.95),
                        onTapUp: (_) => setState(() => _scale = 1.0),
                        onTapCancel: () => setState(() => _scale = 1.0),
                        child: AnimatedScale(
                          scale: _scale,
                          duration: const Duration(milliseconds: 100),
                          child: AnimatedBuilder(
                            animation: _floatingAnimation,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(0, -_floatingAnimation.value),
                                child: child,
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Image.asset(
                                'assets/images/2hero.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Typography Section
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: AnimatedSlide(
                      offset: _showText ? Offset.zero : const Offset(0, 0.2),
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeOutQuart,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 800),
                        opacity: _showText ? 1.0 : 0.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Global Financial\nEmpowerment',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                color: isDark
                                    ? AppColors.textMainDark
                                    : AppColors.textMain,
                                height: 1.1,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Access the world’s economy, anytime.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: isDark
                                    ? AppColors.textMutedDark
                                    : AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // CTA Section
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                  child: AnimatedSlide(
                    offset: _showButtons ? Offset.zero : const Offset(0, 0.5),
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeOutCubic,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 800),
                      opacity: _showButtons ? 1.0 : 0.0,
                      child: Column(
                        children: [
                          // Primary Button: Get Started
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CreateAccountScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isDark
                                    ? AppColors.electricAccent
                                    : AppColors.textMain,
                                foregroundColor: isDark
                                    ? AppColors.midnightBase
                                    : Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Get Started',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Secondary Button: Sign In
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: isDark
                                    ? AppColors.textMainDark
                                    : AppColors.textMain,
                                side: BorderSide(
                                  color: isDark
                                      ? AppColors.borderDark
                                      : AppColors.borderLight,
                                  width: 1.5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Sign In',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
