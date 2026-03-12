import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class HomeHeader extends StatelessWidget {
  final String userName;
  final String? profileImageUrl;
  final VoidCallback onProfileTap;
  final VoidCallback onNotificationTap;

  const HomeHeader({
    super.key,
    required this.userName,
    this.profileImageUrl,
    required this.onProfileTap,
    required this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: onProfileTap,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor:
                      isDark ? AppColors.surfaceDark : AppColors.borderLight,
                  backgroundImage: profileImageUrl != null
                      ? AssetImage(profileImageUrl!)
                      : const AssetImage('assets/images/User.png'),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.surfaceDark : Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.edit_outlined,
                      size: 10,
                      color:
                          isDark ? AppColors.textMainDark : AppColors.textMuted,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'Hi, $userName',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: isDark ? AppColors.textMainDark : AppColors.textMain,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onNotificationTap,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                shape: BoxShape.circle,
              ),
              child: Stack(
                children: [
                  Icon(
                    Icons.notifications_none_outlined,
                    size: 28,
                    color:
                        isDark ? AppColors.textMainDark : AppColors.textMuted,
                  ),
                  Positioned(
                    right: 4,
                    top: 4,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.orangeAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
