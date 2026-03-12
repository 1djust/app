import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ExchangeWidget extends StatefulWidget {
  const ExchangeWidget({super.key});

  @override
  State<ExchangeWidget> createState() => _ExchangeWidgetState();
}

class _ExchangeWidgetState extends State<ExchangeWidget> {
  String fromCurrency = 'GBP';
  String toCurrency = 'NGN';
  double fromAmount = 100.0;

  final Map<String, Map<String, double>> _rates = {
    'GBP': {'NGN': 2045.50, 'EUR': 1.18, 'GBP': 1.0},
    'EUR': {'NGN': 1710.20, 'GBP': 0.85, 'EUR': 1.0},
    'NGN': {'GBP': 0.00049, 'EUR': 0.00058, 'NGN': 1.0},
  };

  final Map<String, String> _flags = {
    'GBP': 'assets/images/gbp.png',
    'NGN': 'assets/images/ngn.png',
    'EUR': 'assets/images/eur.png',
  };

  double get toAmount =>
      fromAmount * (_rates[fromCurrency]?[toCurrency] ?? 1.0);

  String _formatNumber(double val) {
    return val
        .toStringAsFixed(fromAmount == fromAmount.toInt() ? 0 : 2)
        .replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }

  void _showCurrencySelector(bool isFrom) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.surfaceDark
              : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['NGN', 'GBP', 'EUR'].map((currency) {
            return ListTile(
              leading: Image.asset(
                _flags[currency]!,
                width: 24,
                height: 24,
                errorBuilder: (_, __, ___) => const Icon(Icons.public),
              ),
              title: Text(currency,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                setState(() {
                  if (isFrom) {
                    fromCurrency = currency;
                  } else {
                    toCurrency = currency;
                  }
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

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
                      child: GestureDetector(
                        onTap: () => _showCurrencySelector(false),
                        child: _buildCurrencyInput(
                          context: context,
                          label: toCurrency,
                          value: _formatNumber(toAmount),
                          flagPath: _flags[toCurrency]!,
                          isResult: true,
                          alignRight: false,
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _showCurrencySelector(true),
                        child: _buildCurrencyInput(
                          context: context,
                          label: fromCurrency,
                          value: _formatNumber(fromAmount),
                          flagPath: _flags[fromCurrency]!,
                          alignRight: true,
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      final temp = fromCurrency;
                      fromCurrency = toCurrency;
                      toCurrency = temp;
                    });
                  },
                  child: Container(
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
          children: alignRight
              ? [
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
                      color:
                          isDark ? AppColors.textMainDark : AppColors.textMain,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.keyboard_arrow_down,
                      size: 14, color: Colors.grey),
                ]
              : [
                  const Icon(Icons.keyboard_arrow_down,
                      size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color:
                          isDark ? AppColors.textMainDark : AppColors.textMain,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Image.asset(flagPath,
                      width: 16,
                      height: 16,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.public, size: 16)),
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
