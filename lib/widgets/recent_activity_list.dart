import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class RecentActivityList extends StatelessWidget {
  const RecentActivityList({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final List<Map<String, dynamic>> activities = [
      {
        'title': 'Sent to Adebayo',
        'subtitle': 'Transfer',
        'amount': '-NGN 50,000',
        'time': '2 min ago',
        'icon': Icons.north_east,
        'color': isDark ? Colors.red.withOpacity(0.1) : Colors.red.shade50,
      },
      {
        'title': 'Received from Chidi',
        'subtitle': 'Transfer',
        'amount': '+NGN 120,000',
        'time': '1 hr ago',
        'icon': Icons.south_west,
        'color': isDark ? Colors.green.withOpacity(0.1) : Colors.green.shade50,
      },
      {
        'title': 'IKEDC Prepaid',
        'subtitle': 'Electricity',
        'amount': '-NGN 15,000',
        'time': '3 hrs ago',
        'icon': Icons.bolt,
        'color':
            isDark ? Colors.orange.withOpacity(0.1) : Colors.orange.shade50,
      },
      {
        'title': 'Shoprite',
        'subtitle': 'Shopping',
        'amount': '-NGN 28,400',
        'time': 'Yesterday',
        'icon': Icons.shopping_bag_outlined,
        'color': isDark ? Colors.pink.withOpacity(0.1) : Colors.pink.shade50,
      },
      {
        'title': 'Cafe Neo',
        'subtitle': 'Food & Drink',
        'amount': '-NGN 3,500',
        'time': 'Yesterday',
        'icon': Icons.coffee_outlined,
        'color':
            isDark ? Colors.purple.withOpacity(0.1) : Colors.purple.shade50,
      },
      {
        'title': 'MTN Data',
        'subtitle': 'Airtime & Data',
        'amount': '-NGN 5,000',
        'time': '2 days ago',
        'icon': Icons.wifi,
        'color': isDark ? Colors.blue.withOpacity(0.1) : Colors.blue.shade50,
      },
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Activity',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: isDark ? AppColors.textMainDark : AppColors.textMain,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'See All',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: activities.length,
          itemBuilder: (context, index) {
            final activity = activities[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: activity['color'],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      activity['icon'],
                      color: activity['iconColor'],
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          activity['title'],
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? AppColors.textMainDark
                                : AppColors.textMain,
                          ),
                        ),
                        Text(
                          activity['subtitle'],
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark
                                ? AppColors.textMutedDark
                                : AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        activity['amount'],
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: activity['amount'].startsWith('+')
                              ? Colors.green
                              : (isDark
                                  ? AppColors.textMainDark
                                  : AppColors.textMain),
                        ),
                      ),
                      Text(
                        activity['time'],
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark
                              ? AppColors.textHintDark
                              : AppColors.textHint,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
