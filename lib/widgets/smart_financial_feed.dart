import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'glass_container.dart';

class SmartFinancialFeed extends StatelessWidget {
  final List<TransactionItem> recentTransactions;
  final String smartSummary;
  final VoidCallback onViewAll;

  const SmartFinancialFeed({
    super.key,
    required this.recentTransactions,
    required this.smartSummary,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // AI Summary Header
        GlassContainer(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          borderRadius: 16,
          child: Row(
            children: [
              const Icon(Icons.auto_awesome,
                  color: AppColors.electricAccent, size: 16),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  smartSummary,
                  style: TextStyle(
                    color: isDark ? AppColors.textMainDark : AppColors.textMain,
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Feed Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Activity',
              style: TextStyle(
                color: isDark ? AppColors.textMainDark : AppColors.textMain,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: onViewAll,
              child: const Text(
                'View All',
                style: TextStyle(
                  color: AppColors.electricAccent,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Transactions List
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: recentTransactions.length,
          separatorBuilder: (context, index) =>
              const Divider(color: Colors.white10, height: 24),
          itemBuilder: (context, index) {
            final tx = recentTransactions[index];
            return Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.midnightSurfaceLighter
                        : AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(tx.icon, color: tx.iconColor, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tx.title,
                        style: TextStyle(
                          color: isDark
                              ? AppColors.textMainDark
                              : AppColors.textMain,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        tx.subtitle,
                        style: TextStyle(
                          color: isDark
                              ? AppColors.textMutedDark
                              : AppColors.textMuted,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      tx.formattedAmount,
                      style: TextStyle(
                        color: tx.isPositive
                            ? Colors.green
                            : (isDark
                                ? AppColors.textMainDark
                                : AppColors.textMain),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tx.date,
                      style: TextStyle(
                        color: isDark
                            ? AppColors.textHintDark
                            : AppColors.textHint,
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ],
    );
  }
}

class TransactionItem {
  final String title;
  final String subtitle;
  final String formattedAmount;
  final String date;
  final IconData icon;
  final Color iconColor;
  final bool isPositive;

  TransactionItem({
    required this.title,
    required this.subtitle,
    required this.formattedAmount,
    required this.date,
    required this.icon,
    required this.iconColor,
    required this.isPositive,
  });
}
