import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'glass_container.dart';

class ActionDock extends StatelessWidget {
  final List<Map<String, dynamic>> actions;

  const ActionDock({
    super.key,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      clipBehavior: Clip.none,
      child: Row(
        children: actions.map((action) {
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GlassContainer(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(action['icon'],
                      color: AppColors.electricAccent, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    action['label'],
                    style: TextStyle(
                      color:
                          isDark ? AppColors.textMainDark : AppColors.textMain,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
