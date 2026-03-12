import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../theme/app_colors.dart';

class VerificationStatusScreen extends StatelessWidget {
  const VerificationStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      // Main Image
                      Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.surfaceLight,
                          border: Border.all(
                              color: AppColors.borderLight, width: 2),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/Verification.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.verified_user,
                                    size: 80, color: AppColors.primaryGreen),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Title
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Verification In Progress',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textMain,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text('⏳', style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      const SizedBox(height: 16),

                      const Text(
                        'Thank you for completing your verification.\nOur compliance team is currently reviewing your information.\nThis process will take less than to 48 hours.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textMuted,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // What happens next
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'What happens next?',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textMain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      _buildStep(
                        number: '1',
                        title: 'Compliance Review',
                        description:
                            'Our compliance team will review your KYC documents and assign a risk rating',
                      ),
                      const SizedBox(height: 20),
                      _buildStep(
                        number: '2',
                        title: 'Account Creation',
                        description:
                            'Upon approval, your account(s) will be created based on your risk profile',
                      ),
                      const SizedBox(height: 20),
                      _buildStep(
                        number: '3',
                        title: 'Email Notification',
                        description:
                            'You\'ll receive an email with your account details and next steps',
                      ),

                      const SizedBox(height: 40),

                      // Need help
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          const Icon(
                            Icons.help_outline,
                            size: 16,
                            color: AppColors.textMuted,
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'Need help? ',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textMuted,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Action
                            },
                            child: const Text(
                              'support@figuresapp.com',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
              // Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.textMain,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Back to Log In',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep({
    required String number,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Text(
            number,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: AppColors.textMain,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: AppColors.textMain,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                    fontSize: 13, color: AppColors.textMuted, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
