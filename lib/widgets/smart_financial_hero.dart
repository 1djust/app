import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'glow_card.dart';

class SmartFinancialHero extends StatelessWidget {
  final double totalBalance;
  final String currency;
  final double monthlySpend;
  final double spendChangePercentage;
  final String aiInsight;
  final VoidCallback onSend;
  final VoidCallback onRequest;
  final VoidCallback onConvert;
  final VoidCallback onPay;

  const SmartFinancialHero({
    super.key,
    required this.totalBalance,
    required this.currency,
    required this.monthlySpend,
    required this.spendChangePercentage,
    required this.aiInsight,
    required this.onSend,
    required this.onRequest,
    required this.onConvert,
    required this.onPay,
  });

  String _formatBalance(double balance) {
    return balance.toStringAsFixed(2).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GlowCard(
      glowColor: AppColors.glowBlue,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header / AI Insight
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.electricBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.auto_awesome,
                    color: AppColors.electricBlue, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  aiInsight,
                  style: TextStyle(
                    color: isDark ? AppColors.textMainDark : AppColors.textMain,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Total Balance
          Text(
            'Total Net Worth',
            style: TextStyle(
              color: isDark ? AppColors.textMutedDark : AppColors.textMuted,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: totalBalance),
            duration: const Duration(milliseconds: 1500),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return Text(
                '$currency ${_formatBalance(value)}',
                style: TextStyle(
                  color: isDark ? AppColors.textMainDark : AppColors.textMain,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1,
                ),
              );
            },
          ),
          const SizedBox(height: 16),

          // Monthly Spend Indicator
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: spendChangePercentage > 0
                      ? Colors.red.withOpacity(0.1)
                      : Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      spendChangePercentage > 0
                          ? Icons.trending_up
                          : Icons.trending_down,
                      color:
                          spendChangePercentage > 0 ? Colors.red : Colors.green,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${spendChangePercentage.abs().toStringAsFixed(1)}%',
                      style: TextStyle(
                        color: spendChangePercentage > 0
                            ? Colors.red
                            : Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'vs last month ($currency ${_formatBalance(monthlySpend)} spent)',
                style: TextStyle(
                  color: isDark ? AppColors.textHintDark : AppColors.textHint,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Quick Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildQuickAction(context, Icons.send_rounded, 'Send', onSend),
              _buildQuickAction(
                  context, Icons.download_rounded, 'Request', onRequest),
              _buildQuickAction(
                  context, Icons.currency_exchange, 'Convert', onConvert),
              _buildQuickAction(context, Icons.credit_card, 'Pay', onPay),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction(
      BuildContext context, IconData icon, String label, VoidCallback onTap) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.midnightSurfaceLighter,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withOpacity(0.08)),
            ),
            child: Icon(icon,
                color: isDark ? AppColors.textMainDark : AppColors.textMain,
                size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: isDark ? AppColors.textMutedDark : AppColors.textMuted,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
