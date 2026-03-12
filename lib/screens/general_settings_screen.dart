import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../main.dart'; // import themeNotifier

class GeneralSettingsScreen extends StatefulWidget {
  const GeneralSettingsScreen({super.key});

  @override
  State<GeneralSettingsScreen> createState() => _GeneralSettingsScreenState();
}

class _GeneralSettingsScreenState extends State<GeneralSettingsScreen> {
  bool _faceIdLogin = false;
  bool _fingerprintLogin = true;
  bool _faceIdPayment = true;
  bool _fingerprintPayment = false;

  void _showAppearanceDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select Appearance',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildThemeOption('Light Mode', ThemeMode.light, Icons.light_mode),
            _buildThemeOption('Dark Mode', ThemeMode.dark, Icons.dark_mode),
            _buildThemeOption(
                'System Default', ThemeMode.system, Icons.settings_brightness),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(String title, ThemeMode mode, IconData icon) {
    final isSelected = themeNotifier.value == mode;
    return ListTile(
      leading: Icon(icon, color: isSelected ? AppColors.primaryGreen : null),
      title: Text(title,
          style: TextStyle(fontWeight: isSelected ? FontWeight.bold : null)),
      trailing: isSelected
          ? const Icon(Icons.check, color: AppColors.primaryGreen)
          : null,
      onTap: () {
        themeNotifier.value = mode;
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.backgroundDark : const Color(0xFFFBFBFB),
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
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(context, 'General'),
            const SizedBox(height: 16),
            _buildSection(
              items: [
                _buildSettingItem(
                  iconPath: 'assets/images/Notifications Settings.png',
                  iconBgColor: const Color(0xFFE6F9F3),
                  title: 'Notifications Settings',
                  onTap: () {},
                ),
                _buildSettingItem(
                  iconPath: 'assets/images/Appearance.png',
                  iconBgColor: const Color(0xFFF1EEFF),
                  title: 'Appearance',
                  onTap: _showAppearanceDialog,
                  isLast: true,
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildSectionHeader(context, 'Login Settings'),
            const SizedBox(height: 16),
            _buildSection(
              items: [
                _buildSettingItem(
                  iconPath: 'assets/images/Change Login PIN.png',
                  iconBgColor: const Color(0xFFE8F1FF),
                  title: 'Change Login PIN',
                  onTap: () {},
                ),
                _buildSettingItem(
                  iconPath: 'assets/images/Logout Settings.png',
                  iconBgColor: const Color(0xFFFFEFF2),
                  title: 'Logout Settings',
                  onTap: () {},
                ),
                _buildSwitchItem(
                  iconPath: 'assets/images/Login With Face ID.png',
                  iconBgColor: const Color(0xFFE1FBFF),
                  title: 'Login With Face ID',
                  value: _faceIdLogin,
                  onChanged: (val) => setState(() => _faceIdLogin = val),
                ),
                _buildSwitchItem(
                  iconPath: 'assets/images/Login With Fingerprint.png',
                  iconBgColor: const Color(0xFFFFF4E8),
                  title: 'Login With Fingerprint',
                  value: _fingerprintLogin,
                  onChanged: (val) => setState(() => _fingerprintLogin = val),
                  isLast: true,
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildSectionHeader(context, 'Payment Settings'),
            const SizedBox(height: 16),
            _buildSection(
              items: [
                _buildSettingItem(
                  iconPath: 'assets/images/Change Payment PIN.png',
                  iconBgColor: const Color(0xFFFFEFF2),
                  title: 'Change Payment PIN',
                  onTap: () {},
                ),
                _buildSettingItem(
                  iconPath: 'assets/images/Forgot Payment PIN.png',
                  iconBgColor: const Color(0xFFE1FBFF),
                  title: 'Forgot Payment PIN',
                  onTap: () {},
                ),
                _buildSwitchItem(
                  iconPath: 'assets/images/Pay With Face ID.png',
                  iconBgColor: const Color(0xFFE8F1FF),
                  title:
                      'Login With Face ID', // Mapped to the Label in screenshot
                  value: _faceIdPayment,
                  onChanged: (val) => setState(() => _faceIdPayment = val),
                ),
                _buildSwitchItem(
                  iconPath: 'assets/images/Pay With Fingerprint.png',
                  iconBgColor: const Color(0xFFFFF4E8),
                  title: 'Pay With Fingerprint',
                  value: _fingerprintPayment,
                  onChanged: (val) => setState(() => _fingerprintPayment = val),
                  isLast: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: isDark ? AppColors.textMainDark : Colors.grey[600],
      ),
    );
  }

  Widget _buildSection({required List<Widget> items}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColors.borderDark : Colors.grey[100]!,
        ),
      ),
      child: Column(
        children: items,
      ),
    );
  }

  Widget _buildSettingItem({
    required String iconPath,
    required Color iconBgColor,
    required String title,
    required VoidCallback onTap,
    bool isLast = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isDark ? iconBgColor.withOpacity(0.1) : iconBgColor,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Image.asset(
                    iconPath,
                    width: 24,
                    height: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color:
                          isDark ? AppColors.textMainDark : AppColors.textMain,
                    ),
                  ),
                ),
                Icon(Icons.chevron_right, color: Colors.grey[300], size: 28),
              ],
            ),
          ),
          if (!isLast) _buildDivider(),
        ],
      ),
    );
  }

  Widget _buildSwitchItem({
    required String iconPath,
    required Color iconBgColor,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    bool isLast = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: isDark ? iconBgColor.withOpacity(0.1) : iconBgColor,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  iconPath,
                  width: 24,
                  height: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.textMainDark : AppColors.textMain,
                  ),
                ),
              ),
              Switch(
                value: value,
                onChanged: onChanged,
                activeColor: Colors.white,
                activeTrackColor: const Color(0xFF15181A),
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.grey.shade200,
              ),
            ],
          ),
        ),
        if (!isLast) _buildDivider(),
      ],
    );
  }

  Widget _buildDivider() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Divider(
      height: 1,
      thickness: 1,
      color: isDark ? AppColors.borderDark : Colors.grey[100],
    );
  }
}
