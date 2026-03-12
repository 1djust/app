import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'login_screen.dart';
import 'logout_confirmation_modal.dart';
import 'general_settings_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => LogoutConfirmationModal(
        onConfirm: () {
          // Clear session logic here if needed
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, size: 32),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: isDark ? AppColors.textMainDark : AppColors.textMain,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: isDark ? AppColors.textMainDark : AppColors.textMain,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.textMainDark : Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                border: Border.all(
                  color: isDark ? AppColors.borderDark : Colors.grey[100]!,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  _buildItem(
                    context: context,
                    title: 'Your Profile',
                    subtitle: 'Manage your personal details',
                    iconPath:
                        'assets/images/User.png', // Changed to User for consistency
                    iconBgColor: const Color(0xFFE8F1FF),
                    onTap: () {},
                  ),
                  _buildDivider(context),
                  _buildItem(
                    context: context,
                    title: 'Other Information',
                    subtitle:
                        'Update additional details like occupation, address',
                    iconPath: 'assets/images/Other Information.png',
                    iconBgColor: const Color(0xFFF1EEFF),
                    onTap: () {},
                  ),
                  _buildDivider(context),
                  _buildItem(
                    context: context,
                    title: 'Verification',
                    subtitle:
                        'Submit required documents to verify your identity',
                    iconPath: 'assets/images/Verifications.png',
                    iconBgColor: const Color(0xFFE6F9F3),
                    onTap: () {},
                  ),
                  _buildDivider(context),
                  _buildItem(
                    context: context,
                    title: 'Account Limits',
                    subtitle: 'Manage how much you can transfer or receive',
                    iconPath: 'assets/images/Account Limits.png',
                    iconBgColor: const Color(0xFFFFF4E8),
                    onTap: () {},
                  ),
                  _buildDivider(context),
                  _buildItem(
                    context: context,
                    title: 'Manage Beneficiaries',
                    subtitle:
                        'Manage your beneficiaries you frequently send money to',
                    iconPath: 'assets/images/Manage Beneficiaries.png',
                    iconBgColor: const Color(0xFFF3F4F6),
                    onTap: () {},
                    isLast: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'General',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.textMainDark : Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                border: Border.all(
                  color: isDark ? AppColors.borderDark : Colors.grey[100]!,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  _buildItem(
                    context: context,
                    title: 'Settings',
                    subtitle: 'Change appearance, password, etc',
                    iconPath: 'assets/images/Settings.png',
                    iconBgColor: const Color(0xFFFFEFF2),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GeneralSettingsScreen(),
                        ),
                      );
                    },
                  ),
                  _buildDivider(context),
                  _buildItem(
                    context: context,
                    title: 'Two-Factor Authentication',
                    subtitle: 'Enhance account security with 2FA',
                    iconPath: 'assets/images/Two-Factor Authentication.png',
                    iconBgColor: const Color(0xFFE1FBFF),
                    onTap: () {},
                  ),
                  _buildDivider(context),
                  _buildItem(
                    context: context,
                    title: 'Support',
                    subtitle: 'Access help whenever you need assistance',
                    iconPath: 'assets/images/Support.png',
                    iconBgColor: const Color(0xFFE8F1FF),
                    onTap: () {},
                  ),
                  _buildDivider(context),
                  _buildItem(
                    context: context,
                    title: 'FAQ',
                    subtitle:
                        'Need help? Explore our most asked questions below.',
                    iconPath: 'assets/images/faq.png',
                    iconBgColor: const Color(0xFFFFF7E8),
                    onTap: () {},
                    isLast: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            Center(
              child: InkWell(
                onTap: () => _handleLogout(context),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color:
                        const Color(0xFFFFEBEE).withOpacity(isDark ? 0.1 : 1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logout.png',
                        width: 20,
                        height: 20,
                        color: Colors.red[400],
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Sign Out',
                        style: TextStyle(
                          color: Colors.red[400],
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                'v 1.0',
                style: TextStyle(
                  color: isDark ? AppColors.textMutedDark : Colors.grey[400],
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Divider(
      height: 1,
      thickness: 1,
      color: isDark ? AppColors.borderDark : Colors.grey[100],
    );
  }

  Widget _buildItem({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String iconPath,
    required VoidCallback onTap,
    Color? iconBgColor,
    bool isLast = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: iconBgColor != null
                    ? (isDark ? iconBgColor.withOpacity(0.1) : iconBgColor)
                    : (isDark ? AppColors.backgroundDark : Colors.grey[50]),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Image.asset(
                iconPath,
                width: 24,
                height: 24,
                color: iconBgColor != null && !isDark
                    ? null
                    : null, // Original colors
                errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.settings,
                    size: 24,
                    color: isDark ? Colors.white30 : Colors.grey),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? AppColors.textMainDark
                          : const Color(0xFF15181A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color:
                          isDark ? AppColors.textMutedDark : Colors.grey[500],
                      height: 1.2,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey[300], size: 28),
          ],
        ),
      ),
    );
  }
}
