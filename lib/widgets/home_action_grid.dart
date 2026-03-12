import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class HomeActionGrid extends StatelessWidget {
  const HomeActionGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final List<Map<String, dynamic>> actions = [
      {
        'icon': Icons.near_me_outlined,
        'label': 'Send',
        'color': isDark ? Colors.green.withOpacity(0.1) : Colors.green.shade50,
        'iconColor': Colors.green
      },
      {
        'icon': Icons.description_outlined,
        'label': 'Invoice',
        'color': isDark ? Colors.blue.withOpacity(0.1) : Colors.blue.shade50,
        'iconColor': Colors.blue
      },
      {
        'icon': Icons.swap_horiz_outlined,
        'label': 'Convert',
        'color':
            isDark ? Colors.purple.withOpacity(0.1) : Colors.purple.shade50,
        'iconColor': Colors.purple
      },
      {
        'icon': Icons.bolt_outlined,
        'label': 'Bills & Airtime',
        'color':
            isDark ? Colors.orange.withOpacity(0.1) : Colors.orange.shade50,
        'iconColor': Colors.orange
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: actions.map((action) {
          return Column(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: action['color'],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  action['icon'],
                  color: action['iconColor'],
                  size: 28,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                action['label'],
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: isDark ? AppColors.textMainDark : AppColors.textMain,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
