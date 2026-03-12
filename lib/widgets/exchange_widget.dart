import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ExchangeWidget extends StatelessWidget {
  const ExchangeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.swap_horiz,
                      color: Colors.purple.shade400, size: 24),
                  const SizedBox(width: 12),
                  Text(
                    'Currency Exchange',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color:
                          isDark ? AppColors.textMainDark : AppColors.textMain,
                    ),
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.successDark.withOpacity(0.1)
                      : Colors.green.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: isDark
                          ? AppColors.successDark.withOpacity(0.2)
                          : Colors.green.shade200,
                      width: 0.5),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.auto_awesome,
                        color: Colors.green, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      'Good time to convert',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: isDark
                            ? AppColors.successDark
                            : Colors.green.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                  color: isDark ? AppColors.borderDark : AppColors.borderLight,
                  width: 0.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.3 : 0.03),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildCurrencyInput(
                        context: context,
                        label: 'NGN',
                        value: '160,522',
                        flagPath: 'assets/images/ngn.png',
                        isResult: true,
                        alignRight: false,
                      ),
                    ),
                    const SizedBox(width: 40),
                    Expanded(
                      child: _buildCurrencyInput(
                        context: context,
                        label: 'USD',
                        value: '100',
                        flagPath: 'assets/images/usd.png',
                        alignRight: true,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.midnightSurfaceLighter
                        : Colors.indigo.shade50,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: isDark ? AppColors.borderDark : Colors.white,
                        width: 2),
                  ),
                  child: Icon(Icons.swap_horiz,
                      color: Colors.indigo.shade400, size: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyInput({
    required BuildContext context,
    required String label,
    required String value,
    required String flagPath,
    bool isResult = false,
    bool alignRight = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment:
          alignRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
              alignRight ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!alignRight) ...[
              Image.asset(flagPath,
                  width: 16,
                  height: 16,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.public, size: 16)),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppColors.textMainDark : AppColors.textMain,
                ),
              ),
            ] else ...[
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppColors.textMainDark : AppColors.textMain,
                ),
              ),
              const SizedBox(width: 8),
              Image.asset(flagPath,
                  width: 16,
                  height: 16,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.public, size: 16)),
            ],
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isResult
                ? (isDark
                    ? AppColors.successDark.withOpacity(0.1)
                    : Colors.green.shade50.withOpacity(0.3))
                : (isDark
                    ? AppColors.midnightSurfaceLighter
                    : AppColors.surfaceLight),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
                color: isDark ? AppColors.borderDark : AppColors.borderLight,
                width: 1),
          ),
          alignment: alignRight ? Alignment.centerRight : Alignment.centerLeft,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: isResult
                  ? (isDark ? AppColors.successDark : Colors.green.shade700)
                  : (isDark ? AppColors.textMainDark : AppColors.textMain),
            ),
          ),
        ),
      ],
    );
  }
}
